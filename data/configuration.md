# Title: View runtime paths
# Category: Configuration
# Tags: runtime, path, debug
---
Use `:echo &runtimepath` to see all runtime paths Neovim is using.

#### Example

```vim
:echo &runtimepath  " show runtime paths
```
===
# Title: Enable 256 colors
# Category: Configuration
# Tags: colors, terminal, display
---
Configure terminal to support 256 colors with proper settings.

#### Example

```vim
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm
" In shell profile:
export TERM='xterm-256color'
```
===
# Title: Auto tab completion
# Category: Configuration
# Tags: completion, tab, autocomplete
---
Configure TAB to autocomplete words while preserving normal TAB functionality.

#### Example

```vim
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
===
# Title: Restore cursor position
# Category: Configuration
# Tags: cursor, position, session, restore
---
Automatically restore cursor position when reopening files.

#### Example

```vim
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
===
# Title: Toggle paste mode
# Category: Configuration
# Tags: paste, toggle, indent, clipboard
---
Set up paste toggle to prevent auto-indenting when pasting from clipboard in terminal.

#### Example

```vim
set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
set showmode
" Use F2 before and after pasting external text
```
===
# Title: Auto-reload file changes
# Category: Configuration
# Tags: auto, reload, file, changes
---
Automatically reload file when it changes externally, with optional warning.

#### Example

```vim
set autoread
" Trigger autoread when cursor stops moving
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
" Or check periodically
au CursorHold * :silent! checktime
```
===
# Title: Set color scheme based on time
# Category: Configuration
# Tags: color, scheme, time, automatic
---
Automatically switch between light and dark color schemes based on time of day.

#### Example

```vim
if strftime("%H") < 18 && strftime("%H") > 6
  colorscheme morning
else
  colorscheme evening
endif
```
===
# Title: Ex commands - set options
# Category: Configuration
# Tags: ex, set, option, toggle, query
---
Use `:set option` to enable, `:set nooption` to disable, `:set option?` to query, `:set option&` to reset to default.

#### Example

```vim
:set number        " enable line numbers
:set nonumber      " disable line numbers
:set number?       " check if line numbers are enabled
:set number&       " reset to default value
```
===
# Title: Ex commands - option with values
# Category: Configuration
# Tags: ex, set, value, assignment, string
---
Use `:set option=value` to assign value, `:set option+=value` to append, `:set option-=value` to remove.

#### Example

```vim
:set tabstop=4        " set tab width to 4
:set path+=/usr/include  " add to path
:set path-=/tmp       " remove from path
:set suffixes+=.bak   " add .bak to suffixes
```
===
# Title: Ex commands - autocmds and events
# Category: Configuration
# Tags: ex, autocmd, event, pattern, command
---
Use `:autocmd` to set up automatic commands, `:autocmd!` to clear, `:doautocmd` to trigger events.

#### Example

```vim
:autocmd BufWritePost *.py !python %  " run python after save
:autocmd! BufRead       " clear all BufRead autocmds
:doautocmd BufRead      " trigger BufRead event
:autocmd FileType python setlocal ts=4  " Python-specific settings
```
===
# Title: Ex commands - mappings and abbreviations
# Category: Configuration
# Tags: ex, map, abbrev, shortcut, key
---
Use `:map` for mappings, `:abbrev` for abbreviations, `:unmap` and `:unabbrev` to remove.

#### Example

```vim
:map <F2> :w<CR>        " map F2 to save
:imap <F3> <Esc>:w<CR>  " insert mode mapping
:abbrev teh the         " abbreviation for typo
:unmap <F2>             " remove mapping
:unabbrev teh           " remove abbreviation
```
===
# Title: Ex commands - highlight and syntax
# Category: Configuration
# Tags: ex, highlight, syntax, color, group
---
Use `:highlight` to set colors, `:syntax` for syntax highlighting, `:colorscheme` to change themes.

#### Example

