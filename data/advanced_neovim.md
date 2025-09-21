# Title: Lua require and module system
# Category: Advanced Neovim
# Tags: lua, require, module, package
---
Use Lua's require system to load and organize Neovim configuration modules with automatic caching and reloading.

#### Example

```vim
" Create ~/.config/nvim/lua/config/keymaps.lua
:lua require('config.keymaps')
:lua package.loaded['config.keymaps'] = nil  " force reload
:lua R = function(name) package.loaded[name] = nil; return require(name) end
```
***
# Title: Extmarks for persistent highlighting
# Category: Advanced Neovim
# Tags: extmarks, highlight, persistent, namespace
---
Use extmarks to create persistent, trackable highlights that survive buffer changes, unlike matchadd().

#### Example

```vim
:lua ns = vim.api.nvim_create_namespace('my_highlights')
:lua vim.api.nvim_buf_set_extmark(0, ns, 0, 0, {
  end_col=10, hl_group='Search', priority=100
})
:lua vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)  " clear all
```
***
# Title: Virtual text annotations
# Category: Advanced Neovim
# Tags: virtual, text, annotations, inline
---
Use virtual text to display inline annotations like diagnostics, git blame, or documentation without modifying buffer content.

#### Example

```vim
:lua vim.api.nvim_buf_set_extmark(0, ns, vim.fn.line('.')-1, 0, {
  virt_text = {{'← This is a note', 'Comment'}},
  virt_text_pos = 'eol'
})
" Adds virtual text at end of current line
```
***
# Title: Buffer-local variables with vim.b
# Category: Advanced Neovim
# Tags: buffer, local, variables, vim.b
---
Use `vim.b` to access buffer-local variables from Lua, providing cleaner syntax than traditional vim variables.

#### Example

```vim
:lua vim.b.my_setting = 'value'
:lua print(vim.b.my_setting)
:lua vim.b[0].setting = 'buffer 0 specific'
" Cleaner than :let b:my_setting = 'value'
```
***
# Title: Window-local variables with vim.w
# Category: Advanced Neovim
# Tags: window, local, variables, vim.w
---
Use `vim.w` to manage window-local variables from Lua for window-specific settings and state.

#### Example

```vim
:lua vim.w.quickfix_title = 'My Results'
:lua vim.w[1001].custom_setting = true  " specific window ID
:lua for winid, vars in pairs(vim.w) do print(winid, vim.inspect(vars)) end
```
***
# Title: Global variables with vim.g
# Category: Advanced Neovim
# Tags: global, variables, vim.g, configuration
---
Use `vim.g` to manage global variables from Lua, providing type-safe access to vim global variables.

#### Example

```vim
:lua vim.g.mapleader = ' '
:lua vim.g.loaded_netrw = 1        " disable netrw
:lua vim.g.python3_host_prog = '/usr/bin/python3'
" Equivalent to :let g:mapleader = ' '
```
***
# Title: Tab-local variables with vim.t
# Category: Advanced Neovim
# Tags: tab, local, variables, vim.t
---
Use `vim.t` to manage tab-local variables for tab-specific settings and state management.

#### Example

```vim
:lua vim.t.project_root = vim.fn.getcwd()
:lua vim.t[2].custom_title = 'Tab 2'  " specific tab
:lua print('Current tab project:', vim.t.project_root)
```
***
# Title: Lua heredoc syntax
# Category: Advanced Neovim
# Tags: lua, heredoc, multiline, syntax
---
Use Lua heredoc syntax in vimscript for clean multiline Lua code blocks within vim configuration.

#### Example

```vim
lua << EOF
local function my_function()
  print("This is a multiline Lua function")
  vim.cmd('echo "Mixed Lua and Vim commands"')
end
my_function()
EOF
```
***
# Title: Keymap API with descriptions
# Category: Advanced Neovim
# Tags: keymap, api, description, which-key
---
Use `vim.keymap.set()` to create keymaps with descriptions and options, supporting which-key integration.

#### Example

