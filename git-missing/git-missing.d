#!/usr/bin/rdmd --shebang -L-lgit2
module git_missing;
static import git2;
import std.exception : enforce;
import std.json : JSONValue;
import std.typecons : Nullable, nullable, Tuple, Rebindable;
import std.experimental.logger;
import common.console_logger;
import common.console : getch;
import std.path : buildPath, buildNormalizedPath, extension;
import std.meta : Alias;
import std.algorithm : startsWith, endsWith;
import core.stdc.stdlib : EXIT_SUCCESS, EXIT_FAILURE;

private:
ref auto fun(alias a)()
{
    return a();
}

Nullable!JSONValue findAndOpenCompileDatabase()
{
    import std.file : getcwd, exists, read;
    import std.json : parseJSON, JSONType;

    auto curr = getcwd();
    while (curr != "/")
    {
        immutable cdb_path = buildPath(curr, "compile_commands.json");
        if (cdb_path.exists)
        {
            auto cdb = parseJSON(cast(char[])(cdb_path.read));
            if (cdb.type != JSONType.array)
            {
                // Broken database?
                break;
            }
            return cdb.nullable;
        }
        if (buildPath(curr, ".git").exists)
        {
            // We reached the git root
            break;
        }
        curr = buildNormalizedPath(curr, "..");
    }
    return Nullable!JSONValue.init;
}

dstring[] splitShellCommand(string cmd)
{
    dstring[] ret;
    struct Separator
    {
    }

    struct Argument
    {
        dstring str;
    }

    struct Quoted
    {
        dstring str;
    }

    import std.variant : Algebraic, visit;

    alias State = Algebraic!(Separator, Argument, Quoted);
    struct Symbol
    {
        dchar symbol;
        bool literal;
    }

    Nullable!Symbol nextSymbol(ref string str)
    {
        if (str.length <= 0)
        {
            return Nullable!Symbol.init;
        }
        if (str[0] == '\\')
        {
            if (str.length == 1)
            {
                return Nullable!Symbol.init;
            }
            auto ret = Symbol(str[1], true);
            str = str[2 .. $];
            return ret.nullable;
        }
        else
        {
            auto ret = Symbol(str[0], false);
            str = str[1 .. $];
            return ret.nullable;
        }
    }

    State state = Separator();
    while (true)
    {
        immutable sym_ = nextSymbol(cmd);
        if (sym_.isNull)
        {
            assert(state.peek!Quoted is null);
            auto arg = state.peek!Argument;
            if (arg !is null)
            {
                ret ~= arg.str;
            }
            break;
        }

        immutable sym = sym_.get;
        state = state.visit!((Separator _) {
            if (sym.literal)
            {
                return State(Argument([sym.symbol].idup));

            }
            else
            {
                switch (sym.symbol)
                {
                case ' ':
                    return State(Separator());
                case '"':
                    return State(Quoted(""));
                default:
                    return State(Argument([sym.symbol].idup));
                }

            }
        }, (Argument arg) {
            if (sym.literal)
            {
                return State(Argument(arg.str ~ sym.symbol));
            }
            else
            {
                switch (sym.symbol)
                {
                case ' ':
                    ret ~= arg.str;
                    return State(Separator());
                case '"':
                    return State(Quoted(arg.str));
                default:
                    return State(Argument(arg.str ~ sym.symbol));

                }
            }
        }, (Quoted q) {
            if (sym.literal)
            {
                return State(Quoted(q.str ~ sym.symbol));
            }
            else
            {
                switch (sym.symbol)
                {
                case ' ':
                default:
                    return State(Quoted(q.str ~ sym.symbol));
                case '"':
                    return State(Argument(q.str));
                }
            }

        });
    }
    return ret;
}

unittest
{
    import std.algorithm : equal;

    auto p = "asdf\\    \\  asdf\"asdf\\\"\"".splitShellCommand;
    assert(equal(p, ["asdf "d, " "d, "asdfasdf\""d]));
}

struct CompileOpts
{
    dstring compiler;
    dstring[] options;
}

