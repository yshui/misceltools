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
import std.file : tempDir, mkdir, chdir, rmdirRecurse;
import std.utf : byCodeUnit;
import std.random : randomSample;

void main(string[] args)
{
	sharedLog = new FileLogger(stdout);
	globalLogLevel = LogLevel.info;
	string repo = null;
	bool chroot = false, dryRun = false;
	GetoptResult opts;
	try {
		opts = args.getopt(
		    "d", "Local repository name (default: auto detect)", &repo,
		    "c", "Build in a clean chroot environment", &chroot,
		    "n", "Dry run", &dryRun);
	} catch (Exception e) {
		writeln("Error: ", e.message);
		return;
	}
	if (opts.helpWanted || args.length != 2) {
		defaultGetoptPrinter("Pull packages into your local repository\n"~
		    "Usage:\nrepo-pull [-d repo] [-c] package", opts.options);
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

	bool[string] packages;
	foreach(k; aurRepoCmd2.stdout.byLine) {
		auto p = k.split(pat);
		packages[p[0].idup] = true;
	}

	// Get build order from auracle
	auto auracleBuildOrderCmd = pipeProcess(["auracle", "buildorder", args[1]], Redirect.stdout).makeFinal;
	scope(exit) auracleBuildOrderCmd.pid.wait;

	string[] toBuild;
	bool[string] buildSet;
	foreach(k; auracleBuildOrderCmd.stdout.byLine) {
		import std.array : split;
		auto p = k.split(" ");

		if (!p[0].endsWith("AUR")) {
			continue;
		}

		if (p[1] in packages) {
			infof("Package %s already exists in the repo", p[1]);
			continue;
		}

		if (p[2] !in buildSet) {
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
	auto id = letters.byCodeUnit.randomSample(20).to!string;
	auto tmpdir = tempDir.buildPath("repopull"~id);
	tmpdir.mkdir;
	tmpdir.chdir;
	scope(exit) tmpdir.rmdirRecurse;

	if (spawnProcess(["aur", "fetch"] ~ toBuild).wait != 0) {
		error("Failed to fetch PKGBUILDs");
		return;
	}
	foreach(pkg; toBuild) {
		tmpdir.buildPath(pkg).chdir;
		auto aurArgs = ["aur", "build", "-d", chosenRepo];
		if (chroot) {
			aurArgs ~= ["-c"];
		}
		aurArgs ~= pkg;
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