```vim
:lua vim.keymap.set('n', '<leader>f', '<cmd>find<CR>', {
  desc = 'Find file', silent = true, buffer = 0
})
:lua vim.keymap.del('n', '<leader>f')  " delete keymap
```
***
# Title: User commands with Lua
# Category: Advanced Neovim
# Tags: user, command, lua, api
---
Use `vim.api.nvim_create_user_command()` to create custom commands with Lua functions and completion.

#### Example

```vim
:lua vim.api.nvim_create_user_command('Hello', 
  function(opts) print('Hello ' .. opts.args) end,
  {nargs = 1, desc = 'Greet someone'}
)
:Hello World  " prints 'Hello World'
```
***
# Title: Option management with vim.opt
# Category: Advanced Neovim
# Tags: options, vim.opt, configuration, lua
---
Use `vim.opt` for intuitive option management from Lua with proper data types and operations.

#### Example

```vim
:lua vim.opt.number = true
:lua vim.opt.tabstop = 4
:lua vim.opt.path:append('**')     " add to path
:lua vim.opt.wildignore:append('*.pyc')  " add to ignore list
```
***
# Title: Filetype detection API
# Category: Advanced Neovim
# Tags: filetype, detection, api, lua
---
Use `vim.filetype.add()` to register custom filetype detection patterns and functions.

#### Example

```vim
:lua vim.filetype.add({
  extension = { log = 'log', conf = 'conf' },
  filename = { ['.eslintrc'] = 'json' },
  pattern = { ['.*%.env%..*'] = 'sh' }
})
```
***
# Title: Highlight group API
# Category: Advanced Neovim
# Tags: highlight, api, colors, groups
---
Use `vim.api.nvim_set_hl()` to programmatically define and modify highlight groups from Lua.

#### Example

```vim
:lua vim.api.nvim_set_hl(0, 'MyHighlight', {
  fg = '#ff0000', bg = '#000000', bold = true
})
:lua local hl = vim.api.nvim_get_hl(0, {name = 'Comment'})
:lua print(vim.inspect(hl))
```
***
# Title: Snippet expansion API
# Category: Advanced Neovim
# Tags: snippet, expansion, api, completion
---
Use `vim.snippet` API for snippet expansion and navigation without external snippet engines.

#### Example

```vim
:lua vim.snippet.expand('for var in iterable:\n\tpass')
:lua if vim.snippet.active() then vim.snippet.jump(1) end
" Built-in snippet support in Neovim 0.10+
```
***
# Title: Event loop and scheduling
# Category: Advanced Neovim
# Tags: event, loop, schedule, async
---
Use `vim.schedule()` to defer function execution to the next event loop iteration for async operations.

#### Example

```vim
:lua vim.schedule(function()
  print('This runs in the next event loop')
  vim.cmd('echo "Deferred execution"')
end)
" Useful for async operations and avoiding blocking
```
***
# Title: Ring buffer for undo history
# Category: Advanced Neovim
# Tags: undo, history, ring, buffer
---
Use Neovim's enhanced undo system with ring buffer capabilities for advanced undo tree navigation.

#### Example

```vim
:lua print(vim.fn.undotree())  " inspect undo tree
:earlier 1f  " go back 1 file write
:later 1f    " go forward 1 file write  
:undolist    " show numbered undo states
```
***
# Title: Treesitter API access
# Category: Advanced Neovim
# Tags: treesitter, api, ast, parsing
---
Use `vim.treesitter` API to query and manipulate the abstract syntax tree programmatically.

#### Example

```vim
:lua local parser = vim.treesitter.get_parser(0, 'lua')
:lua local tree = parser:parse()[1]
:lua local query = vim.treesitter.query.parse('lua', '(function_declaration) @func')
:lua for id, node in query:iter_captures(tree:root(), 0) do print(node:type()) end
```
***
# Title: RPC and job control (vim.system)
# Category: Advanced Neovim
# Tags: rpc, job, control, async
---
Use `vim.system()` for modern job control and `vim.rpcnotify()` for RPC communication with external processes.

#### Example

```vim
:lua local job = vim.system({'ls', '-la'}, {
  text = true,
  stdout = function(err, data) print(data) end
})
:lua job:wait()  " wait for completion
```
***
# Title: UI events and hooks
# Category: Advanced Neovim
# Tags: ui, events, hooks, interface
---
Use UI event hooks to customize Neovim's behavior for different UI clients and frontends.

