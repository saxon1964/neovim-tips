# Title: Floating terminal
# Category: Terminal
# Tags: terminal, floating, window
---
Create floating terminal using `vim.api.nvim_open_term()`.

#### Example

```vim
:lua vim.api.nvim_open_term(0, {})
```
===
# Title: Split terminal
# Category: Terminal
# Tags: terminal, split, window
---
Use `:sp | terminal` to open terminal in a horizontal split.

#### Example

```vim
:sp | terminal  " terminal in horizontal split
```
===
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