CompileOpts getCompileOptionsFor(ref immutable Nullable!JSONValue cdb_, string file, out bool guessed)
{
    import std.json : JSONType;
    import std.algorithm : map, commonPrefix;

    debug import std.stdio; // @suppress(dscanner.suspicious.local_imports)

    guessed = false;
    if (cdb_.isNull)
    {
        return CompileOpts.init;
    }

    import std.path : buildNormalizedPath, dirName;
    import std.conv : to;

    // First, we look for an exact match
    auto cdb = &cdb_.get();
    const(JSONValue[string])* best;
    foreach (ref entry_; cdb.array)
    {
        alias entry = fun!(ref() => entry_.object);
        immutable path = buildNormalizedPath(entry["directory"].str, entry["file"].str);
        if (path == file)
        {
            best = &entry();
        }
    }

    // If not find something that's close to it
    if (best is null)
    {
        immutable dir_name = file.dirName;
        ulong best_len = 0;
        foreach (entry_; cdb.array)
        {
            alias entry = fun!(ref() => entry_.object);
            auto dir = buildNormalizedPath(entry["directory"].str, entry["file"].str).dirName;
            if (dir_name.commonPrefix(dir).length > best_len)
            {
                best_len = dir_name.commonPrefix(dir).length;
                best = &entry();
                guessed = true;
            }
        }
    }

    if (best is null)
    {
        return CompileOpts.init;
    }

    dstring[] ret;
    if ("arguments" in *best)
    {
        import std.array : array;

        ret = (*best)["arguments"].array.map!"a.str.to!dstring".array;
    }
    ret = (*best)["command"].str.splitShellCommand;
    tracef("%s", ret);
    return ret.filterOptions((*best)["directory"].str);
}

enum bool[dstring] COMPILERS = [
        "c++"d : true, "cc"d : true, "g++"d : true, "gcc"d : true,
        "clang"d : true, "clang++"d : true
    ];
enum bool[string] EXTENSIONS = [
        ".c" : true, ".cc" : true, ".cxx" : true, ".cpp" : true, ".c++" : true,
    ];

CompileOpts filterOptions(dstring[] input, string directory)
{
    import std.path : isAbsolute;

    ulong i = 0;
    dstring[] ret;
    dstring compiler;

    while (i < input.length)
    {
        if (input[i].startsWith("-"d))
        {
            break;
        }
        if (input[i] in COMPILERS)
        {
            compiler = input[i];
        }
        i++;
    }

    for (; i < input.length; i++)
    {
        import std.path : buildNormalizedPath;
        import std.conv : to;

        if (!input[i].startsWith("-"d))
        {
            continue;
        }
        if (input[i] == "-Xclang"d || input[i] == "-o"d || input[i] == "-MQ"d || input[i] == "-MF"d)
        {
            i++;
            continue;
        }
        if (input[i].startsWith("-f"d) || input[i].startsWith("-W"d)
                || input[i].startsWith("-M"d) || input[i] == "-pipe"d || input[i] == "-c"d)
        {
            continue;
        }

        // Transform include directories into absolute paths
        if (input[i] == "-I"d || input[i] == "-isystem"d)
        {
            if (input[i + 1].isAbsolute)
            {
                ret ~= [input[i], input[i + 1]];
                i++;
            }
            else
            {
                ret ~= [
                    input[i],
                    buildNormalizedPath(directory.to!dstring, input[i + 1])
                ];
                i++;
            }
        }
        else if (input[i].startsWith("-I"d))
        {
            if (input[i][2 .. $].isAbsolute)
            {
                ret ~= input[i];
            }
            else
            {
                ret ~= "-I"d ~ buildNormalizedPath(directory.to!dstring, input[i][2 .. $]);
            }
        }
        else
        {
            ret ~= input[i];
        }
    }
    return CompileOpts(compiler, ret);
}

dstring[] getDependency(string file, in ref CompileOpts opt)
{
    import std.process : pipeProcess, pipe, Redirect;
    import std.array : array;
    import std.algorithm : map;
    import std.conv : to;

    enum PREFIX = "gitmissing"d;
    auto opts = opt.compiler ~ opt.options ~ [
        "-MT", PREFIX, "-MM", file.to!dstring
    ];
    auto pipes = pipeProcess(opts.map!"a.to!string".array, Redirect.stdout);
    dstring[] ret;
    foreach (l; pipes.stdout.byLine)
    {
        trace(l);
        if (l.startsWith(PREFIX))
        {
            l = l[PREFIX.length + 1 .. $];
        }
        if (l.endsWith("\\"d))
        {
            l = l[0 .. $ - 1];
        }
        ret ~= (cast(string) l).splitShellCommand;
    }
    return ret;
}

