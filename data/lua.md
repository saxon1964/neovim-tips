# Title: Run inline Lua code
# Category: Lua
# Tags: lua, inline, execute
---
Use `:lua` to run Lua code directly in Neovim.

```vim
:lua print("Hello from Lua!")
```
***
# Title: Debug Lua values
# Category: Lua
# Tags: lua, debug, inspect
---
Use `vim.inspect()` to debug and pretty-print Lua values.

```vim
:lua print(vim.inspect(vim.fn.getbufinfo()))
```
***
# Title: Run current Lua file
# Category: Lua
# Tags: lua, file, execute
---
Use `:luafile %` to execute the current Lua file inside Neovim.

```vim
:luafile %  " run current Lua file
```
***
# Title: Lua keymaps
# Category: Lua
# Tags: lua, keymap, mapping
---
Use `vim.keymap.set()` to create keymaps with inline Lua functions.

```vim
:lua vim.keymap.set("n", "<leader>hi", function() print("Hello!") end)
```
***
# Title: View loaded Lua modules
# Category: Lua
# Tags: modules, loaded, debug
---
Use `package.loaded` to view all loaded Lua modules.

```vim
:lua print(vim.inspect(package.loaded))
```
***
# Title: Choose init.vim or init.lua
# Category: Lua
# Tags: lua, configuration, init
---
Use either `init.vim` or `init.lua` for configuration, but not both simultaneously. Neovim will prioritize one over the other.

```lua
-- init.lua example
vim.opt.number = true
vim.opt.relativenumber = true
```
***
# Title: Load Lua modules with require
# Category: Lua
# Tags: lua, modules, require
---
Use `require()` to load Lua modules from the `lua/` directory in your runtime path. Modules are automatically cached after first load.

```lua
-- Load lua/mymodule.lua
local mymodule = require('mymodule')

-- Load lua/other_modules/anothermodule.lua
local another = require('other_modules.anothermodule')
```
***
# Title: Safely load modules with pcall
# Category: Lua
# Tags: lua, modules, error-handling
---
Use `pcall()` to safely load modules and handle potential errors without crashing.

```lua
local ok, module = pcall(require, 'optional_module')
if ok then
  module.setup()
else
  print("Module not found: " .. module)
end
```
***
# Title: Execute Vim commands from Lua
# Category: Lua
# Tags: lua, vim-commands, vim.cmd
---
Use `vim.cmd()` to execute any Vim command from Lua code.

```lua
-- Single command
vim.cmd("colorscheme habamax")

-- Multiple commands
vim.cmd([[
  set number
  set relativenumber
  highlight Normal guibg=NONE
]])
```
***
# Title: Call Vimscript functions from Lua
# Category: Lua
# Tags: lua, vimscript, vim.fn
---
Use `vim.fn` to call any Vimscript or user-defined function with automatic type conversion.

```lua
-- Call built-in function
local line_count = vim.fn.line('$')

-- Call user function
local result = vim.fn.MyCustomFunction('arg1', 'arg2')
```
***
# Title: Set global variables in Lua
# Category: Lua
# Tags: lua, variables, vim.g
---
Use `vim.g` to set global variables with native Lua types.

```lua
-- Set global variable
vim.g.mapleader = ' '
vim.g.my_config = { key = "value", enabled = true }

-- Read global variable
local leader = vim.g.mapleader
```
***
# Title: Set buffer-local variables
# Category: Lua
# Tags: lua, variables, buffer, vim.b
---
Use `vim.b` to set buffer-local variables for the current or specific buffer.

```lua
-- Current buffer
vim.b.current_syntax = 'lua'

-- Specific buffer
vim.b[5].custom_data = { foo = "bar" }
```
***
# Title: Set window-local variables
# Category: Lua
# Tags: lua, variables, window, vim.w
---
Use `vim.w` to set window-local variables.

