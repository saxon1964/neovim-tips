# Title: Sandbox mode for safe testing
# Category: Configuration
# Tags: sandbox, safe, testing, command, :sandbox
---
Use `:sandbox` to execute commands safely without side effects like persistent undo entries or autocommands.

```vim
:sandbox set number           " test setting without permanent change
:sandbox echo expand('%')     " safely test expressions
:sandbox source unsafe.vim    " test configuration safely
```
***
# Title: View runtime paths
# Category: Configuration
# Tags: runtime, path, debug
---
Use `:echo &runtimepath` to see all runtime paths Neovim is using.

```vim
:echo &runtimepath  " show runtime paths
```
***
# Title: Enable 256 colors
# Category: Configuration
# Tags: colors, terminal, display
---
Configure terminal to support 256 colors with proper settings.

```vim
" Vimscript:
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
" In shell profile:
export TERM='xterm-256color'
```

```lua
-- Lua:
vim.opt.termguicolors = true  -- Enable true color support in Neovim
-- Note: t_Co and terminal codes are Vim-specific and not needed in Neovim
-- Neovim uses termguicolors for true color support
```
***
# Title: Auto tab completion
# Category: Configuration
# Tags: completion, tab, autocomplete
---
Configure TAB to autocomplete words while preserving normal TAB functionality.

```vim
" Vimscript:
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"
```

```lua
-- Lua:
local function tab_or_complete()
  local col = vim.fn.col('.')
  if col > 1 and vim.fn.getline('.'):sub(col - 2, col):match('^%w') then
    return '<C-N>'
  else
    return '<Tab>'
  end
end

vim.keymap.set('i', '<Tab>', tab_or_complete, { expr = true, desc = 'Tab or complete' })
vim.opt.dictionary = '/usr/dict/words'
```
***
# Title: Restore cursor position
# Category: Configuration
# Tags: cursor, position, session, restore
---
Automatically restore cursor position when reopening files.

```vim
" Vimscript:
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" Enable viminfo
set viminfo='10,\"100,:20,%,n~/.viminfo
```

```lua
-- Lua:
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = 'Restore cursor position'
})

-- Note: Neovim uses ShaDa instead of viminfo
vim.opt.shada = "'10,\"100,:20,%,n~/.local/share/nvim/shada/main.shada"
```
***
# Title: Toggle paste mode
# Category: Configuration
# Tags: paste, toggle, indent, clipboard
---
Set up paste toggle to prevent auto-indenting when pasting from clipboard in terminal.

```vim
" Vimscript:
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
set showmode
" Use F2 before and after pasting external text
```

```lua
-- Lua:
vim.opt.pastetoggle = '<F2>'
vim.keymap.set('n', '<F2>', ':set invpaste paste?<CR>', { desc = 'Toggle paste mode' })
vim.opt.showmode = true
```
***
# Title: Auto-reload file changes
# Category: Configuration
# Tags: auto, reload, file, changes
---
Automatically reload file when it changes externally, with optional warning.

```vim
" Vimscript:
set autoread
" Trigger autoread when cursor stops moving
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
" Or check periodically
au CursorHold * :silent! checktime
```

```lua
-- Lua:
vim.opt.autoread = true

-- Trigger autoread when focus gained or entering buffer
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
  pattern = '*',
  command = 'silent! checktime',
  desc = 'Auto-reload file changes'
})

-- Auto-save on focus lost
vim.api.nvim_create_autocmd({'FocusLost', 'WinLeave'}, {
  pattern = '*',
  command = 'silent! w',
  desc = 'Auto-save on focus lost'
})

-- Check for external changes periodically
vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  command = 'silent! checktime',
  desc = 'Check for external file changes'
})
```
***
# Title: Set color scheme based on time
# Category: Configuration
# Tags: color, scheme, time, automatic
---
Automatically switch between light and dark color schemes based on time of day.

```vim
" Vimscript:
if strftime("%H") < 18 && strftime("%H") > 6
  colorscheme morning
else
  colorscheme evening
endif
```

```lua
-- Lua:
local hour = tonumber(os.date('%H'))
if hour < 18 and hour > 6 then
  vim.cmd('colorscheme morning')
else
  vim.cmd('colorscheme evening')
end
```
***
# Title: Ex commands - set options
# Category: Configuration
# Tags: ex, set, option, toggle, query
---
Use `:set option` to enable, `:set nooption` to disable, `:set option?` to query, `:set option&` to reset to default.

```vim
" Vimscript:
:set number        " enable line numbers
:set nonumber      " disable line numbers
:set number?       " check if line numbers are enabled
:set number&       " reset to default value
```

```lua
-- Lua:
vim.opt.number = true   -- enable line numbers
vim.opt.number = false  -- disable line numbers
print(vim.opt.number:get())  -- check if line numbers are enabled
-- Note: There's no direct Lua equivalent for resetting to default
-- You would need to manually set it to the default value
```
***
# Title: Ex commands - option with values
# Category: Configuration
# Tags: ex, set, value, assignment, string
---
Use `:set option=value` to assign value, `:set option+=value` to append, `:set option-=value` to remove.

