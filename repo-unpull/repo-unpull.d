#!/bin/rdmd
module repo_pull;
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
	if (opts.helpWanted || args.length < 2) {
		defaultGetoptPrinter("Remove package and its unneeded dependencies from your local repository\n"~
		    "Usage:\n%s [-d repo] package".format(args[0].baseName), opts.options);
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
	auto aurRepoCmd2 = pipeProcess(["aur", "repo", "-l", "-d", chosenRepo, "--table"],
	    Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd2.pid.wait;

	bool[string] packages;
	int[string] depCount;
	string[] targetDep = [ args[1] ];
	foreach(k; aurRepoCmd2.stdout.byLine) {
		auto p = k.split(pat);
		auto name = p[0].idup;
		auto dep = p[1].idup;
		packages[name] = true;
		if (name != args[1]) {
			depCount[dep]++;
			if (dep == args[1]) {
				errorf("Removing %s will break dependent %s", args[1], name);
				return;
			}
		} else {
			targetDep ~= dep.idup;
		}
	}
	if (args[1] !in packages) {
		errorf("Package %s not found", args[1]);
		return;
	}

	assert(args[1] !in depCount);
	string[] toRemove;
	foreach(p; targetDep) {
		if (p !in depCount && p in packages) {
			toRemove ~= p;
		}
	}

	// Get repo db path
	auto aurRepoCmd3 = pipeProcess(["aur", "repo", "--path", "-d", chosenRepo], Redirect.stdout).makeFinal;
	scope(exit) aurRepoCmd3.pid.wait;

	immutable db = aurRepoCmd3.stdout.byLine.front.idup;
	string[] repoRemoveArgs = [ "repo-remove", db ] ~ toRemove;
	if (dryRun) {
		writefln("Would have run %(%s %)", repoRemoveArgs);
	} else {
		spawnProcess(repoRemoveArgs).wait;
	}
}
