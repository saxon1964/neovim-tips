# Title: Silent and no-remap mappings
# Category: Key Mappings
# Tags: noremap, silent, mapping, recursive
---
Use `noremap` and `<silent>` modifiers to create safe, non-recursive mappings that don't echo commands.

#### Example

```vim
:nnoremap <silent> <leader>w :w<CR>
:inoremap jk <Esc>
" noremap prevents recursive mapping, silent suppresses command echo
" Use noremap by default to avoid unexpected behavior
```
***
# Title: Buffer-local and mode-specific mappings
# Category: Key Mappings
# Tags: buffer, local, mode, specific
---
Use `<buffer>` for buffer-local mappings and different mode prefixes for mode-specific key bindings.

#### Example

```vim
:nnoremap <buffer> <F5> :!python %<CR>
:vnoremap <leader>s :sort<CR>
:inoremap <C-l> <Right>
:cnoremap <C-a> <Home>
" Buffer-local mappings only affect current buffer
```
***
# Title: Leader key mappings
# Category: Key Mappings
# Tags: leader, mapleader, prefix, namespace
---
Use `mapleader` to create a personal namespace for custom mappings, avoiding conflicts with default keys.

#### Example

```vim
:let mapleader = " "           " space as leader
:nnoremap <leader>f :find<Space>
:nnoremap <leader>b :buffer<Space>
:nnoremap <leader>w :write<CR>
" Creates ,f ,b ,w mappings (if comma is leader)
```
***
# Title: Expression mappings
# Category: Key Mappings  
# Tags: expr, expression, mapping, dynamic
---
Use `<expr>` mappings to create dynamic key behaviors that evaluate expressions.

#### Example

```vim
:inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
:nnoremap <expr> n 'Nn'[v:searchforward]
" Tab for completion navigation, Enter to accept
```
***
# Title: Script-local mappings
# Category: Key Mappings
# Tags: script, local, SID, unique
---
Use `<SID>` (Script ID) to create mappings that call script-local functions, avoiding global namespace pollution.

#### Example

```vim
:nnoremap <silent> <F5> :call <SID>CompileAndRun()<CR>
function! s:CompileAndRun()
    " Script-local function
    execute '!gcc % -o %:r && ./%:r'
endfunction
" <SID> ensures function is only accessible from this script
```
***
# Title: Special key notation
# Category: Key Mappings
# Tags: special, keys, notation, modifiers
---
Use special key notation like `<C-key>`, `<M-key>`, `<S-key>` for modifier combinations and special keys.

#### Example

```vim
:nnoremap <C-j> <C-w>j        " Ctrl+j to move down
:nnoremap <M-h> :tabprev<CR>  " Alt+h for previous tab
:nnoremap <S-Tab> :bprev<CR>  " Shift+Tab for previous buffer
:nnoremap <F12> :set invnumber<CR>  " F12 to toggle line numbers
```
***
# Title: Mapping timeouts
# Category: Key Mappings
# Tags: timeout, ttimeout, delay, response
---
Use timeout settings to control how long vim waits for key sequence completion in mappings.

#### Example

```vim
:set timeoutlen=500    " wait 500ms for mapped sequence
:set ttimeoutlen=50    " wait 50ms for key code sequence
" Affects leader key combinations and escape sequences
" Lower ttimeoutlen for faster escape in terminal
```
***
# Title: Abbreviations vs mappings
# Category: Key Mappings
# Tags: abbreviation, iabbrev, expand, text
---
Use abbreviations for text expansion that only triggers after whitespace, unlike mappings which are immediate.

#### Example

```vim
:iabbrev teh the
:iabbrev @@ your.email@domain.com
:iabbrev dts <C-r>=strftime('%Y-%m-%d')<CR>
" Abbreviations expand after whitespace/punctuation
" Mappings activate immediately when typed
```
***
# Title: Mapping special characters
# Category: Key Mappings
# Tags: special, characters, escape, literal
---
Use proper escaping and notation for mapping special characters like quotes, backslashes, and pipes.

#### Example

```vim
:nnoremap <leader>" ciw"<C-r>""<Esc>
:nnoremap <leader>' ciw'<C-r>"'<Esc>
:nnoremap <leader>\ :nohlsearch<CR>
" Surround word with quotes, backslash to clear search
```
***
# Title: Conditional mappings
# Category: Key Mappings
# Tags: conditional, exists, hasmapto, check
---
Use `exists()` and `hasmapto()` to create conditional mappings that don't override existing ones.

#### Example

```vim
if !hasmapto(':make<CR>')
    nnoremap <F5> :make<CR>
endif
if exists(':Gdiff')
    nnoremap <leader>gd :Gdiff<CR>
endif
" Only create mapping if it doesn't exist or command is available
```
***
# Title: Recursive abbreviations
# Category: Key Mappings
# Tags: abbreviation, recursive, noreabbrev, expand
---
Use `noreabbrev` to prevent recursive abbreviation expansion, similar to noremap for mappings.

#### Example

