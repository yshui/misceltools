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
	if (opts.helpWanted) {
		defaultGetoptPrinter("Pull packages into your local repository\n"~
		    "Usage:\nrepo-update [-d repo] [-c] -- [makepkg options...]", opts.options);
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

	// Find outdated packages are in the repo
	auto aurRepoCmd2 = pipeProcess(["aur", "repo", "-l", "-d", chosenRepo], Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd2.pid.wait;

	bool[string] packages;
	foreach(k; aurRepoCmd2.stdout.byLine) {
		auto p = k.split(pat);
		packages[p[0].idup] = true;
	}

	string[] toUpdate;
	auto auracleOutdatedCmd = pipeProcess(["auracle", "outdated", "-q"], Redirect.stdout).makeFinal;
	scope(exit) auracleOutdatedCmd.pid.wait;
	foreach(k; aurRepoCmd2.stdout.byLine) {
		if (k in packages) {
			toUpdate ~= k.idup;
		}
	}

	// Get build order from auracle
	auto auracleBuildOrderCmd = pipeProcess(["auracle", "buildorder"] ~ toUpdate, Redirect.stdout).makeFinal;
	scope(exit) auracleBuildOrderCmd.pid.wait;

	string[] toBuild;
	bool[string] buildSet;
	foreach(k; auracleBuildOrderCmd.stdout.byLine) {
		import std.array : split;
		auto p = k.split(" ");

		if (!p[0].endsWith("AUR")) {
			continue;
		}

		if (p[1] !in packages) {
			warningf("Dependency %s of update pending package is not in your repo", p[1]);
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
	auto basedir = environment.get("XDG_CACHE_HOME",
	    environment.get("HOME").buildPath(".cache")).buildPath("pkgbuilds");
	basedir.mkdirRecurse;
	basedir.chdir;

	if (spawnProcess(["aur", "fetch"] ~ toBuild).wait != 0) {
		error("Failed to fetch PKGBUILDs");
		return;
	}
	foreach(pkg; toBuild) {
		basedir.buildPath(pkg).chdir;
		auto aurArgs = ["aur", "build", "-d", chosenRepo];
		if (chroot) {
			aurArgs ~= ["-c"];
		}
		aurArgs ~= pkg;
		aurArgs ~= args[2..$];
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