```vim
" Vimscript:
:set tabstop=4        " set tab width to 4
:set path+=/usr/include  " add to path
:set path-=/tmp       " remove from path
:set suffixes+=.bak   " add .bak to suffixes
```

```lua
-- Lua:
vim.opt.tabstop = 4   -- set tab width to 4
vim.opt.path:append('/usr/include')  -- add to path
vim.opt.path:remove('/tmp')  -- remove from path
vim.opt.suffixes:append('.bak')  -- add .bak to suffixes
```
***
# Title: Ex commands - autocmds and events
# Category: Configuration
# Tags: ex, autocmd, event, pattern, command
---
Use `:autocmd` to set up automatic commands, `:autocmd!` to clear, `:doautocmd` to trigger events.

```vim
" Vimscript:
:autocmd BufWritePost *.py !python %  " run python after save
:autocmd! BufRead       " clear all BufRead autocmds
:doautocmd BufRead      " trigger BufRead event
:autocmd FileType python setlocal ts=4  " Python-specific settings
```

```lua
-- Lua:
-- Run python after save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.py',
  command = '!python %',
  desc = 'Run python after save'
})

-- Clear all BufRead autocmds - use augroup for better control
vim.api.nvim_clear_autocmds({ event = 'BufRead' })

-- Trigger BufRead event
vim.api.nvim_exec_autocmds('BufRead', { pattern = '*' })

-- Python-specific settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
  end,
  desc = 'Python-specific settings'
})
```
***
# Title: Ex commands - mappings and abbreviations
# Category: Configuration
# Tags: ex, map, abbrev, shortcut, key
---
Use `:map` for mappings, `:abbrev` for abbreviations, `:unmap` and `:unabbrev` to remove.

```vim
" Vimscript:
:map <F2> :w<CR>        " map F2 to save
:imap <F3> <Esc>:w<CR>  " insert mode mapping
:abbrev teh the         " abbreviation for typo
:unmap <F2>             " remove mapping
:unabbrev teh           " remove abbreviation
```

```lua
-- Lua:
vim.keymap.set('n', '<F2>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<F3>', '<Esc>:w<CR>', { desc = 'Save file from insert mode' })
vim.cmd('abbrev teh the')  -- abbreviation for typo
vim.keymap.del('n', '<F2>')  -- remove mapping
vim.cmd('unabbrev teh')  -- remove abbreviation
```
***
# Title: Ex commands - highlight and syntax
# Category: Configuration
# Tags: ex, highlight, syntax, color, group
---
Use `:highlight` to set colors, `:syntax` for syntax highlighting, `:colorscheme` to change themes.

```vim
" Vimscript:
:highlight Comment ctermfg=green   " set comment color
:syntax on                         " enable syntax highlighting
:syntax off                        " disable syntax highlighting
:colorscheme desert                " change color scheme
:highlight clear                   " clear all highlighting
```

```lua
-- Lua:
vim.cmd('highlight Comment ctermfg=green')  -- set comment color
vim.cmd('syntax on')   -- enable syntax highlighting
vim.cmd('syntax off')  -- disable syntax highlighting
vim.cmd('colorscheme desert')  -- change color scheme
vim.cmd('highlight clear')  -- clear all highlighting

-- Or using Lua API for highlight:
vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 'green' })
```
***
# Title: Ex commands - runtime and sourcing
# Category: Configuration
# Tags: ex, source, runtime, script, load
---
Use `:source` to load script, `:runtime` to load from runtime path, `:scriptnames` to list loaded scripts.

```vim
" Vimscript:
:source ~/.vimrc        " load configuration file
:runtime! plugin/**/*.vim  " load all plugins
:scriptnames            " list all loaded scripts
:source %               " reload current file as script
```

```lua
-- Lua:
vim.cmd('source ~/.vimrc')  -- load configuration file
vim.cmd('runtime! plugin/**/*.vim')  -- load all plugins
vim.cmd('scriptnames')  -- list all loaded scripts
vim.cmd('source %')  -- reload current file as script

-- Or using Lua API:
dofile(vim.fn.expand('~/.vimrc'))  -- load Vimscript file
-- For Lua files:
dofile(vim.fn.expand('~/.config/nvim/init.lua'))
```
***
# Title: Home key smart mapping
# Category: Configuration
# Tags: home, key, mapping, smart, navigation
---
Map Home key to toggle between beginning of line and first non-blank character.

```vim
" Vimscript - Smart Home key mapping:
nnoremap <expr> <Home> (col('.') == 1 ? '^' : '0')
inoremap <expr> <Home> (col('.') == 1 ? '<C-o>^' : '<C-o>0')

" Alternative version:
nnoremap <silent> <Home> :call SmartHome()<CR>
function! SmartHome()
  let curcol = col('.')
  normal! ^
  if col('.') == curcol
    normal! 0
  endif
endfunction
```