```lua
-- Current window
vim.w.quickfix_title = "My Results"

-- Specific window
vim.w[1001].custom_setting = true
```
***
# Title: Set tabpage-local variables
# Category: Lua
# Tags: lua, variables, tabpage, vim.t
---
Use `vim.t` to set tabpage-local variables.

```lua
-- Current tabpage
vim.t.tab_name = "Main"

-- Specific tabpage
vim.t[2].custom_data = {}
```
***
# Title: Set options with vim.opt
# Category: Lua
# Tags: lua, options, vim.opt
---
Use `vim.opt` to set options with a convenient Lua interface that supports advanced operations.

```lua
-- Set single option
vim.opt.number = true
vim.opt.tabstop = 4

-- Append to list option
vim.opt.wildignore:append('*.pyc')

-- Remove from list option
vim.opt.wildignore:remove('*.o')
```
***
# Title: Set options with vim.o
# Category: Lua
# Tags: lua, options, vim.o
---
Use `vim.o` for direct variable-like access to global options.

```lua
-- Set global option
vim.o.ignorecase = true
vim.o.smartcase = true

-- More concise than vim.opt for simple assignments
vim.o.updatetime = 250
```
***
# Title: Set buffer-local options
# Category: Lua
# Tags: lua, options, buffer, vim.bo
---
Use `vim.bo` to set buffer-local options for the current or specific buffer.

```lua
-- Current buffer
vim.bo.filetype = 'lua'
vim.bo.expandtab = true

-- Specific buffer
vim.bo[5].tabstop = 2
```
***
# Title: Set window-local options
# Category: Lua
# Tags: lua, options, window, vim.wo
---
Use `vim.wo` to set window-local options.

```lua
-- Current window
vim.wo.number = true
vim.wo.wrap = false

-- Specific window
vim.wo[1001].cursorline = true
```
***
# Title: Create keymaps with vim.keymap.set
# Category: Lua
# Tags: lua, keymap, mapping, vim.keymap
---
Use `vim.keymap.set()` to create keymaps for multiple modes with options.

```lua
-- Basic mapping
vim.keymap.set('n', '<leader>w', ':write<CR>')

-- Mapping with Lua function
vim.keymap.set('n', '<leader>h', function()
  print("Hello!")
end, { desc = "Say hello" })

-- Multiple modes
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = "Yank to clipboard" })

-- Buffer-local mapping
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0, desc = "Hover documentation" })
```
***
# Title: Create autocommands with nvim_create_autocmd
# Category: Lua
# Tags: lua, autocommands, api
---
Use `vim.api.nvim_create_autocmd()` to create autocommands with Lua callbacks.

```lua
-- Simple autocommand
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- With multiple events
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.c", "*.h"},
  callback = function()
    vim.bo.cindent = true
  end,
})
```
***
# Title: Create autocommand groups
# Category: Lua
# Tags: lua, autocommands, groups, api
---
Use `vim.api.nvim_create_augroup()` to organize autocommands into groups.

```lua
-- Create group
local mygroup = vim.api.nvim_create_augroup("MyGroup", { clear = true })

-- Add autocommands to group
vim.api.nvim_create_autocmd("BufWritePre", {
  group = mygroup,
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})
```
***
# Title: Use Lua heredoc in Vimscript
# Category: Lua
# Tags: lua, vimscript, heredoc
---
Use Lua heredoc syntax to write Lua code blocks in `init.vim`.

```vim
lua << EOF
  local function hello()
    print("Hello from Lua in Vimscript!")
  end
  hello()
EOF
```
***
# Title: Call Lua functions from Vimscript
# Category: Lua
# Tags: lua, vimscript, interop
---
Use `luaeval()` or `v:lua` to call Lua functions from Vimscript.

```vim
" Using luaeval()
call luaeval('require("mymodule").my_function(_A)', [arg1, arg2])

" Using v:lua in mappings
nnoremap <leader>f <Cmd>lua require('mymodule').my_function()<CR>

" Using v:lua in expressions
let result = v:lua.vim.fn.has('nvim-0.9')
```
***
# Title: Module structure best practices
# Category: Lua
# Tags: lua, modules, best-practices
---
Structure Lua modules using the standard pattern with local tables and explicit returns.

