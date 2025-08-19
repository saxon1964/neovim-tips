# Title: Async shell commands
# Category: System
# Tags: async, shell, lua
---
Use `vim.loop.spawn()` to run shell commands asynchronously without blocking Neovim.

#### Example

```vim
:lua vim.loop.spawn("ls", {args={"-la"}}, function() print("Done!") end)
```
===
# Title: Read command output into buffer
# Category: System
# Tags: command, output, read, external
---
Use `:r !command` to read external command output into current buffer at cursor position.

#### Example

```vim
:r !ls              " insert file listing
:r !date            " insert current date
:0r !whoami         " insert username at top of file
:r !curl -s url     " insert web content
```
===
# Title: Write buffer to command
# Category: System
# Tags: write, command, pipe, external
---
Use `:w !command` to pipe buffer contents to external command without saving file.

#### Example

```vim
:w !wc              " count words without saving
:w !python          " execute buffer as Python script
:%w !sh             " execute entire buffer as shell script
:'<,'>w !sort       " sort selected lines
```
===
# Title: Execute line as command
# Category: System
# Tags: execute, line, command, shell
---
Use `!!` to replace current line with output of line executed as shell command.

#### Example

```vim
!!date              " replace line with current date
!!ls                " replace line with directory listing
!!pwd               " replace line with current directory
" Or use visual selection:
V!!sort             " sort selected lines in place
```
===