```vim
:abbreviate W w
:noreabbrev Wq wq
:abbreviate Q q
" 'W' expands to 'w', but 'Wq' won't recursively expand the 'W' part
```
***
# Title: Visual mode mappings
# Category: Key Mappings
# Tags: visual, vnoremap, selection, range
---
Use visual mode mappings to operate on selections with custom key combinations.

#### Example

```vim
:vnoremap <leader>s :sort<CR>
:vnoremap <leader>u :!uniq<CR>
:vnoremap * y/\V<C-r>"<CR>
:vnoremap # y?\V<C-r>"<CR>
" Sort selection, remove duplicates, search for selection
```
***
# Title: Command-line mappings
# Category: Key Mappings
# Tags: cnoremap, command, line, navigation
---
Use command-line mode mappings to improve command-line editing with familiar key bindings.

#### Example

```vim
:cnoremap <C-a> <Home>
:cnoremap <C-e> <End>
:cnoremap <C-b> <Left>
:cnoremap <C-f> <Right>
:cnoremap <C-d> <Delete>
" Emacs-style command line navigation
```
***
# Title: Plug mappings
# Category: Key Mappings
# Tags: plug, scriptname, unique, naming
---
Use `<Plug>` prefix to create unique mapping names that users can map to their preferred keys.

#### Example

```vim
:nnoremap <Plug>MyPluginFunction :call MyFunction()<CR>
:nmap <F5> <Plug>MyPluginFunction
" Plugin provides <Plug> mapping, user maps it to preferred key
" Prevents conflicts and allows customization
```
***
# Title: Operator-pending mappings
# Category: Key Mappings
# Tags: onoremap, operator, pending, motion
---
Use operator-pending mappings to create custom text objects and motions.

#### Example

```vim
:onoremap in( :<C-u>normal! f(vi(<CR>
:onoremap an( :<C-u>normal! f(va(<CR>
:onoremap in{ :<C-u>normal! f{vi{<CR>
" Creates 'in(' and 'an(' text objects
" Now you can use din( to delete inside next parentheses
```
***
# Title: Terminal mode mappings
# Category: Key Mappings
# Tags: tnoremap, terminal, mode, escape
---
Use terminal mode mappings to control built-in terminal behavior and key bindings.

#### Example

```vim
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-w>h <C-\><C-n><C-w>h
:tnoremap <C-w>j <C-\><C-n><C-w>j
:tnoremap <C-w>k <C-\><C-n><C-w>k
:tnoremap <C-w>l <C-\><C-n><C-w>l
" Escape to exit terminal mode, window navigation
```
***
# Title: Multiple key mappings
# Category: Key Mappings
# Tags: multiple, keys, sequence, chain
---
Create mappings that respond to multiple key sequences or provide alternative bindings.

#### Example

```vim
:nnoremap <leader>fs :w<CR>
:nnoremap <leader>ff :find<Space>
:nnoremap <leader>fb :buffer<Space>
:nnoremap <C-s> :w<CR>
:inoremap <C-s> <Esc>:w<CR>a
" Multiple ways to save: <leader>fs and <C-s>
```
***
# Title: Mapping with arguments
# Category: Key Mappings
# Tags: arguments, parameters, count, range
---
Use `<count>` and ranges in mappings to create flexible key bindings that accept numeric arguments.

#### Example

```vim
:nnoremap <silent> <leader>d :<C-u>call DeleteLines(v:count1)<CR>
function! DeleteLines(count)
    execute 'normal! ' . a:count . 'dd'
endfunction
" 3<leader>d deletes 3 lines
```
***
# Title: Auto-pair mappings
# Category: Key Mappings
# Tags: autopair, brackets, quotes, matching
---
Create smart bracket and quote auto-pairing with conditional mappings.

#### Example

```vim
:inoremap <expr> ( getline('.')[col('.')-2] =~ '\w' ? '(' : '()<Left>'
:inoremap <expr> { getline('.')[col('.')-2] =~ '\w' ? '{' : '{}<Left>'
:inoremap <expr> [ '[]<Left>'
:inoremap <expr> " '""<Left>'
" Smart auto-pairing that considers context
```
***
# Title: Escape key alternatives
# Category: Key Mappings
# Tags: escape, alternative, jk, kj
---
Map common key combinations to escape key for faster mode switching without reaching for Esc.

#### Example

```vim
:inoremap jk <Esc>
:inoremap kj <Esc>
:inoremap jj <Esc>
:vnoremap v <Esc>
" Popular alternatives: jk, kj, jj, or double-tap current mode key
```
***
# Title: Context-aware mappings
# Category: Key Mappings
# Tags: context, aware, conditional, filetype
---
Create mappings that behave differently based on file type, mode, or cursor context.

#### Example

```vim
:autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>
:autocmd FileType javascript nnoremap <buffer> <F5> :!node %<CR>
:autocmd FileType sh nnoremap <buffer> <F5> :!bash %<CR>
" Same key, different behavior per file type
```
***