```lua
-- lua/mymodule.lua
local M = {}

M.config = {
  enabled = true,
}

function M.setup(opts)
  M.config = vim.tbl_extend('force', M.config, opts or {})
end

function M.do_something()
  if M.config.enabled then
    print("Doing something!")
  end
end

return M
```
***
# Title: Access Neovim API functions
# Category: Lua
# Tags: lua, api, vim.api
---
Use `vim.api` to access the full Neovim C API with functions prefixed by `nvim_`.

```lua
-- Buffer operations
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"Line 1", "Line 2"})

-- Window operations
local win = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_height(win, 20)

-- Get/set options
local value = vim.api.nvim_get_option_value('number', {})
vim.api.nvim_set_option_value('number', true, {})
```
***
# Title: Work with buffer text in Lua
# Category: Lua
# Tags: lua, buffer, text, api
---
Use buffer API functions to read and modify buffer content.

```lua
-- Get lines from buffer
local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

-- Set lines in buffer
vim.api.nvim_buf_set_lines(0, 0, -1, false, {"New line 1", "New line 2"})

-- Get specific line
local current_line = vim.api.nvim_get_current_line()

-- Set specific line
vim.api.nvim_set_current_line("Modified line")
```
***
# Title: Create user commands in Lua
# Category: Lua
# Tags: lua, commands, user-commands, api
---
Use `vim.api.nvim_create_user_command()` to create custom commands with Lua callbacks.

```lua
-- Simple command
vim.api.nvim_create_user_command('Hello', function()
  print('Hello!')
end, {})

-- Command with arguments
vim.api.nvim_create_user_command('Greet', function(opts)
  print('Hello, ' .. opts.args)
end, { nargs = 1 })

-- Command with completion
vim.api.nvim_create_user_command('EditConfig', function(opts)
  vim.cmd.edit(opts.args)
end, {
  nargs = 1,
  complete = 'file',
})
```
***
# Title: Access environment variables in Lua
# Category: Lua
# Tags: lua, environment, vim.env
---
Use `vim.env` to access and set environment variables.

```lua
-- Read environment variable
local home = vim.env.HOME
local editor = vim.env.EDITOR

-- Set environment variable
vim.env.MY_VAR = "value"
```
***
# Title: Use vim.loop for async operations
# Category: Lua
# Tags: lua, async, libuv, vim.loop
---
Use `vim.loop` (luv) to access libuv for asynchronous operations.

```lua
-- File system operations
vim.loop.fs_stat('myfile.txt', function(err, stat)
  if stat then
    print('File size: ' .. stat.size)
  end
end)

-- Timers
local timer = vim.loop.new_timer()
timer:start(1000, 0, function()
  print('Timer fired!')
  timer:close()
end)
```
***
# Title: Schedule callbacks with vim.schedule
# Category: Lua
# Tags: lua, async, callbacks, vim.schedule
---
Use `vim.schedule()` to schedule callbacks in the main event loop safely.

```lua
-- Schedule from async context
vim.loop.fs_stat('file.txt', function(err, stat)
  vim.schedule(function()
    -- Safe to call Neovim API here
    print(vim.inspect(stat))
  end)
end)
```
***
# Title: Use vim.notify for notifications
# Category: Lua
# Tags: lua, notifications, ui
---
Use `vim.notify()` to show notifications with different log levels.

```lua
-- Basic notification
vim.notify("Operation completed")

-- With log level
vim.notify("Warning message", vim.log.levels.WARN)
vim.notify("Error occurred", vim.log.levels.ERROR)
vim.notify("Info message", vim.log.levels.INFO)
```
***
# Title: Deep merge tables with vim.tbl_deep_extend
# Category: Lua
# Tags: lua, tables, utilities
---
Use `vim.tbl_deep_extend()` to deeply merge tables, useful for configuration.