#### Example

```vim
:lua vim.api.nvim_set_option_value('guifont', 'Monospace:h12', {})
:lua if vim.g.neovide then vim.g.neovide_cursor_animation_length = 0.1 end
:lua print(vim.loop.os_uname().sysname)  " detect OS
```
***
# Title: Namespace management
# Category: Advanced Neovim
# Tags: namespace, management, api, isolation
---
Use namespaces to isolate highlights, extmarks, and diagnostics from different sources or plugins.

#### Example

```vim
:lua local ns1 = vim.api.nvim_create_namespace('source1')
:lua local ns2 = vim.api.nvim_create_namespace('source2')
:lua vim.api.nvim_buf_set_extmark(0, ns1, 0, 0, {hl_group = 'Search'})
:lua vim.api.nvim_buf_clear_namespace(0, ns1, 0, -1)  " clear ns1 only
```
***
# Title: Deep inspection with vim.inspect
# Category: Advanced Neovim
# Tags: inspect, debug, pretty, print
---
Use `vim.inspect()` to pretty-print complex Lua data structures for debugging and development.

#### Example

```vim
:lua local data = {a = {b = {c = 'nested'}}, list = {1, 2, 3}}
:lua print(vim.inspect(data))
:lua print(vim.inspect(vim.bo, {depth = 1}))  " buffer options
:lua print(vim.inspect(vim.api, {depth = 1}))  " API structure
```
***
# Title: Secure mode and restrictions
# Category: Advanced Neovim
# Tags: secure, mode, restrictions, safety
---
Use secure mode and option restrictions to safely execute untrusted vim configurations and scripts.

#### Example

```vim
:set secure               " enable secure mode
:set exrc                 " allow local .vimrc files
:lua vim.o.secure = true  " Lua equivalent
" Restricts dangerous commands in local configs
```
***
# Title: Runtime path manipulation
# Category: Advanced Neovim
# Tags: runtime, path, rtp, manipulation
---
Use runtime path manipulation to dynamically load configurations and plugins at runtime.

#### Example

```vim
:lua vim.opt.rtp:prepend('~/my-custom-config')
:lua vim.opt.rtp:append('~/additional-plugins')  
:lua for path in vim.gsplit(vim.o.rtp, ',') do print(path) end
" Runtime paths searched for configs and plugins
```
***
# Title: Custom completion sources
# Category: Advanced Neovim
# Tags: completion, custom, source, omnifunc
---
Use `vim.lsp.omnifunc` and custom completion functions to create intelligent completion sources.

#### Example

```vim
function! MyCompletion(findstart, base)
  if a:findstart
    return col('.') - 1
  else
    return ['custom1', 'custom2', 'custom3']
  endif
endfunction
:set omnifunc=MyCompletion
```
***
# Title: Window configuration API
# Category: Advanced Neovim
# Tags: window, configuration, api, layout
---
Use window configuration API for advanced window management and layout control.

#### Example

```vim
:lua vim.api.nvim_win_set_config(0, {
  relative = 'win', win = vim.api.nvim_get_current_win(),
  width = 50, height = 20, row = 5, col = 10
})
:lua local config = vim.api.nvim_win_get_config(0)
:lua print(vim.inspect(config))
```
***
# Title: Health check system
# Category: Advanced Neovim
# Tags: health, check, system, diagnostic
---
Use Neovim's health check system to create custom health checks for your configurations and environments.

#### Example

```vim
:checkhealth            " run all health checks
:checkhealth vim.lsp    " check specific component
" Create ~/.config/nvim/lua/health/myconfig.lua
" with check() function for custom health checks
```
***
# Title: Command preview and substitution
# Category: Advanced Neovim
# Tags: command, preview, substitution, inccommand
---
Use `inccommand` for live preview of Ex commands, especially substitution with real-time feedback.

#### Example

```vim
:set inccommand=split     " preview in split window
:set inccommand=nosplit   " preview inline
:%s/old/new/g            " shows live preview while typing
" Preview works with :substitute, :global, :sort, etc.
```
***
