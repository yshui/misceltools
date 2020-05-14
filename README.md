Miscellaneous tools
===================

Random tools/scripts I created for my own convenience. Might be useful for you too.

Each directory would contain its own README, here is an summary of each tool.

* ArchLinux specific:
  * `repo-pull`: Use [aurutils](https://github.com/AladW/aurutils) and [auracle](https://github.com/falconindy/auracle) to download and build a package with its dependencies, and add the results to your local repository.
  * `repo-unpull`: Use aurutils to remove package and its unneeded dependencies from your local repository.
  * `repo-update`: Use aurutils and auracle to update and rebuild packages in to your local repository.
  * `repo-rebuild`: Use aurutils and auracle to rebuild a package in to your local repository, even if the package is not updated on AUR.

Tools can usually be built with the idiomatic build systems of their language. So:

* DLang: `dub build`, or just `./program-name.d`
* C/C++: `cmake -B build . && make -C build`
* Rust: `cargo build`


