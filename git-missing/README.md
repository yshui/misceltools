git-missing
===========

Have you ever forgotten to add some files to your commit before you push, and have to do the `git commit --amend && git push -force` of shame?

I know I sure have. So here is a simple tool to help you with that.

`git-missing` detects files that are potentially needed, but are not added to your git index. It currently only supports C/C++ projects which has a `compile_commands.json` file in the project root.

This detection is best-effort only, and certainly won't catch all cases. But this should already help a lot.

## To use

Clone this repository, and put this line in your git pre-commit hook:

```bash
/path/to/repo/git-missing/git-missing.d
```

### Dependencies

You need a [D compiler](https://dlang.org/download.html), and these libraries:

* libgit2
