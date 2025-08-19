# Title: Repeat last command
# Category: Editing
# Tags: repeat, command, editing
---
Use `.` to repeat the last command that changed text.

#### Example

```vim
.  " repeat last command
```
===
# Title: Undo and redo
# Category: Editing
# Tags: undo, redo, history
---
Use `u` to undo last change and `Ctrl+r` to redo undone changes.

#### Example

```vim
u       " undo
Ctrl+r  " redo
```
===
# Title: Delete line
# Category: Editing
# Tags: delete, line, remove
---
Use `dd` to delete entire line, `D` to delete from cursor to end of line.

#### Example

```vim
dd  " delete entire line
D   " delete to end of line
```
===
# Title: Change operations
# Category: Editing
# Tags: change, replace, edit
---
Use `cc` to change entire line, `C` to change from cursor to end of line, `cw` to change word.

#### Example

```vim
cc  " change entire line
C   " change to end of line
cw  " change word
```
===
# Title: Join lines
# Category: Editing
# Tags: join, lines, merge
---
Use `J` to join current line with next line, `gJ` to join without adding space.

#### Example

```vim
J   " join with space
gJ  " join without space
```
===
# Title: Duplicate line
# Category: Editing
# Tags: duplicate, copy, line
---
Use `yyp` to duplicate current line below or `yyP` to duplicate above.

#### Example

```vim
yyp  " duplicate line below
yyP  " duplicate line above
```
===
# Title: Move line up or down
# Category: Editing
# Tags: move, line, reorder
---
Use `ddkP` to move line up or `ddp` to move line down.

#### Example

```vim
ddkP  " move line up
ddp   " move line down
```
===
# Title: Insert at beginning/end
# Category: Editing
# Tags: insert, beginning, end
---
Use `I` to insert at beginning of line, `A` to append at end of line.

#### Example

```vim
I  " insert at line start
A  " append at line end
```
===
# Title: Open new line
# Category: Editing
# Tags: open, newline, insert
---
Use `o` to open new line below cursor, `O` to open new line above cursor.

#### Example

```vim
o  " open line below
O  " open line above
```
===
# Title: Replace single character
# Category: Editing
# Tags: replace, character, substitute
---
Use `r{char}` to replace single character under cursor with new character.

#### Example

```vim
ra  " replace with 'a'
rx  " replace with 'x'
```
===
# Title: Replace mode
# Category: Editing
# Tags: replace, mode, overwrite
---
Use `R` to enter replace mode where typed characters overwrite existing text.

#### Example

```vim
R  " enter replace mode
```
===
# Title: Substitute character
# Category: Editing
# Tags: substitute, character, change
---
Use `s` to substitute character (delete and enter insert mode), `S` for entire line.

#### Example

```vim
s  " substitute character
S  " substitute line
```
===
# Title: Delete character
# Category: Editing
# Tags: delete, character, remove
---
Use `x` to delete character under cursor, `X` to delete character before cursor.

#### Example

```vim
x  " delete character under cursor
X  " delete character before cursor
```
===
# Title: Yank (copy) operations
# Category: Editing
# Tags: yank, copy, clipboard
---
Use `yy` to yank entire line, `yw` to yank word, `y$` to yank to end of line.

#### Example

```vim
yy  " yank entire line
yw  " yank word
y$  " yank to end of line
```
===
# Title: Put (paste) operations
# Category: Editing
# Tags: put, paste, clipboard
---
Use `p` to paste after cursor, `P` to paste before cursor.

#### Example

```vim
p  " paste after cursor
P  " paste before cursor
```
===
# Title: Increment/decrement numbers
# Category: Editing
# Tags: increment, decrement, numbers
---
Use `Ctrl+a` to increment number under cursor, `Ctrl+x` to decrement.

#### Example

```vim
Ctrl+a  " increment number
Ctrl+x  " decrement number
```
===
# Title: Change case
# Category: Editing
# Tags: case, upper, lower, toggle
---
Use `~` to toggle case of character, `gU` to uppercase, `gu` to lowercase.

#### Example

```vim
~     " toggle case
gUw   " uppercase word
guw   " lowercase word
```
===
# Title: Calculate expressions
# Category: Editing
# Tags: calculate, math, expression, replace
---
Use `<C-r>=` in insert mode to calculate mathematical expressions and insert the result.

