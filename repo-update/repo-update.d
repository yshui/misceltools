#!/bin/rdmd --shebang -L-lalpm

module repo_update;
import std.stdio;
import std.conv;
import std.process;
import std.algorithm;
import std.regex : split, ctRegex;
import std.experimental.logger;
import std.experimental.typecons : Final, makeFinal;
import std.getopt : getopt, defaultGetoptPrinter, GetoptResult;
import std.ascii : letters;
import std.path : buildPath;
import std.file : tempDir, mkdirRecurse, chdir, rmdirRecurse;
import std.utf : byCodeUnit;
import std.random : randomSample;
import std.array : split;

///
extern(C) int alpm_pkg_vercmp(const(char)*a, const(char)*b);

///
int vercmp(string a, string b) {
	import std.string : toStringz;
	return alpm_pkg_vercmp(a.toStringz, b.toStringz);
}

void main(string[] args)
{
	sharedLog = new FileLogger(stdout);
	globalLogLevel = LogLevel.info;
	string repo = null;
	bool dryRun = false;
	GetoptResult opts;
	try {
		opts = args.getopt(
		    "d", "Local repository name (default: auto detect)", &repo,
		    "n", "Dry run", &dryRun);
	} catch (Exception e) {
		writeln("Error: ", e.message);
		return;
	}
	import std.format : format;
	import std.path : baseName;
	if (opts.helpWanted) {
		defaultGetoptPrinter("Pull packages into your local repository\n"~
		    "Usage:\n%s [-d repo] -- [aur build options...]".format(args[0].baseName), opts.options);
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
	infof("Using repo %s", chosenRepo);

	// Find outdated packages are in the repo
	auto aurRepoCmd2 = pipeProcess(["aur", "repo", "-l", "-d", chosenRepo], Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd2.pid.wait;

	string[string] packages;
	foreach(k; aurRepoCmd2.stdout.byLine) {
		auto p = k.split(pat);
		packages[p[0].idup] = p[1].idup;
	}

	bool[string] updateSet;
	auto auracleOutdatedCmd = pipeProcess(["auracle", "outdated"], Redirect.stdout).makeFinal;
	scope(exit) auracleOutdatedCmd.pid.wait;
	foreach(k; auracleOutdatedCmd.stdout.byLine) {
		auto p = k.split(" ");
		if (p[2] != "->") {
			errorf("Cannot parse auracle output");
			return;
		}
		if (p[0] in packages) {
			if (vercmp(p[3].idup, packages[p[0]]) > 0) {
				updateSet[p[0].idup] = true;
			} else {
				infof("Package %s in your repo is newer (%s > %s)", p[0], packages[p[0]], p[3]);
			}
		} else {
			infof("Package %s is not in your repo", p[0]);
		}
	}

	if (updateSet.length == 0) {
		writeln("Nothing to do");
		return;
	}
	infof("Packages to update: %(%s %)", updateSet.keys);

	// Get build order from auracle
	auto auracleBuildOrderCmd = pipeProcess(["auracle", "buildorder"] ~ updateSet.keys(), Redirect.stdout).makeFinal;
	scope(exit) auracleBuildOrderCmd.pid.wait;

	string[] toBuild;
	bool[string] buildSet;
	foreach(k; auracleBuildOrderCmd.stdout.byLine) {
		auto p = k.split(" ");

		if (!p[0].endsWith("AUR")) {
			continue;
		}

		if (p[1] !in packages) {
			warningf("Dependency %s of update pending package is not in your repo", p[1]);
			continue;
		}

		if (p[2] !in buildSet && p[1] in updateSet) {
			auto name = p[2].idup;
			toBuild ~= name;
			buildSet[name] = true;
		}
	}

	if (toBuild.length == 0) {
		writeln("Nothing to do");
		return;
	}

	// Create a temporary directory
	auto basedir = environment.get("XDG_CACHE_HOME",
	    environment.get("HOME").buildPath(".cache")).buildPath("pkgbuilds");
	basedir.mkdirRecurse;
	basedir.chdir;

	foreach(pkg; toBuild) {
		basedir.buildPath(pkg).chdir;
		if (spawnProcess(["git", "pull", "--autostash"]).wait != 0) {
			error("Failed to update PKGBUILDs");
			return;
		}

		auto aurArgs = ["aur", "build", "-d", chosenRepo];
		aurArgs ~= pkg;
		if (args.length > 1) {
			aurArgs ~= args[1..$];
		}
		if (dryRun) {
			writefln("Would have run: %(%s %)", aurArgs);
		} else {
			if (spawnProcess(aurArgs).wait != 0) {
				errorf("Failed to build package %s", pkg);
				return;
			}
		}
	}
}
