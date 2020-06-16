#!/bin/rdmd --shebang -L-lalpm

module repo_rebuild;
import std.stdio;
import std.conv;
import std.process;
import std.algorithm;
import std.regex;
import std.experimental.logger;
import std.experimental.typecons : Final, makeFinal;
import std.getopt : getopt, defaultGetoptPrinter, GetoptResult;
import std.ascii : letters;
import std.path : buildPath;
import std.file : tempDir, mkdirRecurse, chdir, rmdirRecurse;
import std.utf : byCodeUnit;
import std.random : randomSample;

///
extern(C) int alpm_pkg_vercmp(const(char)*a, const(char)*b);

///
int vercmp(string a, string b) {
	import std.string : toStringz;
	return alpm_pkg_vercmp(a.toStringz, b.toStringz);
}

void bumppkgrel(string file) {
	import std.stdio : File;
	import std.format : format;
	import std.regex : match, ctRegex;
	{
		auto outf = File(file~".new", "w");
		auto inf = File(file);
		enum pat = ctRegex!r"pkgrel=(\d+)";
		foreach(l; inf.byLine) {
			auto m = l.matchFirst(pat);
			if (m) {
				import std.conv : to;
				immutable pkgrel = m[1].to!int;
				outf.writeln(l.replaceFirst(pat, "pkgrel=%s".format(pkgrel+1)));
			} else {
				outf.writeln(l);
			}
		}
	}

	import std.file : rename;
	rename(file~".new", file);
}

string getPKGBUILDVersion(string pkg) {
	import std.exception : enforce;
	// Update the source
	enforce(spawnProcess(["makepkg", "-o"]).wait == 0);

	auto makepkgSrcInfoCmd = pipeProcess(["makepkg", "--printsrcinfo"]);
	scope(exit) makepkgSrcInfoCmd.pid.wait;

	string current_pkg = null;
	string[string] props;
	string ver() { return  props["pkgver"]~"-"~props["pkgrel"]; }

	foreach(l; makepkgSrcInfoCmd.stdout.byLine) {
		import std.array : split;
		if (l.startsWith("pkgbase")) {
			continue;
		}
		if (l.startsWith("pkgname")) {
			if (current_pkg == pkg) {
				return ver;
			}

			auto p = l.split(" = ");
			current_pkg = p[1].idup;
			continue;
		}
		if (!l.length) {
			continue;
		}
		assert(l[0] == '\t');
		auto p = l[1..$].split(" = ");
		props[p[0].idup] = p[1].idup;
	}

	enforce(current_pkg == pkg);
	return ver;
}

void main(string[] args)
{
	sharedLog = new FileLogger(stdout);
	globalLogLevel = LogLevel.info;
	string repo = null;
	bool dryRun = false, bump = false;
	GetoptResult opts;
	try {
		opts = args.getopt(
		    "d", "Local repository name (default: auto detect)", &repo,
		    "b", "Bump pkgrel", &bump,
		    "n", "Dry run, perform all operations except building", &dryRun);
	} catch (Exception e) {
		writeln("Error: ", e.message);
		return;
	}
	import std.format : format;
	import std.path : baseName;
	if (opts.helpWanted || args.length < 2) {
		defaultGetoptPrinter("Force rebuild a package into your local repository\n"~
		    "Usage:\n%s [-d repo] [-nb] pacakge -- [aur build options...]".format(args[0].baseName), opts.options);
		return;
	}

	string chosenRepo = null;

	// Find repo
	auto aurRepoCmd = pipeProcess(["aur", "repo", "--repo-list"], Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd.pid.wait;

	enum pat = ctRegex!(r"\s");
	foreach(k; aurRepoCmd.stdout.byLine) {
		auto p = k.split(pat);
		if (repo == p[0] || repo is null) {
			chosenRepo = p[0].idup;
			break;
		}
	}

	// Find what packages are already in the repo
	auto aurRepoCmd2 = pipeProcess(["aur", "repo", "-l", "-d", chosenRepo], Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd2.pid.wait;

	string[string] packages;
	foreach(k; aurRepoCmd2.stdout.byLine) {
		auto p = k.split(pat);
		packages[p[0].idup] = p[1].idup;
	}

	if (args[1] !in packages) {
		errorf("Package %s not found in your repo", args[1]);
		return;
	}

	// Find the base package to build
	import std.json : parseJSON;
	auto auracleRawInfoCmd = pipeProcess(["auracle", "rawinfo", args[1]], Redirect.stdout).makeFinal;
	scope(exit) auracleRawInfoCmd.pid.wait;
	auto package_info = auracleRawInfoCmd.stdout.byLine.front.parseJSON;
	string basepkg = null;
	foreach(p; package_info["results"].array) {
		if (p["Name"].str != args[1]) {
			continue;
		}
		if (basepkg !is null) {
			warningf("Multiple matching package %s found", args[1]);
		} else {
			basepkg = p["PackageBase"].str;
		}
	}
	if (basepkg is null) {
		errorf("Package %s not found in AUR", args[1]);
		return;
	}

	// Create a temporary directory
	auto basedir = environment.get("XDG_CACHE_HOME",
	    environment.get("HOME").buildPath(".cache")).buildPath("pkgbuilds");
	basedir.mkdirRecurse;
	basedir.chdir;

	if (spawnProcess(["aur", "fetch", basepkg]).wait != 0) {
		error("Failed to fetch PKGBUILDs");
		return;
	}

	if (spawnProcess(["git", "pull", "--autostash"], null, cast(Config)0, basepkg).wait != 0) {
		error("Failed to update PKGBUILDs");
		return;
	}

	if (bump) {
		bumppkgrel(basepkg~"/PKGBUILD");
	}

	// Do build
	basedir.buildPath(basepkg).chdir;
	auto aurArgs = ["aur", "build", "-d", chosenRepo];
	aurArgs ~= basepkg;
	if (args.length > 1) {
		aurArgs ~= args[2..$];
	}
	if (dryRun) {
		writefln("Would have run: %(%s %)", aurArgs);
	} else {
		auto ver = getPKGBUILDVersion(args[1]);
		if (vercmp(ver, packages[args[1]]) <= 0) {
			errorf("Package %s in your repo is already up-to-date (%s <= %s)", args[1], ver, packages[args[1]]);
			return;
		}
		if (spawnProcess(aurArgs).wait != 0) {
			errorf("Failed to build package %s", basepkg);
			return;
		}
	}
}
