System clipboard sync
# Title: System clipboard sync
# Category: Clipboard
# Tags: clipboard, system, sync
---
Use `vim.opt.clipboard="unnamedplus"` to sync yank/paste with system clipboard automatically.

#### Example

```vim
:lua vim.opt.clipboard = "unnamedplus"
```
===

Set system clipboard from Lua
# Title: Set system clipboard from Lua
# Category: Clipboard
# Tags: clipboard, lua, register
---
Use `vim.fn.setreg("+", "text")` to set system clipboard content from Lua.

#### Example

```vim
:lua vim.fn.setreg("+", "hello world")
```
===