```lua
local defaults = {
  ui = { border = "rounded" },
  lsp = { enabled = true },
}

local user_config = {
  ui = { width = 80 },
  lsp = { enabled = false },
}

local config = vim.tbl_deep_extend('force', defaults, user_config)
-- Result: { ui = { border = "rounded", width = 80 }, lsp = { enabled = false } }
```
***
# Title: Check if table contains key
# Category: Lua
# Tags: lua, tables, utilities
---
Use `vim.tbl_contains()` to check if a table contains a value.

```lua
local modes = {'n', 'v', 'i'}

if vim.tbl_contains(modes, 'n') then
  print("Normal mode included")
end
```
***
# Title: Filter and map tables
# Category: Lua
# Tags: lua, tables, functional
---
Use `vim.tbl_filter()` and `vim.tbl_map()` for functional table operations.

```lua
-- Filter table
local numbers = {1, 2, 3, 4, 5, 6}
local evens = vim.tbl_filter(function(v)
  return v % 2 == 0
end, numbers)
-- Result: {2, 4, 6}

-- Map table
local doubled = vim.tbl_map(function(v)
  return v * 2
end, numbers)
-- Result: {2, 4, 6, 8, 10, 12}
```
***
# Title: Check if list is empty
# Category: Lua
# Tags: lua, tables, utilities
---
Use `vim.tbl_isempty()` to check if a table is empty.

```lua
local my_table = {}

if vim.tbl_isempty(my_table) then
  print("Table is empty")
end
```
***
# Title: Validate function arguments
# Category: Lua
# Tags: lua, validation, utilities
---
Use `vim.validate()` to validate function arguments with clear error messages.

```lua
function my_function(opts)
  vim.validate({
    name = {opts.name, 'string'},
    age = {opts.age, 'number', true},  -- true means optional
    callback = {opts.callback, 'function'},
  })

  -- Function implementation
end
```
***
# Title: Split and join strings
# Category: Lua
# Tags: lua, strings, utilities
---
Use `vim.split()` to split strings into tables.

```lua
-- Split by delimiter
local parts = vim.split("foo,bar,baz", ",")
-- Result: {"foo", "bar", "baz"}

-- Split by pattern
local lines = vim.split(text, "\n", { plain = true })
```
***
# Title: Trim whitespace from strings
# Category: Lua
# Tags: lua, strings, utilities
---
Use `vim.trim()` to remove leading and trailing whitespace.

```lua
local cleaned = vim.trim("  hello world  ")
-- Result: "hello world"
```
***
# Title: Get LSP clients for buffer
# Category: Lua
# Tags: lua, lsp, buffers
---
Use `vim.lsp.get_clients()` to get LSP clients attached to a buffer.

```lua
-- Get clients for current buffer
local clients = vim.lsp.get_clients({ bufnr = 0 })

for _, client in ipairs(clients) do
  print("Client: " .. client.name)
end
```
***
# Title: Format buffer with LSP
# Category: Lua
# Tags: lua, lsp, formatting
---
Use `vim.lsp.buf.format()` to format the current buffer using attached LSP servers.

```lua
-- Format current buffer
vim.lsp.buf.format()

-- Format with options
vim.lsp.buf.format({
  async = true,
  timeout_ms = 2000,
  filter = function(client)
    return client.name ~= "tsserver"
  end,
})
```
***
# Title: Execute Lua from command line
# Category: Lua
# Tags: lua, command-line, inline
---
Use `:lua` with `=` to evaluate and print expressions quickly.

```vim
:lua =vim.version()
:lua =vim.fn.expand('%:p')
:lua =package.path
```
***
# Title: Reload Lua modules during development
# Category: Lua
# Tags: lua, modules, development, reload
---
Clear `package.loaded` to force reload of a module during development.

