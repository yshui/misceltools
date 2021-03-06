#!/bin/rdmd
module repo_pull;
import std.stdio;
import std.conv;
import std.process;
import std.algorithm;
import std.regex;
import std.experimental.logger;
import std.experimental.typecons : Final, makeFinal;
import std.getopt : getopt, defaultGetoptPrinter, GetoptResult, arraySep;
import std.ascii : letters;
import std.path : buildPath;
import std.file : tempDir, mkdirRecurse, chdir, rmdirRecurse;
import std.utf : byCodeUnit;
import std.random : randomSample;

void main(string[] args)
{
    arraySep = ",";
    sharedLog = new FileLogger(stdout);
    globalLogLevel = LogLevel.info;
    string repo = null;
    string[] masked = [];
    bool dryRun = false;
    GetoptResult opts;
    try
    {
        opts = args.getopt("d", "Local repository name (default: auto detect)",
                &repo, "m", "Mask a given package", &masked, "n", "Dry run", &dryRun);
    }
    catch (Exception e)
    {
        writeln("Error: ", e.message);
        return;
    }

    import std.array : assocArray;

    bool[string] maskedSet = masked.map!"tuple(a, true)".assocArray;

    import std.format : format;
    import std.path : baseName;

    if (opts.helpWanted || args.length < 2)
    {
        defaultGetoptPrinter("Pull packages into your local repository\n"
                ~ "Usage:\n%s [-d repo] -- [aur build options...]".format(args[0].baseName),
                opts.options);
        return;
    }

    string chosenRepo = null;

    // Find repo
    auto aurRepoCmd = pipeProcess(["aur", "repo", "--repo-list"], Redirect.stdout).makeFinal;
    scope (exit)
        aurRepoCmd.pid.wait;

    enum pat = ctRegex!(r"\s");
    foreach (k; aurRepoCmd.stdout.byLine)
    {
        auto p = k.split(pat);
        if (repo == p[0] || repo is null)
        {
            chosenRepo = p[0].idup;
            break;
        }
    }

    // Find what packages are already in the repo
    auto aurRepoCmd2 = pipeProcess(["aur", "repo", "-l", "-d", chosenRepo], Redirect.stdout)
        .makeFinal;
    scope (exit)
        aurRepoCmd2.pid.wait;

    bool[string] packages;
    foreach (k; aurRepoCmd2.stdout.byLine)
    {
        auto p = k.split(pat);
        packages[p[0].idup] = true;
    }

    // Get build order from auracle
    auto auracleBuildOrderCmd = pipeProcess(["auracle", "buildorder", args[1]], Redirect.stdout)
        .makeFinal;
    scope (exit)
        auracleBuildOrderCmd.pid.wait;

    string[] toBuild;
    bool[string] buildSet;
    foreach (k; auracleBuildOrderCmd.stdout.byLine)
    {
        import std.array : split;

        auto p = k.split(" ");

        if (!p[0].endsWith("AUR"))
        {
            continue;
        }

        if (p[1] in packages)
        {
            infof("Package %s already exists in the repo", p[1]);
            continue;
        }

        if (p[2]!in buildSet)
        {
            auto name = p[2].idup;
            toBuild ~= name;
            buildSet[name] = true;
        }
    }

    if (toBuild.length == 0)
    {
        writeln("Nothing to do");
        return;
    }

    // Create a temporary directory
    auto basedir = environment.get("XDG_CACHE_HOME", environment.get("HOME")
            .buildPath(".cache")).buildPath("pkgbuilds");
    basedir.mkdirRecurse;
    basedir.chdir;

    if (spawnProcess(["aur", "fetch"] ~ toBuild).wait != 0)
    {
        error("Failed to fetch PKGBUILDs");
        return;
    }
    foreach (pkg; toBuild)
    {
        if (pkg in maskedSet)
        {
            infof("Skipping %s because it's masked", pkg);
            continue;
        }
        basedir.buildPath(pkg).chdir;
        auto aurArgs = ["aur", "build", "-d", chosenRepo];
        aurArgs ~= pkg;
        if (args.length > 1)
        {
            aurArgs ~= args[2 .. $];
        }
        if (dryRun)
        {
            writefln("Would have run: %(%s %)", aurArgs);
        }
        else
        {
            if (spawnProcess(aurArgs).wait != 0)
            {
                errorf("Failed to build package %s", pkg);
                return;
            }
        }
    }
}
