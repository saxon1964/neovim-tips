# Title: Send commands to terminal
# Category: Terminal
# Tags: terminal, command, send
---
Use `vim.api.nvim_chan_send()` to send commands to terminal buffer from Lua.

#### Example

```vim
:lua vim.api.nvim_chan_send(terminal_job_id, "ls\n")
```
===
# Title: Terminal mode - exit to normal mode
# Category: Terminal
# Tags: terminal, mode, exit, normal
---
Use `Ctrl+\ Ctrl+n` to exit terminal mode and go to normal mode.

#### Example

```vim
" In terminal mode:
Ctrl+\ Ctrl+n  " exit to normal mode
```
===
# Title: Terminal mode - execute one command
# Category: Terminal
# Tags: terminal, mode, execute, command
---
Use `Ctrl+\ Ctrl+o` to execute one normal mode command and return to terminal mode.

#### Example

```vim
" In terminal mode:
Ctrl+\ Ctrl+o  " execute one normal mode command
```
===
# Title: Terminal mode - key forwarding
# Category: Terminal
# Tags: terminal, keys, forwarding, passthrough
---
All keys except `Ctrl+\` are forwarded directly to the terminal job. Use `Ctrl+\` as escape prefix for Neovim commands.

#### Example

```vim
" In terminal mode:
ls<Enter>           " sent to terminal
Ctrl+c              " sent to terminal (interrupt)
Ctrl+\ Ctrl+n       " Neovim command (exit to normal)
```
===
# Title: Open terminal in current window
# Category: Terminal
# Tags: terminal, open, current, window
---
Use `:terminal` or `:term` to open terminal in current window.

#### Example

```vim
:terminal     " open terminal in current window
:term         " shorthand for :terminal
:term bash    " open specific shell
```
===
# Title: Open terminal in new window
# Category: Terminal
# Tags: terminal, window, split, tab
---
Use `:sp | terminal` for horizontal split, `:vsp | terminal` for vertical split, `:tabe | terminal` for new tab.

#### Example

```vim
:sp | terminal   " horizontal split terminal
:vsp | terminal  " vertical split terminal  
:tabe | terminal " terminal in new tab
```
===
# Title: Terminal scrollback buffer
# Category: Terminal
# Tags: terminal, scrollback, buffer, history
---
In normal mode, you can navigate terminal scrollback buffer like any other buffer using standard movement commands.

#### Example

```vim
" In terminal normal mode (after Ctrl+\ Ctrl+n):
gg    " go to top of scrollback
G     " go to bottom  
/text " search in terminal output
```
===
# Title: Terminal insert mode
# Category: Terminal
# Tags: terminal, insert, mode, interaction
---
Use `i`, `a`, or `A` to return to terminal mode from normal mode for terminal interaction.

#### Example

```vim
" From terminal normal mode:
i   " enter terminal mode at cursor
a   " enter terminal mode after cursor  
A   " enter terminal mode at end of line
```
===