```lua
-- Reload a module
package.loaded['mymodule'] = nil
local mymodule = require('mymodule')

-- Helper function to reload
local function reload_module(name)
  package.loaded[name] = nil
  return require(name)
end

local mymod = reload_module('mymodule')
```
***
# Title: Get current mode in Lua
# Category: Lua
# Tags: lua, mode, api
---
Use `vim.api.nvim_get_mode()` to get the current editor mode.

```lua
local mode = vim.api.nvim_get_mode()
print("Current mode: " .. mode.mode)

-- Check specific mode
if mode.mode == 'n' then
  print("In normal mode")
end
```
***
# Title: Set cursor position in Lua
# Category: Lua
# Tags: lua, cursor, navigation
---
Use `vim.api.nvim_win_set_cursor()` to set cursor position programmatically.

```lua
-- Set cursor to line 10, column 5 (1-indexed line, 0-indexed column)
vim.api.nvim_win_set_cursor(0, {10, 5})

-- Get current cursor position
local cursor = vim.api.nvim_win_get_cursor(0)
local row, col = cursor[1], cursor[2]
```
***
# Title: Execute normal mode commands from Lua
# Category: Lua
# Tags: lua, normal-mode, commands
---
Use `vim.cmd.normal()` or `vim.api.nvim_feedkeys()` to execute normal mode commands.

```lua
-- Using vim.cmd
vim.cmd.normal('gg')  -- Go to first line
vim.cmd.normal('viw')  -- Visual select inner word

-- Using feedkeys for more control
vim.api.nvim_feedkeys(
  vim.api.nvim_replace_termcodes('<C-w>v', true, false, true),
  'n',
  false
)
```
***
# Title: Work with quickfix list in Lua
# Category: Lua
# Tags: lua, quickfix, diagnostics
---
Use `vim.fn.setqflist()` and `vim.fn.getqflist()` to work with quickfix list.

```lua
-- Set quickfix list
vim.fn.setqflist({
  {filename = 'file1.lua', lnum = 10, text = 'Error message'},
  {filename = 'file2.lua', lnum = 20, text = 'Warning'},
})

-- Open quickfix window
vim.cmd.copen()

-- Get quickfix items
local qf_items = vim.fn.getqflist()
```
***
# Title: Create buffer-local keymaps
# Category: Lua
# Tags: lua, keymap, buffer-local
---
Use the `buffer` option to create buffer-local keymaps that only work in specific buffers.

```lua
-- Buffer-local keymap for current buffer
vim.keymap.set('n', '<leader>r', ':!python %<CR>', {
  buffer = 0,
  desc = "Run Python file"
})

-- Buffer-local keymap for specific buffer
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
  buffer = bufnr,
  desc = "LSP Hover"
})
```
***
# Title: Use vim.ui.select for user selection
# Category: Lua
# Tags: lua, ui, selection
---
Use `vim.ui.select()` to prompt user to select from a list of options.

```lua
vim.ui.select(
  {'Option 1', 'Option 2', 'Option 3'},
  {
    prompt = 'Choose an option:',
    format_item = function(item)
      return "→ " .. item
    end,
  },
  function(choice)
    if choice then
      print('You selected: ' .. choice)
    end
  end
)
```
***
# Title: Use vim.ui.input for user input
# Category: Lua
# Tags: lua, ui, input
---
Use `vim.ui.input()` to prompt user for text input.

```lua
vim.ui.input({
  prompt = 'Enter your name: ',
  default = 'Anonymous',
}, function(input)
  if input then
    print('Hello, ' .. input)
  end
end)
```
***
# Title: Defer function execution
# Category: Lua
# Tags: lua, defer, utilities
---
Use `vim.defer_fn()` to execute a function after a delay.

```lua
-- Execute after 1000ms (1 second)
vim.defer_fn(function()
  print("Delayed message")
end, 1000)

-- Useful for delayed UI updates
vim.defer_fn(function()
  vim.notify("Setup complete!", vim.log.levels.INFO)
end, 500)
```
***
# Title: Create classes with metatables
# Category: Lua
# Tags: lua, oop, classes, metatables
---
Use metatables to create class-like structures in Lua for object-oriented programming. This pattern uses `__index` metamethod for method lookup and inheritance.

