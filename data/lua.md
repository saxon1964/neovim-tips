Run inline Lua code
# Title: Run inline Lua code
# Category: Lua
# Tags: lua, inline, execute
---
Use `:lua` to run Lua code directly in Neovim.

#### Example

```vim
:lua print("Hello from Lua!")
```
===

Debug Lua values
# Title: Debug Lua values
# Category: Lua
# Tags: lua, debug, inspect
---
Use `vim.inspect()` to debug and pretty-print Lua values.

#### Example

```vim
:lua print(vim.inspect(vim.fn.getbufinfo()))
```
===

Run current Lua file
# Title: Run current Lua file
# Category: Lua
# Tags: lua, file, execute
---
Use `:luafile %` to execute the current Lua file inside Neovim.

#### Example

```vim
:luafile %  " run current Lua file
```
===

Lua keymaps
# Title: Lua keymaps
# Category: Lua
# Tags: lua, keymap, mapping
---
Use `vim.keymap.set()` to create keymaps with inline Lua functions.

#### Example

```vim
:lua vim.keymap.set("n", "<leader>hi", function() print("Hello!") end)
```
===

Lua autocommands
# Title: Lua autocommands
# Category: Lua
# Tags: autocommand, lua, event
---
Use `vim.api.nvim_create_autocmd()` to create autocommands in Lua.

#### Example

```vim
:lua vim.api.nvim_create_autocmd("BufWritePost", {pattern = "*.lua", callback = function() print("Saved!") end})
```
===

View loaded Lua modules
# Title: View loaded Lua modules
# Category: Lua
# Tags: modules, loaded, debug
---
Use `package.loaded` to view all loaded Lua modules.

#### Example

```vim
:lua print(vim.inspect(package.loaded))
```
===
