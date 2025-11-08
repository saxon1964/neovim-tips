# Title: Quit Vim
# Category: Exit
# Tags: quit, exit, close
---
Use `:q` to quit, `:q!` to quit without saving, `:wq` or `:x` to write and quit, `ZZ` to save and exit, 'ZQ' to quit withut saving.

```vim
:q   " quit
:q!  " quit without saving
:wq  " write and quit
ZZ   " save and exit
ZQ   " quit without saving
```
***
# Title: Exit with error code
# Category: Exit
# Tags: quit, exit, error, git, abort
---
Use `:cq` to exit Vim with a non-zero error code. Useful for aborting git operations like `git rebase` or `git commit`.

```vim
:cq  " exit with error code (non-zero status)
```

When used during `git rebase -i` or `git commit`, this aborts the operation instead of completing it.
***