```lua
-- Define a base class
---@class Animal
local Animal = {}

-- Constructor method
function Animal:new(name, type)
  local instance = {
    name = name,
    type = type or "unknown"
  }
  -- Set metatable to enable inheritance
  self.__index = self
  return setmetatable(instance, self)
end

-- Instance method
function Animal:speak()
  print(self.name .. " makes a sound")
end

function Animal:info()
  print("I am a " .. self.type .. " named " .. self.name)
end

-- Create instance
local generic = Animal:new("Rex", "animal")
generic:speak()  -- "Rex makes a sound"
generic:info()   -- "I am a animal named Rex"
```
***
# Title: Implement class inheritance with metatables
# Category: Lua
# Tags: lua, oop, inheritance, metatables
---
Create derived classes by calling the parent's constructor and extending functionality. The `__index` metamethod enables method lookup in the parent class.

```lua
-- Base class
---@class Animal
local Animal = {}

function Animal:new(name, type)
  local instance = { name = name, type = type }
  self.__index = self
  return setmetatable(instance, self)
end

function Animal:info()
  print("I am a " .. self.type)
end

-- Derived class (inherits from Animal)
---@class Dog : Animal
local Dog = Animal:new(nil, "dog")

-- Override parent method
function Dog:info()
  print("Woof! I am a " .. self.type .. " and my name is " .. self.name)
end

-- Add new method specific to Dog
function Dog:fetch()
  print(self.name .. " is fetching the ball!")
end

-- Create Dog instance
local buddy = Dog:new("Buddy", "dog")
buddy:info()   -- "Woof! I am a dog and my name is Buddy"
buddy:fetch()  -- "Buddy is fetching the ball!"

-- Another derived class
---@class Cat : Animal
local Cat = Animal:new(nil, "cat")

function Cat:info()
  print("Meow! I am a " .. self.type)
end

function Cat:scratch()
  print(self.name .. " scratches the furniture")
end

local whiskers = Cat:new("Whiskers", "cat")
whiskers:info()     -- "Meow! I am a cat"
whiskers:scratch()  -- "Whiskers scratches the furniture"
```
***
# Title: Create private state with closures
# Category: Lua
# Tags: lua, oop, encapsulation, closures
---
Use closures to create private state that cannot be accessed from outside the object, providing true encapsulation.

```lua
-- Factory function that creates objects with private state
local function BankAccount(initial_balance)
  -- Private variables (not accessible outside)
  local balance = initial_balance or 0
  local transaction_history = {}

  -- Public interface
  local self = {}

  function self.deposit(amount)
    if amount > 0 then
      balance = balance + amount
      table.insert(transaction_history, {type = "deposit", amount = amount})
      return true
    end
    return false
  end

  function self.withdraw(amount)
    if amount > 0 and amount <= balance then
      balance = balance - amount
      table.insert(transaction_history, {type = "withdraw", amount = amount})
      return true
    end
    return false
  end

  function self.get_balance()
    return balance
  end

  function self.get_history()
    -- Return a copy to prevent external modification
    local copy = {}
    for i, v in ipairs(transaction_history) do
      copy[i] = vim.deepcopy(v)
    end
    return copy
  end

  return self
end

-- Usage
local account = BankAccount(100)
account.deposit(50)
account.withdraw(30)
print(account.get_balance())  -- 120
-- Cannot access 'balance' directly - it's private!
```
***
# Title: Plugin configuration with metatables
# Category: Lua
# Tags: lua, oop, metatables, configuration, plugin
---
Use metatables to create flexible configuration systems that provide default values while allowing user customization.

