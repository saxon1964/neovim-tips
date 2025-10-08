# Title: Async shell commands
# Category: System
# Tags: async, shell, lua
---
Use `vim.loop.spawn()` to run shell commands asynchronously without blocking Neovim.

```vim
:lua vim.loop.spawn("ls", {args={"-la"}}, function() print("Done!") end)
```
***
# Title: Read command output into buffer
# Category: System
# Tags: command, output, read, external
---
Use `:r !command` to read external command output into current buffer at cursor position.

```vim
:r !ls              " insert file listing
:r !date            " insert current date
:0r !whoami         " insert username at top of file
:r !curl -s url     " insert web content
```
***
# Title: Write buffer to command
# Category: System
# Tags: write, command, pipe, external
---
Use `:w !command` to pipe buffer contents to external command without saving file.

```vim
:w !wc              " count words without saving
:w !python          " execute buffer as Python script
:%w !sh             " execute entire buffer as shell script
:'<,'>w !sort       " sort selected lines
```
***
# Title: Execute line as command
# Category: System
# Tags: execute, line, command, shell
---
Use `!!` to replace current line with output of line executed as shell command.

```vim
!!date              " replace line with current date
!!ls                " replace line with directory listing
!!pwd               " replace line with current directory
" Or use visual selection:
V!!sort             " sort selected lines in place
```
***
# Title: Ex commands - external command execution
# Category: System
# Tags: ex, external, command, shell, bang
---
Use `:!command` to run external commands, `:!!` to repeat last command, `:silent !` to run without output.

```vim
:!ls              " run ls command
:!make            " run make command
:!!               " repeat last external command
:silent !make     " run make without showing output
```
***
# Title: Ex commands - shell and environment
# Category: System
# Tags: ex, shell, environment, cd, pwd
---
Use `:shell` to start shell, `:cd` to change directory, `:pwd` to show current directory, `:lcd` for local directory.

```vim
:shell         " start interactive shell
:cd /home/user " change to directory
:pwd           " show current directory
:lcd ~/project " change local directory for current window
```
***
# Title: Ex commands - make and quickfix
# Category: System
# Tags: ex, make, quickfix, error, jump
---
Use `:make` to run make command, `:copen` for quickfix window, `:cnext`/`:cprev` to navigate errors.

```vim
:make           " run make command
:make clean     " run make with target
:copen          " open quickfix window
:cnext          " jump to next error
:cprev          " jump to previous error
:cfirst         " jump to first error
:clast          " jump to last error
```
***
# Title: Ex commands - file system operations
# Category: System
# Tags: ex, file, system, mkdir, delete, rename
---
Use `:!mkdir`, `:!rm`, `:!mv` for file operations, or use Neovim's built-in file functions.

```vim
:!mkdir newdir        " create directory
:!rm file.txt         " delete file
:!mv old.txt new.txt  " rename file
:!cp file.txt backup.txt  " copy file
```
***
# Title: Redirect command output
# Category: System  
# Tags: redirect, output, capture, redir
---
Use `:redir` to redirect command output to variables, registers, or files for later use.

```vim
:redir @a           " redirect to register 'a'
:set all           " run commands
:redir END         " stop redirecting
"ap                " paste captured output

:redir > output.txt " redirect to file
:echo "hello"      " commands get redirected
:redir END         " stop redirecting
```
***
# Title: Confirm dangerous operations
# Category: System
# Tags: confirm, dialog, save, quit, dangerous
---
Use `:confirm {command}` to show confirmation dialog for potentially dangerous operations.

```vim
:confirm quit     " show dialog if unsaved changes exist
:confirm qall     " confirm before quitting all windows
:confirm write    " confirm before writing file
:confirm !rm %    " confirm before executing external command
```
***