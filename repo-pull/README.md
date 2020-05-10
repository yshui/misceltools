repo-pull
=========

**Usage:** `repo-pull [-d repo] [-c] package`

Builds package and its dependencies, and add them to local pacman repository `repo`. If `repo` is not specified, choose the first `file://` repo in pacman.conf.

`-c` option corresponds to the `-c` option of `aur build`.

This tool doesn't actively install packages for you, but they could be installed by `aur build` as build dependencies.

After everything is built, you can install the target package with `pacman`.

**Runtime dependencies:**

* auracle (for `auracle clone` and `auracle buildorder`)
* aurutils (for `aur build`)