```lua
-- Create a configuration system with defaults
local function make_config_mt(defaults)
  return {
    -- Provide default values when key doesn't exist
    __index = function(t, k)
      local default_value = defaults[k]
      if type(default_value) ~= 'table' then
        return default_value
      end
      -- For nested tables, create a new table with metatable
      rawset(t, k, {})
      setmetatable(t[k], make_config_mt(default_value))
      return t[k]
    end,

    -- Handle setting new values
    __newindex = function(t, k, v)
      rawset(t, k, v)
      -- If value is a table, give it the same metatable behavior
      if type(v) == 'table' and defaults[k] then
        setmetatable(v, make_config_mt(defaults[k]))
      end
    end
  }
end

-- Default configuration
local defaults = {
  ui = {
    border = "rounded",
    width = 80,
    height = 20,
  },
  lsp = {
    enabled = true,
    timeout = 1000,
  },
  debug = false,
}

-- Create user config with defaults
local config = {}
setmetatable(config, make_config_mt(defaults))

-- Access default values without setting them
print(config.ui.border)  -- "rounded"
print(config.debug)      -- false

-- Override specific values
config.ui.width = 100
config.debug = true

-- Nested tables work automatically
config.lsp.timeout = 2000

print(vim.inspect(config))
```
***
# Title: Method chaining with metatables
# Category: Lua
# Tags: lua, oop, metatables, fluent-interface
---
Implement method chaining (fluent interface) by returning `self` from methods, allowing multiple method calls in sequence.

```lua
-- Query builder with method chaining
---@class QueryBuilder
local QueryBuilder = {}

function QueryBuilder:new()
  local instance = {
    _table = nil,
    _where = {},
    _limit = nil,
    _order = nil,
  }
  self.__index = self
  return setmetatable(instance, self)
end

function QueryBuilder:from(table_name)
  self._table = table_name
  return self  -- Return self for chaining
end

function QueryBuilder:where(condition)
  table.insert(self._where, condition)
  return self
end

function QueryBuilder:order_by(field)
  self._order = field
  return self
end

function QueryBuilder:limit(n)
  self._limit = n
  return self
end

function QueryBuilder:build()
  local query = "SELECT * FROM " .. self._table

  if #self._where > 0 then
    query = query .. " WHERE " .. table.concat(self._where, " AND ")
  end

  if self._order then
    query = query .. " ORDER BY " .. self._order
  end

  if self._limit then
    query = query .. " LIMIT " .. self._limit
  end

  return query
end

-- Usage with method chaining
local query = QueryBuilder:new()
  :from("users")
  :where("age > 18")
  :where("active = true")
  :order_by("name")
  :limit(10)
  :build()

print(query)
-- "SELECT * FROM users WHERE age > 18 AND active = true ORDER BY name LIMIT 10"
```
***
# Title: Implement __tostring metamethod
# Category: Lua
# Tags: lua, oop, metatables, metamethods
---
Use the `__tostring` metamethod to customize how objects are converted to strings, useful for debugging and logging.

```lua
---@class Person
local Person = {}

function Person:new(name, age)
  local instance = {
    name = name,
    age = age,
  }
  self.__index = self

  -- Define how this object should be converted to string
  self.__tostring = function(obj)
    return string.format("Person(name='%s', age=%d)", obj.name, obj.age)
  end

  return setmetatable(instance, self)
end

-- Usage
local person = Person:new("Alice", 30)

-- Automatically calls __tostring when converted to string
print(person)              -- "Person(name='Alice', age=30)"
print("Hello " .. tostring(person))  -- "Hello Person(name='Alice', age=30)"

-- Useful in logging
vim.notify("Created: " .. tostring(person))
```
***
# Title: Implement operator overloading with metamethods
# Category: Lua
# Tags: lua, oop, metatables, metamethods, operators
---
Use metamethods to overload operators like `+`, `-`, `*`, `==`, etc., making custom objects behave like built-in types.

