# Title: Session management
# Category: Session
# Tags: session, save, restore
---
Use `:mksession!` to save session and `:source Session.vim` to restore it.

#### Example

```vim
:mksession!        " save session
:source Session.vim " restore session
```
***
# Title: Ex commands - session options
# Category: Session
# Tags: ex, session, options, save, restore
---
Use `:set sessionoptions` to control what gets saved, `:mksession {file}` for custom filename, `:source` to restore.

#### Example

```vim
:set sessionoptions=buffers,curdir,folds,help,tabpages,winsize
:mksession mysession.vim  " save to custom file (fails if the file already exists)
:mksession mysession.vim! " save with custom name (overwrites possibly existing file)
:source mysession.vim     " restore specific session
```
***
# Title: Ex commands - viminfo and shada
# Category: Session
# Tags: ex, viminfo, shada, history, persistent
---
Use `:wviminfo` to write viminfo, `:rviminfo` to read, `:wshada` and `:rshada` for Neovim's shada file.

#### Example

```vim
:wshada          " write shada file
:rshada          " read shada file
:wshada backup.shada  " save to specific file
:rshada backup.shada  " read from specific file
```
***
# Title: Ex commands - arglist and project files
# Category: Session
# Tags: ex, arglist, args, project, files
---
Use `:args` to set argument list, `:argadd` to add files, `:next`/`:prev` to navigate, `:argdo` for commands on all.

#### Example

```vim
:args *.py       " set arglist to all Python files
:argadd test.py  " add file to arglist
:next            " go to next file in arglist
:prev            " go to previous file
:argdo %s/old/new/g  " run command on all files
```
***
# Title: Ex commands - working with multiple files
# Category: Session
# Tags: ex, multiple, files, bufdo, windo, tabdo
---
Use `:bufdo` for all buffers, `:windo` for all windows, `:tabdo` for all tabs to execute commands across multiple contexts.

#### Example

```vim
:bufdo %s/old/new/ge  " substitute in all buffers
:windo set number     " set line numbers in all windows
:tabdo close          " close all tabs
:argdo write          " save all files in arglist
```
***