```vim
:highlight Comment ctermfg=green   " set comment color
:syntax on                         " enable syntax highlighting
:syntax off                        " disable syntax highlighting
:colorscheme desert                " change color scheme
:highlight clear                   " clear all highlighting
```
===
# Title: Ex commands - runtime and sourcing
# Category: Configuration
# Tags: ex, source, runtime, script, load
---
Use `:source` to load script, `:runtime` to load from runtime path, `:scriptnames` to list loaded scripts.

#### Example

```vim
:source ~/.vimrc        " load configuration file
:runtime! plugin/**/*.vim  " load all plugins
:scriptnames            " list all loaded scripts
:source %               " reload current file as script
```
===
# Title: Home key smart mapping
# Category: Configuration
# Tags: home, key, mapping, smart, navigation
---
Map Home key to toggle between beginning of line and first non-blank character.

#### Example

```vim
" Smart Home key mapping:
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
===
# Title: Execute command with pipe separator
# Category: Configuration
# Tags: execute, command, pipe, separator, multiple
---
Use `:execute` to allow `|` pipe character to separate multiple commands in mappings.

#### Example

```vim
" Without execute, | ends the mapping:
nnoremap <F5> :w | echo "Saved"<CR>  " Wrong - | ends mapping

" With execute, | separates commands:
nnoremap <F5> :execute "w \| echo 'Saved'"<CR>  " Correct
```
===
# Title: Verbose mapping information
# Category: Configuration
# Tags: verbose, mapping, script, source, debug
---
Use `:verbose map <key>` to see which script defined a mapping and where.

#### Example

```vim
:verbose map <F1>     " show where F1 mapping was defined
:verbose imap <Tab>   " show insert mode Tab mapping source
:verbose map          " show all mappings with sources
```
===
# Title: Speed up vimgrep with noautocmd
# Category: Configuration
# Tags: vimgrep, speed, autocmd, performance, search
---
Use `:noautocmd vimgrep` to speed up vimgrep by disabling autocmds during search.

#### Example

```vim
:noautocmd vimgrep /pattern/ **/*.txt  " faster vimgrep
:noautocmd bufdo %s/old/new/ge         " faster buffer operations
```
===
# Title: Check plugin key mapping usage
# Category: Configuration
# Tags: plugin, mapping, check, usage, debug
---
Use `echo maparg("key", "mode")` to check what key mapping is assigned in specific mode.

#### Example

```vim
:echo maparg("S", "v")      " check visual mode 'S' mapping
:echo maparg("<leader>f", "n") " check normal mode leader+f mapping  
:echo maparg("<C-n>", "i")  " check insert mode Ctrl+n mapping
```
===
# Title: Environment variables in configuration
# Category: Configuration
# Tags: environment, variable, conditional, config, lua
---
Use `os.getenv()` in Lua configuration to conditionally set options based on environment variables.

#### Example

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
===
# Title: Alternate Neovim startup configuration
# Category: Configuration
# Tags: startup, config, alternate, minimal, debug
---
Start Neovim with alternate configuration using `-u` flag for testing or minimal setups.

#### Example

```vim
" Start with minimal config:
nvim -u ~/.config/nvim/minimal.lua

" Start with no config:
nvim -u NONE

" Start with specific vimrc:
nvim -u ~/.vimrc.test
```
===
# Title: Hidden buffers option
# Category: Configuration
# Tags: hidden, buffer, switch, unsaved, edit
---
Use `:set hidden` to allow switching between files without saving changes, preventing "No write since last change" errors.

#### Example

```vim
:set hidden        " allow unsaved buffer switching
:set nohidden      " require saving before switching (default)
" Now you can use :edit, :next, etc. without saving first
```
===
# Title: Append to option value
# Category: Configuration
# Tags: set, option, append
---
Use `:set option+=value` to append a value to an option.

#### Example

```vim
:set path+=./include  " add to search path
:set wildignore+=*.pyc  " ignore Python bytecode
```
===
# Title: Remove from option value
# Category: Configuration
# Tags: set, option, remove
---
Use `:set option-=value` to remove a value from an option.

#### Example

```vim
:set path-=./include  " remove from search path
:set wildignore-=*.pyc  " stop ignoring Python bytecode
```
===