```lua
---@class Vector
local Vector = {}

function Vector:new(x, y)
  local instance = { x = x or 0, y = y or 0 }
  self.__index = self

  -- Overload addition operator
  self.__add = function(v1, v2)
    return Vector:new(v1.x + v2.x, v1.y + v2.y)
  end

  -- Overload subtraction operator
  self.__sub = function(v1, v2)
    return Vector:new(v1.x - v2.x, v1.y - v2.y)
  end

  -- Overload multiplication (scalar)
  self.__mul = function(v, scalar)
    if type(v) == "number" then
      v, scalar = scalar, v
    end
    return Vector:new(v.x * scalar, v.y * scalar)
  end

  -- Overload equality operator
  self.__eq = function(v1, v2)
    return v1.x == v2.x and v1.y == v2.y
  end

  -- Custom string representation
  self.__tostring = function(v)
    return string.format("Vector(%d, %d)", v.x, v.y)
  end

  return setmetatable(instance, self)
end

function Vector:length()
  return math.sqrt(self.x * self.x + self.y * self.y)
end

-- Usage
local v1 = Vector:new(3, 4)
local v2 = Vector:new(1, 2)

local v3 = v1 + v2        -- Vector(4, 6)
local v4 = v1 - v2        -- Vector(2, 2)
local v5 = v1 * 2         -- Vector(6, 8)
local v6 = 3 * v2         -- Vector(3, 6)

print(v3)                 -- "Vector(4, 6)"
print(v1 == v2)           -- false
print(v1 == Vector:new(3, 4))  -- true
print("Length:", v1:length())  -- "Length: 5.0"
```
***
# Title: Create singleton pattern with metatables
# Category: Lua
# Tags: lua, oop, singleton, design-patterns
---
Implement the singleton pattern to ensure only one instance of a class exists, useful for managing global state.

```lua
-- Singleton implementation
local Singleton = {}
local instance = nil

function Singleton:new()
  -- Return existing instance if it exists
  if instance then
    return instance
  end

  -- Create new instance
  local obj = {
    data = {},
    created_at = os.time(),
  }

  self.__index = self
  instance = setmetatable(obj, self)
  return instance
end

function Singleton:set(key, value)
  self.data[key] = value
end

function Singleton:get(key)
  return self.data[key]
end

-- Usage
local s1 = Singleton:new()
s1:set("config", "value1")

local s2 = Singleton:new()
print(s2:get("config"))  -- "value1"

print(s1 == s2)  -- true (same instance)
```
***
# Title: Create abstract base classes with error checking
# Category: Lua
# Tags: lua, oop, abstract-class, validation
---
Implement abstract base class pattern that requires derived classes to implement specific methods.

```lua
---@class Shape (abstract)
local Shape = {}

function Shape:new(type)
  local instance = { type = type }
  self.__index = function(t, k)
    -- Check if method must be implemented by subclass
    if k == "area" or k == "perimeter" then
      error(string.format(
        "Abstract method '%s' must be implemented by subclass '%s'",
        k, t.type or "unknown"
      ))
    end
    return self[k]
  end
  return setmetatable(instance, self)
end

---@class Rectangle : Shape
local Rectangle = Shape:new("Rectangle")

function Rectangle:new(width, height)
  local instance = Shape.new(self, "Rectangle")
  instance.width = width
  instance.height = height
  return instance
end

-- Implement required abstract methods
function Rectangle:area()
  return self.width * self.height
end

function Rectangle:perimeter()
  return 2 * (self.width + self.height)
end

---@class Circle : Shape
local Circle = Shape:new("Circle")

function Circle:new(radius)
  local instance = Shape.new(self, "Circle")
  instance.radius = radius
  return instance
end

function Circle:area()
  return math.pi * self.radius * self.radius
end

function Circle:perimeter()
  return 2 * math.pi * self.radius
end

-- Usage
local rect = Rectangle:new(5, 3)
print("Rectangle area:", rect:area())      -- 15
print("Rectangle perimeter:", rect:perimeter())  -- 16

local circle = Circle:new(4)
print("Circle area:", circle:area())       -- ~50.27
print("Circle perimeter:", circle:perimeter())   -- ~25.13

-- This would error: local shape = Shape:new()
-- shape:area() -- Error: Abstract method 'area' must be implemented
```
***