```lua
-- Lua - Smart Home key mapping:
vim.keymap.set('n', '<Home>', function()
  local col = vim.fn.col('.')
  return col == 1 and '^' or '0'
end, { expr = true, desc = 'Smart Home' })

vim.keymap.set('i', '<Home>', function()
  local col = vim.fn.col('.')
  return col == 1 and '<C-o>^' or '<C-o>0'
end, { expr = true, desc = 'Smart Home' })

-- Alternative version using function:
local function smart_home()
  local curcol = vim.fn.col('.')
  vim.cmd('normal! ^')
  if vim.fn.col('.') == curcol then
    vim.cmd('normal! 0')
  end
end

vim.keymap.set('n', '<Home>', smart_home, { silent = true, desc = 'Smart Home' })
```
***
# Title: Execute command with pipe separator
# Category: Configuration
# Tags: execute, command, pipe, separator, multiple
---
Use `:execute` to allow `|` pipe character to separate multiple commands in mappings.

```vim
" Without execute, | ends the mapping:
nnoremap <F5> :w | echo "Saved"<CR>  " Wrong - | ends mapping

" With execute, | separates commands:
nnoremap <F5> :execute "w \| echo 'Saved'"<CR>  " Correct
```
***
# Title: Verbose mapping information
# Category: Configuration
# Tags: verbose, mapping, script, source, debug
---
Use `:verbose map <key>` to see which script defined a mapping and where.

```vim
:verbose map <F1>     " show where F1 mapping was defined
:verbose imap <Tab>   " show insert mode Tab mapping source
:verbose map          " show all mappings with sources
```
***
# Title: Speed up vimgrep with noautocmd
# Category: Configuration
# Tags: vimgrep, speed, autocmd, performance, search
---
Use `:noautocmd vimgrep` to speed up vimgrep by disabling autocmds during search.

```vim
:noautocmd vimgrep /pattern/ **/*.txt  " faster vimgrep
:noautocmd bufdo %s/old/new/ge         " faster buffer operations
```
***
# Title: Check plugin key mapping usage
# Category: Configuration
# Tags: plugin, mapping, check, usage, debug
---
Use `echo maparg("key", "mode")` to check what key mapping is assigned in specific mode.

```vim
:echo maparg("S", "v")      " check visual mode 'S' mapping
:echo maparg("<leader>f", "n") " check normal mode leader+f mapping  
:echo maparg("<C-n>", "i")  " check insert mode Ctrl+n mapping
```
***
# Title: Environment variables in configuration
# Category: Configuration
# Tags: environment, variable, conditional, config, lua
---
Use `os.getenv()` in Lua configuration to conditionally set options based on environment variables.

```vim
-- In init.lua:
if os.getenv("MACHINE") == "work" then
  -- Work-specific configuration
  vim.opt.colorcolumn = "80"
else  
  -- Personal configuration
  vim.opt.colorcolumn = "120"
end
```
***
# Title: Alternate Neovim startup configuration
# Category: Configuration
# Tags: startup, config, alternate, minimal, debug
---
Start Neovim with alternate configuration using `-u` flag for testing or minimal setups.

```vim
" Start with minimal config:
nvim -u ~/.config/nvim/minimal.lua

" Start with no config:
nvim -u NONE

" Start with specific vimrc:
nvim -u ~/.vimrc.test
```
***
# Title: Hidden buffers option
# Category: Configuration
# Tags: hidden, buffer, switch, unsaved, edit
---
Use `:set hidden` to allow switching between files without saving changes, preventing "No write since last change" errors.

```vim
:set hidden        " allow unsaved buffer switching
:set nohidden      " require saving before switching (default)
" Now you can use :edit, :next, etc. without saving first
```
***
# Title: Append to option value
# Category: Configuration
# Tags: set, option, append
---
Use `:set option+=value` to append a value to an option.

```vim
:set path+=./include  " add to search path
:set wildignore+=*.pyc  " ignore Python bytecode
```
***
# Title: Remove from option value
# Category: Configuration
# Tags: set, option, remove
---
Use `:set option-=value` to remove a value from an option.

```vim
:set path-=./include  " remove from search path
:set wildignore-=*.pyc  " stop ignoring Python bytecode
```
***
# Title: Markdown code block syntax highlighting
# Category: Configuration  
# Tags: markdown, syntax, highlighting, fenced, languages
---
Configure syntax highlighting for fenced code blocks in markdown files by setting supported languages.

```lua
-- In init.lua
vim.g.markdown_fenced_languages = {
  "html",
  "javascript",
  "typescript",
  "css",
  "scss",
  "lua",
  "vim",
  "python",
  "bash"
}
```
***
# Title: Per-project configuration with .nvim.lua
# Category: Configuration
# Tags: project, config, local, exrc, security
---
Enable per-project configuration by creating `.nvim.lua` files in project directories. This allows project-specific settings without security risks of `.exrc`.

```lua
-- In init.lua, enable exrc option:
vim.opt.exrc = true

-- Create .nvim.lua in project root:
-- .nvim.lua
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80"

-- Project-specific LSP settings
vim.lsp.start({
  name = "project-lsp",
  cmd = {"my-lsp-server"},
  root_dir = vim.fs.dirname(vim.fs.find({"package.json"}, { upward = true })[1])
})
```
***