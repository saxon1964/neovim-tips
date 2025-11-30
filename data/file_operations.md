# Title: Save file
# Category: File Operations
# Tags: file, save, write
---
Use `:w` to save current file, `:w {file}` to save as new file, or `:wall` to save all files.

```vim
:w             " save current file
:w newfile.txt " save as new file
:wall          " save all files
```
***
# Title: Save as
# Category: File
# Tags: save, file
---
Use `:sav[eas] filepath` to save file under a different name

```vim
:sav ~/tmp/work.txt
```
***
# Title: Insert current date
# Category: File Operations
# Tags: date, insert, command
---
Use `:r !date` to insert current date at cursor position.

```vim
:r !date  " insert current date
```
***
# Title: Insert file contents
# Category: File Operations
# Tags: insert, file, read
---
Use `:r filename` to insert contents of another file at cursor position.

```vim
:r file.txt  " insert contents of file.txt
```
***
# Title: Reload file from disk
# Category: File Operations
# Tags: reload, file, refresh
---
Use `:e!` to reload current file from disk, discarding unsaved changes.

```vim
:e!  " reload file from disk
```
***
# Title: Ex commands - read and write operations
# Category: File Operations
# Tags: ex, read, write, append, output
---
Use `:read` or `:r` to read file into buffer, `:write` range to write part of buffer, `:.,$w` for current to end.

```vim
:r file.txt     " read file into current buffer
:read !date     " read output of command
:1,10w part.txt " write lines 1-10 to file
:.,$w end.txt   " write from current line to end
```
***
# Title: Ex commands - file permissions and attributes
# Category: File Operations
# Tags: ex, file, permission, readonly, modifiable
---
Use `:set readonly` to make read-only, `:set nomodifiable` to prevent changes, `:set fileformat` for line endings.

```vim
" Vimscript:
:set readonly      " make buffer read-only
:set nomodifiable  " prevent any modifications
:set fileformat=unix  " set Unix line endings
:set fileformat=dos   " set DOS line endings
```

```lua
-- Lua:
vim.opt.readonly = true  -- make buffer read-only
vim.opt.modifiable = false  -- prevent any modifications
vim.opt.fileformat = 'unix'  -- set Unix line endings
vim.opt.fileformat = 'dos'   -- set DOS line endings
```
***
# Title: Save multiple files at once
# Category: File Operations
# Tags: file, save, multiple, wall, xa
---
Use `:wa` to save all modified files, `:xa` to save all and exit, `:wqa` to save all and quit.

```vim
:wa      " write (save) all modified files
:xa      " write all modified files and exit
:wqa     " write all and quit all windows
:qa!     " quit all without saving
```
***
# Title: Path separator conversion
# Category: File Operations
# Tags: path, separator, backslash, forward, slash
---
Use `:s` commands to easily convert between backslash and forward slash in file paths.

```vim
" Convert backslashes to forward slashes:
:%s/\\/\//g

" Convert forward slashes to backslashes:
:%s/\//\\/g

" Or use built-in function:
:echo substitute(@%, '\\', '/', 'g')
```
***
# Title: Update file only if changed
# Category: File Operations
# Tags: file, update, save, changed, conditional
---
Use `:update` to save file only if it has been modified, more efficient than `:write`.

```vim
:update           " save only if file is modified
:map <F2> :update<CR>  " map F2 to conditional save
```
***
# Title: Handle different file formats
# Category: File Operations
# Tags: file, format, mac, dos, unix, encoding
---
Use `:e ++ff=mac` to reload file with Mac format, `++ff=dos` for DOS, `++ff=unix` for Unix.

```vim
:e ++ff=mac       " reload with Mac line endings
:e ++ff=dos       " reload with DOS line endings
:e ++ff=unix      " reload with Unix line endings
:set ff=unix      " change current file format
```
***
# Title: File names with spaces
# Category: File Operations
# Tags: file, name, space, isfname, path
---
Use `:set isfname+=32` to allow opening file names containing spaces with `gf` command.

```vim
:set isfname+=32    " add space (ASCII 32) to filename chars
" Now gf works on: /path/to/file with spaces.txt
:set isfname-=32    " remove space from filename chars
```
***
# Title: Check file existence in scripts
# Category: File Operations
# Tags: file, exist, check, script, function
---
Use `filereadable()` to check if file exists and is readable, `readfile()` to read all lines.

```vim
" In Vim script:
if filereadable('config.vim')
  source config.vim
endif

" Read file into list:
let lines = readfile('data.txt')
```
***
# Title: Browse for files with dialog
# Category: File Operations
# Tags: browse, dialog, gui, file, open
---
Use `:browse {command}` to open file browser dialog for commands that take filenames (GUI only).

```vim
:browse edit      " open file browser to edit file
:browse saveas    " open save-as dialog
:browse read      " browse to read file into buffer
:browse source    " browse to source a script file
```
***
# Title: Write file and create all directories form the full file path
# Category: File Operations
# Tags: file, save, write
---
Use this command to write file if the full path contains non-existent directories. All directories that do not exist will be created before the save:

```vim
:write ++p
```
***

