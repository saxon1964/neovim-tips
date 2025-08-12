Async shell commands
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
