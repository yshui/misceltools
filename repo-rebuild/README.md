repo-rebuild
=========

**Usage:** `repo-rebuild [-d repo] package -- [aur build options...]`

Force rebuild a package in your repository, and add them to local pacman repository `repo`. Useful for updating VCS package. If `repo` is not specified, choose the first `file://` repo in pacman.conf.

This tool doesn't actively install packages for you, but they could be installed by `aur build` as build dependencies.

After everything is built, you can install the target package with `pacman`.

**Runtime dependencies:**

* auracle (for `auracle clone` and `auracle buildorder`)
* aurutils (for `aur build`)
