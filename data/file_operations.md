Open file
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

Save file
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

Buffer operations
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

Insert current date
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

Insert file contents
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

Save file with sudo
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

Reload file from disk
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
