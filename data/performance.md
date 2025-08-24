# Title: Profile startup time
# Category: Performance
# Tags: profile, startup, performance
---
Use `nvim --startuptime profile.log` to profile Neovim startup time.

#### Example

```bash
nvim --startuptime profile.log
```
===
# Title: Lazy load plugins
# Category: Performance
# Tags: lazy, loading, plugins, optimization
---
Use lazy loading for plugins that aren't needed immediately to improve startup time.

#### Example

```lua
-- lazy.nvim example
{
  "telescope.nvim",
  cmd = "Telescope",  -- load only when command is used
  keys = "<leader>ff" -- load only when key is pressed
}
```
===
# Title: Disable unused features
# Category: Performance
# Tags: disable, features, optimization, settings
---
Disable unused built-in features to improve performance and reduce memory usage.

#### Example

```lua
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
```
===
# Title: Optimize updatetime
# Category: Performance
# Tags: updatetime, performance, responsiveness
---
Set appropriate updatetime for better responsiveness (default 4000ms is often too slow).

#### Example

```lua
vim.opt.updatetime = 250  -- faster completion and diagnostics
```
===
# Title: Use swap files efficiently
# Category: Performance
# Tags: swap, files, memory, performance
---
Configure swap files for better performance and crash recovery.

#### Example

```lua
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand('~/.local/share/nvim/swap//')
vim.opt.updatecount = 100  -- write swap after 100 keystrokes
```
===
# Title: Optimize line numbers
# Category: Performance
# Tags: numbers, relative, performance, display
---
Use relative line numbers only when needed, as they can impact performance on large files.

#### Example

```lua
vim.opt.number = true
vim.opt.relativenumber = false  -- disable for better performance
-- Or enable only in normal mode
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave'}, {
  pattern = '*',
  command = 'set relativenumber'
})
```
===
# Title: Reduce redraw frequency
# Category: Performance
# Tags: redraw, display, performance, optimization
---
Use lazyredraw to improve performance during macros and complex operations.

#### Example

```lua
vim.opt.lazyredraw = true  -- don't redraw during macros
```
===
# Title: Profile Lua code
# Category: Performance
# Tags: profile, lua, performance, debug
---
Use built-in Lua profiler to identify performance bottlenecks in your config.

#### Example

```lua
-- Start profiler
vim.loop.fs_open('/tmp/profile.log', 'w', 438, function(err, fd)
  if not err then
    vim.loop.fs_close(fd)
  end
end)

-- Profile code
local start = vim.loop.hrtime()
-- your code here
local elapsed = vim.loop.hrtime() - start
print(string.format("Elapsed: %.2fms", elapsed / 1e6))
```
===
# Title: Optimize file type detection
# Category: Performance
# Tags: filetype, detection, performance
---
Use efficient filetype detection and disable unnecessary patterns.

#### Example

```lua
vim.g.do_filetype_lua = 1  -- use Lua for filetype detection
vim.g.did_load_filetypes = 0  -- don't use Vim script detection
```
===
# Title: Memory usage monitoring
# Category: Performance
# Tags: memory, monitoring, usage, debug
---
Monitor Neovim memory usage to identify memory leaks or excessive usage.

#### Example

```vim
:lua print(collectgarbage("count") .. " KB")  " current memory usage
:lua collectgarbage()  " force garbage collection
```
===
# Title: Syntax highlighting limits
# Category: Performance
# Tags: syntax, highlighting, limits, large files
---
Set limits for syntax highlighting to maintain performance on large files.

#### Example

```lua
vim.opt.synmaxcol = 200  -- don't highlight lines longer than 200 chars
vim.g.syntax_timeout = 1000  -- timeout after 1 second
```
===