#### Example

```vim
" In insert mode:
<C-r>=2+2<CR>       " inserts '4'
<C-r>=16*1024<CR>   " inserts '16384'
```
===
# Title: Insert literal tab
# Category: Editing
# Tags: tab, literal, insert, character
---
Use `<C-v><Tab>` in insert mode to insert a literal tab character when expandtab is set.

#### Example

```vim
" In insert mode when expandtab is on:
<C-v><Tab>  " insert actual tab character
```
===
# Title: Capitalize words easily
# Category: Editing
# Tags: capitalize, words, case, format
---
Use `guw~` to make word lowercase then capitalize first letter, or create mapping for title case.

#### Example

```vim
guw~        " lowercase word then capitalize first letter
" Or map for convenience:
nnoremap <leader>tc guw~
```
===
# Title: Insert single character
# Category: Editing
# Tags: insert, character, single, quick
---
Use `i{char}<Esc>` or create mapping with `s` to quickly insert single character without staying in insert mode.

#### Example

```vim
" Insert single character and return to normal mode
nnoremap <leader>i i_<Esc>r
" Or use s to substitute character:
s{char}<Esc>  " replace character under cursor
```
===
# Title: Delete words in different way
# Category: Editing
# Tags: delete, word, alternative, whitespace
---
Use `daw` to delete word including surrounding whitespace, `diw` for word only, `dW` for WORD including punctuation.

#### Example

```vim
daw  " delete a word (including spaces)
diw  " delete inner word (no spaces)
dW   " delete WORD (including punctuation)
daW  " delete a WORD (including spaces)
```
===
# Title: Insert multiple lines
# Category: Editing
# Tags: insert, lines, multiple, batch
---
Use `o<Esc>` followed by repeat count, or `{count}o` to insert multiple empty lines at once.

#### Example

```vim
5o<Esc>     " insert 5 empty lines below
5O<Esc>     " insert 5 empty lines above
" Or in normal mode:
o<Esc>4.    " insert line, then repeat 4 times
```
===
# Title: Insert newline without entering insert mode
# Category: Editing
# Tags: newline, insert, normal, mode
---
Use `o<Esc>` to insert line below or `O<Esc>` to insert line above without staying in insert mode.

#### Example

```vim
o<Esc>      " insert empty line below, stay in normal mode
O<Esc>      " insert empty line above, stay in normal mode
" Or map for convenience:
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
```
===
# Title: Toggle paste mode
# Category: Editing
# Tags: paste, mode, toggle, indentation
---
Toggle paste mode to prevent auto-indentation when pasting external text.

#### Example

```vim
set pastetoggle=<F2>    " set F2 as paste toggle key
nnoremap <F2> :set invpaste paste?<CR>
set showmode            " show current mode including paste

" Usage: Press F2, paste text, press F2 again
```
===
# Title: Enhanced undo and redo
# Category: Editing
# Tags: undo, redo, changes, history, time
---
Use advanced undo/redo with time-based navigation and undo tree features.

#### Example

```vim
u           " undo last change
<C-r>       " redo last undone change
U           " restore line to original state
:earlier 5m " undo changes from 5 minutes ago
:later 10m  " redo changes up to 10 minutes later

" Navigate undo tree
:undolist   " show undo history
g-          " go to older text state
g+          " go to newer text state
```
===
# Title: Filter text through external commands
# Category: Editing
# Tags: filter, external, command, text, process
---
Process text by sending it through external programs and commands.

#### Example

```vim
:%!sort           " sort all lines
:%!sort -u        " sort and remove duplicates
:'a,'b!sort       " sort lines between marks a and b
!}fmt             " format paragraph through fmt command
!}python script.py " filter paragraph through Python script

" Capture command output
:r !date          " read date command output into buffer
:r !ls -la        " read directory listing into buffer
```
===
# Title: Omni completion setup
# Category: Editing
# Tags: completion, omni, smart, autocomplete
---
Configure and use intelligent omni completion for programming languages.

#### Example

```vim
" Enable omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Use omni completion
<C-x><C-o>        " trigger omni completion in insert mode
<C-n>             " navigate completion menu down
<C-p>             " navigate completion menu up

" Enable for specific languages
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
```
===