public int main()
{
    import std.stdio : writeln, writefln, writef, stderr;
    import core.stdc.string : strlen;

    globalLogLevel = LogLevel.warning;
    sharedLog = new ConsoleLogger(stderr);

    enforce(git2.git_libgit2_init() >= 0);
    git2.git_repository* repo;

    enforce(git2.git_repository_open_ext(&repo, ".", git2.GIT_REPOSITORY_OPEN_FROM_ENV, null) == 0);

    git2.git_status_list* status;
    git2.git_status_options status_opts;
    enforce(git2.git_status_options_init(&status_opts, git2.GIT_STATUS_OPTIONS_VERSION) == 0);

    enforce(git2.git_status_list_new(&status, repo, &status_opts) == 0);

    git2.git_index* index;
    enforce(git2.git_repository_index(&index, repo) == 0);

    scope (exit)
    {
        import git2; // @suppress(dscanner.suspicious.local_imports)
        git_index_free(index);
        git_status_list_free(status);
        git_repository_free(repo);
    }

    debug
    {
        git2.git_index_iterator* it;
        scope (exit)
            git2.git_index_iterator_free(it);
        enforce(git2.git_index_iterator_new(&it, index) == 0);
        while (true)
        {
            const(git2.git_index_entry)* entry;
            if (git2.git_index_iterator_next(&entry, it) == git2.GIT_ITEROVER)
            {
                break;
            }
            trace(entry.path[0 .. strlen(entry.path)]);
        }
    }

    auto wt_ptr = git2.git_repository_workdir(repo);
    auto wt = wt_ptr[0 .. strlen(wt_ptr)];
    immutable cdb = findAndOpenCompileDatabase();
    if (cdb.isNull)
    {
        warning("Failed to find the copmilation database, cannot proceed");
        return EXIT_SUCCESS;
    }

    bool[string] all_deps;
    foreach (ref entry; cdb.get.array)
    {

        auto path = buildNormalizedPath(entry.object["directory"].str, entry.object["file"].str);
        if (!path.startsWith(wt))
        {
            tracef("%s not in the worktree", path);
        }

        auto relative_path = path[wt.length .. $];
        all_deps[relative_path] = true;
    }

    foreach (i; 0 .. git2.git_status_list_entrycount(status))
    {
        auto entry = git2.git_status_byindex(status, i);
        const(char)[] path;
        if (entry.head_to_index !is null)
        {
            auto tmp = entry.head_to_index.old_file.path;
            path = tmp[0 .. strlen(tmp)];
        }
        else
        {
            auto tmp = entry.index_to_workdir.old_file.path;
            path = tmp[0 .. strlen(tmp)];
        }
        tracef("%s ", entry.status);
        trace(path);

        CompileOpts opts = void;
        if (entry.status & (git2.GIT_STATUS_INDEX_NEW | git2.GIT_STATUS_INDEX_MODIFIED))
        {
            import std.algorithm : filter, map, each;
            import std.conv : to;

            if (entry.status & git2.GIT_STATUS_WT_MODIFIED)
            {
                warningf("File \"%s\" has unstaged changes, missing detection won't be accurate",
                        path);
            }
            import std.path : buildNormalizedPath;

            bool guessed; // @suppress(dscanner.suspicious.unmodified)
            auto full_path = buildNormalizedPath(wt, path);
            opts = getCompileOptionsFor(cdb, full_path, guessed);
            if (guessed)
            {
                // Check file extensions
                if (path.extension !in EXTENSIONS)
                {
                    continue;
                }
                warningf("File \"%s\" is not in your compile_commands.json", path);
            }
            trace(opts);
            full_path.getDependency(opts).filter!((path) => path.startsWith(wt))
                .map!((path) => path[wt.length .. $].to!string)
                .each!((path) => all_deps[path] = true);
        }
    }

    bool missing = false;
    foreach (path; all_deps.byKey)
    {
        import std.string : toStringz;

        auto i = git2.git_index_get_bypath(index, path.toStringz, // @suppress(dscanner.suspicious.unmodified)
                git2.GIT_INDEX_STAGE_NORMAL);
        if (i is null)
        {
            criticalf("File \"%s\" not added", path);
            missing = true;
        }
    }

    tracef("%s %s", all_deps.length, all_deps);

    if (missing)
    {
        import common.console; // @suppress(dscanner.suspicious.local_imports)

        auto console = Console.create(stderr);
        console.setColor(Color.brightRed);
        stderr.writef("Missing files found, still proceed with the commit? (y/n)");
        stderr.flush;
        console.setColor(Color.lightGray);
        immutable ch = getch;
        stderr.writeln;
        if (ch == 'n')
        {
            return EXIT_FAILURE;
        }
    }
    return EXIT_SUCCESS;
}
