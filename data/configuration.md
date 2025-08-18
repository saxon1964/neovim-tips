Reload configuration
# Title: Reload configuration
# Category: Configuration
# Tags: config, reload, source
---
Use `:source $MYVIMRC` to reload your Neovim configuration.

#### Example

```vim
:source $MYVIMRC  " reload config
```
===

Edit configuration
# Title: Edit configuration
# Category: Configuration
# Tags: config, edit, vimrc
---
Use `:e $MYVIMRC` to quickly edit your Neovim configuration file.

#### Example

```vim
:e $MYVIMRC  " edit config file
```
===

View runtime paths
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

Enable 256 colors
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

Auto tab completion
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

Restore cursor position
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

Toggle paste mode
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

Auto-reload file changes
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

Set color scheme based on time
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
