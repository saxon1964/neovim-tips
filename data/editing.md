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
# Title: Substitute entire line and start insert
# Category: Editing
# Tags: substitute, line, insert, indentation
---
Use `S` to delete the entire line and start insert mode with proper indentation.

#### Example

```vim
S  " delete line and start insert at correct indentation
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
# Title: Ex commands - line operations
# Category: Editing
# Tags: ex, line, delete, copy, move, range
---
Use `:d` to delete lines, `:y` to yank, `:m` to move, `:co` or `:t` to copy, with ranges like `1,5` or `%`.

#### Example

```vim
:5d           " delete line 5
:1,10d        " delete lines 1-10
:%d           " delete all lines
:5,10m 20     " move lines 5-10 to after line 20
:1,5co 10     " copy lines 1-5 to after line 10
```
===
# Title: Ex commands - undo and redo
# Category: Editing
# Tags: ex, undo, redo, earlier, later
---
Use `:undo` and `:redo` for undo/redo, `:earlier` and `:later` for time-based undo.

#### Example

```vim
:undo         " undo last change
:redo         " redo last undone change
:earlier 10m  " go back 10 minutes
:later 5s     " go forward 5 seconds
:earlier 10f  " go back 10 file states
```
===
# Title: Ex commands - sorting and formatting
# Category: Editing
# Tags: ex, sort, format, center, left, right
---
Use `:sort` to sort lines, `:center` to center text, `:left` and `:right` for alignment.

#### Example

```vim
:%sort        " sort all lines
:5,15sort     " sort lines 5-15
:sort u       " sort and remove duplicates
:center 80    " center text in 80 columns
:left 5       " left align with 5 space indent
:right 70     " right align to column 70
```
===
# Title: Ex commands - joining and splitting
# Category: Editing
# Tags: ex, join, split, lines, combine
---
Use `:join` or `:j` to join lines, with count to join multiple lines.

#### Example

```vim
:join         " join current line with next
:j            " short form of join
:5,8join      " join lines 5-8
:join!        " join without inserting spaces
```
===
# Title: Ex commands - marks and jumps
# Category: Editing
# Tags: ex, marks, jump, position, navigate
---
Use `:mark` to set mark, `:jumps` to show jump list, `:changes` for change list, `:delmarks` to delete marks.

#### Example

```vim
:mark a       " set mark 'a' at current line
:marks        " show all marks
:jumps        " show jump list
:changes      " show change list
:delmarks a   " delete mark 'a'
:delmarks!    " delete all lowercase marks
```
===
# Title: Convert tabs to spaces
# Category: Editing
# Tags: tab, space, convert, expand, retab
---
Use `:set et|retab` to expand all tab indents to spaces in the current file.

#### Example

```vim
:set expandtab    " use spaces instead of tabs
:retab            " convert existing tabs to spaces
:set et|retab     " do both in one command
:set noet|retab!  " convert spaces back to tabs
```
===
# Title: Move line to end of paragraph
# Category: Editing
# Tags: move, line, paragraph, end, motion
---
Use `:m'}-1` to move current line to end of current paragraph.

#### Example

```vim
:m'}-1        " move current line to end of paragraph
:m'}          " move current line after end of paragraph
:m'{-1        " move current line to start of paragraph
```
===
# Title: Execute normal commands without mappings
# Category: Editing
# Tags: normal, command, mapping, script, execute
---
Use `normal!` in scripts to execute normal-mode commands without triggering user mappings.

#### Example

```vim
" In a script or function:
normal! dd       " delete line without triggering dd mapping
normal! yy       " yank line without triggering yy mapping
execute "normal! \<C-v>j"  " block select down
```
===
# Title: Substitute in all buffers
# Category: Editing
# Tags: substitute, buffer, all, bufdo, global
---
Use `:bufdo %s/old/new/ge` to substitute in all open buffers, `e` flag suppresses errors.

#### Example

```vim
:bufdo %s/old/new/ge    " substitute in all buffers
:bufdo %s/TODO/DONE/ge  " replace TODO with DONE in all buffers
:bufdo update           " save all modified buffers
```
===
# Title: Number lines with commands
# Category: Editing
# Tags: number, line, sequence, increment, script
---
Add line numbers to text using substitute command with expression.

#### Example

```vim
:%s/^/\=line('.') . '. '/  " add line numbers with dots
:%s/^/\=printf("%3d: ", line('.'))/ " formatted line numbers
:let i=1 | g/^/s//\=i . '. '/ | let i=i+1  " alternative method
```
===
# Title: Return to last exit position
# Category: Editing
# Tags: position, exit, return, mark, jump
---
Use mark `"0` to jump to position where Vim was last exited from current file.

#### Example

```vim
`"0     " jump to last exit position
'"0     " jump to last exit position (line start)
:normal `"0  " execute from script/mapping
```
===
# Title: Wrap text in HTML tags
# Category: Editing
# Tags: html, tag, wrap, surround, format
---
Use visual selection and substitute to wrap text in HTML tags.

#### Example

```vim
" Select text in visual mode, then:
:'<,'>s/.*/\<p>&\<\/p>/   " wrap lines in <p> tags
:'<,'>s/.*/\<li>&\<\/li>/ " wrap lines in <li> tags
:'<,'>s/\(.*\)/\<strong>\1\<\/strong>/ " wrap in <strong> tags
```
===
# Title: Copy and move lines to marks
# Category: Editing
# Tags: copy, move, mark, line, range
---
Use `:t` to copy lines to marks, `:.t'a` to copy current line to mark 'a', `:152,154t.` to copy range to current position.

#### Example

```vim
ma           " set mark 'a' at current line
:.t'a        " copy current line to mark 'a'
:5,10t'b     " copy lines 5-10 to mark 'b'
:'<,'>t'a    " copy visual selection to mark 'a'
:152,154t.   " copy lines 152-154 to current position
```
===
# Title: Increment search results
# Category: Editing
# Tags: increment, search, replace, counter, sequential
---
Use global command with counter to incrementally replace search results with sequential numbers.

#### Example

```vim
" Replace all '2.gif' with incremental numbers:
:let idx=0 | g/2\.gif/ let idx += 1 | s//\= idx . '.gif'/

" Replace 'item' with numbered items:
:let n=1 | g/item/ s//\='item' . n/ | let n=n+1
```
===
# Title: Global command with normal mode operations
# Category: Editing
# Tags: global, normal, command, pattern, batch
---
Use `:g/pattern/ normal {commands}` to execute normal mode commands on all matching lines.

#### Example

```vim
:g/console.log/ normal gcc    " comment all lines with 'console.log'
:g/TODO/ normal dw            " delete first word on lines with 'TODO'
:g/function/ normal >>        " indent all lines containing 'function'
```
===
# Title: Put text above or below current line
# Category: Editing
# Tags: put, paste, above, below, line
---
Use `:pu` to paste below current line, `:pu!` to paste above current line, regardless of cursor position.

#### Example

```vim
:pu         " paste register contents below current line
:pu!        " paste register contents above current line
:pu a       " paste register 'a' below current line
:pu! a      " paste register 'a' above current line
```
===
# Title: Select non-uniform strings across lines
# Category: Editing
# Tags: select, yank, append, register, pattern
---
Use normal mode with append register to collect text from multiple lines into one register.

#### Example

```vim
" Yank text inside {} from multiple lines to register A:
:'<,'>norm "Ayi{

" Yank word under cursor from multiple lines:
:g/pattern/ normal "Ayiw

" Clear register first:
qAq
:'<,'>norm "Ayi{
```
===