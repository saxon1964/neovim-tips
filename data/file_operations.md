# Title: Open file
# Category: File Operations
# Tags: file, open, edit
---
Use `:e {file}` to edit/open a file, or `:edit {file}` as the full command.

#### Example

```vim
:e file.txt
:edit ../other.txt
```
===
# Title: Save file
# Category: File Operations
# Tags: file, save, write
---
Use `:w` to save current file, `:w {file}` to save as new file, or `:wall` to save all files.

#### Example

```vim
:w             " save current file
:w newfile.txt " save as new file
:wall          " save all files
```
===
# Title: Buffer operations
# Category: File Operations
# Tags: buffer, file, switch
---
Use `:ls` to list buffers, `:b {number}` to switch to buffer, `:bn` for next buffer, `:bp` for previous buffer.

#### Example

```vim
:ls   " list buffers
:b2   " switch to buffer 2
:bn   " next buffer
:bp   " previous buffer
```
===
# Title: Insert current date
# Category: File Operations
# Tags: date, insert, command
---
Use `:r !date` to insert current date at cursor position.

#### Example

```vim
:r !date  " insert current date
```
===
# Title: Insert file contents
# Category: File Operations
# Tags: insert, file, read
---
Use `:r filename` to insert contents of another file at cursor position.

#### Example

```vim
:r file.txt  " insert contents of file.txt
```
===
# Title: Save file with sudo
# Category: File Operations
# Tags: sudo, save, permissions
---
Use `:w !sudo tee %` to save current file with sudo privileges when you forgot to open with sudo.

#### Example

```vim
:w !sudo tee %  " save with sudo
```
===
# Title: Reload file from disk
# Category: File Operations
# Tags: reload, file, refresh
---
Use `:e!` to reload current file from disk, discarding unsaved changes.

#### Example

```vim
:e!  " reload file from disk
```
===
# Title: Ex commands - file creation and templates
# Category: File Operations
# Tags: ex, file, create, template, new
---
Use `:enew` for new buffer, `:new` for new window, `:vnew` for vertical new window, `:tabnew` for new tab.

#### Example

```vim
:enew    " create new empty buffer
:new     " create new buffer in horizontal split
:vnew    " create new buffer in vertical split
:tabnew  " create new buffer in new tab
```
===
# Title: Ex commands - file information
# Category: File Operations
# Tags: ex, file, info, stat, ls
---
Use `:file` or `:f` for file info, `:ls` or `:buffers` for buffer list, `:files` for file list.

#### Example

```vim
:file     " show current file info
:f        " short form of :file
:ls       " list all buffers
:buffers  " same as :ls
:files    " same as :ls
```
===
# Title: Ex commands - read and write operations
# Category: File Operations
# Tags: ex, read, write, append, output
---
Use `:read` or `:r` to read file into buffer, `:write` range to write part of buffer, `:.,$w` for current to end.

#### Example

```vim
:r file.txt     " read file into current buffer
:read !date     " read output of command
:1,10w part.txt " write lines 1-10 to file
:.,$w end.txt   " write from current line to end
```
===
# Title: Ex commands - file permissions and attributes
# Category: File Operations
# Tags: ex, file, permission, readonly, modifiable
---
Use `:set readonly` to make read-only, `:set nomodifiable` to prevent changes, `:set fileformat` for line endings.

#### Example

```vim
:set readonly      " make buffer read-only
:set nomodifiable  " prevent any modifications
:set fileformat=unix  " set Unix line endings
:set fileformat=dos   " set DOS line endings
```
===
# Title: Ex commands - backup and swap files
# Category: File Operations
# Tags: ex, backup, swap, recover, undo
---
Use `:recover` to recover from swap file, `:preserve` to write to swap, `:set backup` for backups.

#### Example

```vim
:recover     " recover from swap file
:preserve    " force write to swap file
:set backup  " enable backup files
:set noswapfile  " disable swap files
```
===
# Title: Save multiple files at once
# Category: File Operations
# Tags: file, save, multiple, wall, xa
---
Use `:wa` to save all modified files, `:xa` to save all and exit, `:wqa` to save all and quit.

#### Example

```vim
:wa      " write (save) all modified files
:xa      " write all modified files and exit
:wqa     " write all and quit all windows
:qa!     " quit all without saving
```
===
# Title: Path separator conversion
# Category: File Operations
# Tags: path, separator, backslash, forward, slash
---
Use `:s` commands to easily convert between backslash and forward slash in file paths.

#### Example

```vim
" Convert backslashes to forward slashes:
:%s/\\/\//g

" Convert forward slashes to backslashes:
:%s/\//\\/g

" Or use built-in function:
:echo substitute(@%, '\\', '/', 'g')
```
===
# Title: Insert file at specific position
# Category: File Operations
# Tags: file, insert, read, position, line
---
Use `:0r filename` to insert file before first line, `:$r filename` to append at end.

#### Example

```vim
:0r header.txt    " insert file before first line
:$r footer.txt    " append file at end
:5r data.txt      " insert file after line 5
:r !date          " insert output of command
```
===
# Title: Update file only if changed
# Category: File Operations
# Tags: file, update, save, changed, conditional
---
Use `:update` to save file only if it has been modified, more efficient than `:write`.

#### Example

```vim
:update           " save only if file is modified
:map <F2> :update<CR>  " map F2 to conditional save
```
===
# Title: Handle different file formats
# Category: File Operations
# Tags: file, format, mac, dos, unix, encoding
---
Use `:e ++ff=mac` to reload file with Mac format, `++ff=dos` for DOS, `++ff=unix` for Unix.

#### Example

```vim
:e ++ff=mac       " reload with Mac line endings
:e ++ff=dos       " reload with DOS line endings  
:e ++ff=unix      " reload with Unix line endings
:set ff=unix      " change current file format
```
===
# Title: File names with spaces
# Category: File Operations
# Tags: file, name, space, isfname, path
---
Use `:set isfname+=32` to allow opening file names containing spaces with `gf` command.

#### Example

```vim
:set isfname+=32    " add space (ASCII 32) to filename chars
" Now gf works on: /path/to/file with spaces.txt
:set isfname-=32    " remove space from filename chars
```
===
# Title: Check file existence in scripts
# Category: File Operations
# Tags: file, exist, check, script, function
---
Use `filereadable()` to check if file exists and is readable, `readfile()` to read all lines.

#### Example

```vim
" In Vim script:
if filereadable('config.vim')
  source config.vim
endif

" Read file into list:
let lines = readfile('data.txt')
```
===