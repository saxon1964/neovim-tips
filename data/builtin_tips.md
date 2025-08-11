# Title: Help
# Category: Global
# Tags: help
---
Use `:h[elp] keyword` to open help for a give keyword

#### Example

```vim
:h sandbox 
```
===

# Title: Save as 
# Category: File
# Tags: save, file
---
Use `:sav[eas] filepath` to save file under a different name
 
#### Example

```vim
:sav ~/tmp/work.txt
```
===

# Title: Close current pane 
# Category: Global
# Tags: close, pane
---
Use `:clo[se]` to close the current pane. 

**Note**: The last window cannot be closed. 

#### Example

```vim
:clo
```
===

# Title: Open terminal 
# Category: Global
# Tags: terminal
---
Use `:ter[minal]` to open a terminal window. When the window shows up, press `i` to enter the insert mode and start typing shell commands. Type `exit` to close the terminal window. 

**TIP**: Once in terminal, type `vimtutor` for a nice vim tutorial, excellent for starters.

#### Example

```vim
:ter
```
===

# Title: Open documentation for word under the cursor 
# Category: Global
# Tags: man pages, documentation, help
---
Use `K` to open a man page or other type of available documentation for the word under the cursor. 

#### Example

```vim
K
```
===

# Title: Basic cursor movement
# Category: Movement
# Tags: cursor, navigation, movement
---
Use `h`, `j`, `k`, `l` to move the cursor left, down, up, and right respectively.

#### Example

```vim
h  " move left
j  " move down
k  " move up
l  " move right
```
===

# Title: Word movement
# Category: Movement
# Tags: word, navigation, movement
---
Use `w` to jump to the start of the next word, `e` to jump to the end of the current word, and `b` to jump backwards to the start of the previous word.

#### Example

```vim
w  " next word start
e  " end of word
b  " previous word start
```
===

# Title: Line navigation
# Category: Movement
# Tags: line, navigation, movement
---
Use `0` to jump to the beginning of the line, `^` to jump to the first non-blank character, and `$` to jump to the end of the line.

#### Example

```vim
0  " line start
^  " first non-blank
$  " line end
```
===

# Title: Document navigation
# Category: Movement
# Tags: document, navigation, movement
---
Use `gg` to go to the first line of the document and `G` to go to the last line.

#### Example

```vim
gg  " first line
G   " last line
```
===

# Title: Screen scrolling
# Category: Movement
# Tags: scroll, screen, navigation
---
Use `Ctrl+e` to scroll down and `Ctrl+y` to scroll up without moving the cursor position.

#### Example

```vim
Ctrl+e  " scroll down
Ctrl+y  " scroll up
```
===

# Title: Center cursor on screen
# Category: Movement
# Tags: center, screen, cursor
---
Use `zz` to center the current line on screen, `zt` to move it to the top, and `zb` to move it to the bottom.

#### Example

```vim
zz  " center line
zt  " line to top
zb  " line to bottom
```
===




# Title: Exit insert mode
# Category: Edit
# Tags: exit, insert, mode
---
Use `Esc` or `Ctrl+c` to exit insert mode and return to normal mode.

#### Example

```vim
Esc     " exit insert mode
Ctrl+c  " exit insert mode
```
===

# Title: Replace character
# Category: Edit
# Tags: replace, character, editing
---
Use `r` followed by a character to replace the single character under the cursor.

#### Example

```vim
ra  " replace with 'a'
```
===

# Title: Join lines
# Category: Edit
# Tags: join, lines, editing
---
Use `J` to join the current line with the next line (adds space), or `gJ` to join without adding space.

#### Example

```vim
J   " join with space
gJ  " join without space
```
===

# Title: Undo and redo
# Category: Edit
# Tags: undo, redo, history
---
Use `u` to undo the last change and `Ctrl+r` to redo.

#### Example

```vim
u       " undo
Ctrl+r  " redo
```
===





# Title: View registers
# Category: Registers
# Tags: registers, clipboard, view
---
Use `:registers` to show the contents of all registers.

#### Example

```vim
:registers
```
===


# Title: System clipboard
# Category: Registers
# Tags: clipboard, system, yank
---
Use `"+y` to yank to the system clipboard and `"+p` to paste from the system clipboard.

#### Example

```vim
"+y  " yank to system clipboard
"+p  " paste from system clipboard
```
===

# Title: Search forward
# Category: Search
# Tags: search, find, forward
---
Use `/pattern` to search forward for a pattern. Press `n` to go to next match and `N` for previous.

#### Example

```vim
/hello  " search for 'hello'
n       " next match
N       " previous match
```
===









# Title: Insert modes
# Category: Insert
# Tags: insert, mode, editing
---
Use `i` to insert before cursor, `I` to insert at line start, `a` to append after cursor, and `A` to append at line end.

#### Example

```vim
i  " insert before cursor
I  " insert at line start
a  " append after cursor
A  " append at line end
```
===

# Title: New line insertion
# Category: Insert
# Tags: insert, line, editing
---
Use `o` to open new line below current line and `O` to open new line above current line.

#### Example

```vim
o  " new line below
O  " new line above
```
===

# Title: Insert mode deletion
# Category: Insert
# Tags: delete, insert, editing
---
Use `Ctrl+h` to delete character before cursor and `Ctrl+w` to delete word before cursor while in insert mode.

#### Example

```vim
Ctrl+h  " delete character
Ctrl+w  " delete word
```
===





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

# Title: Visual selection modes
# Category: Visual
# Tags: visual, selection, mode
---
Use `v` for character-wise visual mode, `V` for line-wise visual mode, and `Ctrl+v` for block-wise visual mode.

#### Example

```vim
v      " character visual
V      " line visual
Ctrl+v " block visual
```
===

# Title: Indent text in visual mode
# Category: Visual
# Tags: indent, visual, editing
---
Use `>` to shift selected text right and `<` to shift selected text left in visual mode.

#### Example

```vim
>  " shift right
<  " shift left
```
===

# Title: Yank and delete in visual mode
# Category: Visual
# Tags: yank, delete, visual
---
Use `y` to yank (copy) selected text and `d` to delete selected text in visual mode.

#### Example

```vim
y  " yank selected text
d  " delete selected text
```
===


# Title: Use specific register
# Category: Registers
# Tags: registers, yank, specific
---
Use `"xy` to yank into specific register x. Replace x with any letter or number.

#### Example

```vim
"ay  " yank into register a
"bp  " paste from register b
```
===



# Title: Global search and replace
# Category: Search
# Tags: replace, global, substitute
---
Use `:%s/old/new/g` to replace all occurrences of 'old' with 'new' in the entire file.

#### Example

```vim
:%s/foo/bar/g  " replace all 'foo' with 'bar'
```
===

# Title: Remove search highlighting
# Category: Search
# Tags: search, highlight, remove
---
Use `:nohl` to remove search highlighting after performing a search.

#### Example

```vim
:nohl
```
===

# Title: Page movement
# Category: Movement
# Tags: page, scroll, movement
---
Use `Ctrl+f` to move forward one full page, `Ctrl+b` to move backward one full page, `Ctrl+d` to move down half page, and `Ctrl+u` to move up half page.

#### Example

```vim
Ctrl+f  " forward full page
Ctrl+b  " backward full page
Ctrl+d  " down half page
Ctrl+u  " up half page
```
===

# Title: Jump to specific line
# Category: Movement
# Tags: line, jump, navigation
---
Use `{number}G` to jump to a specific line number, or `:{number}` as an alternative.

#### Example

```vim
42G   " jump to line 42
:42   " jump to line 42
```
===

# Title: Character search on line
# Category: Movement
# Tags: character, find, line
---
Use `f{char}` to find next occurrence of character, `F{char}` to find previous occurrence, `t{char}` to move to before next occurrence, and `T{char}` to move to after previous occurrence.

#### Example

```vim
fa  " find next 'a'
Fa  " find previous 'a'
ta  " move to before next 'a'
Ta  " move to after previous 'a'
```
===

# Title: Repeat character search
# Category: Movement
# Tags: repeat, character, search
---
Use `;` to repeat last character search in the same direction and `,` to repeat in the opposite direction.

#### Example

```vim
;  " repeat search forward
,  " repeat search backward
```
===

# Title: Matching brackets
# Category: Movement
# Tags: brackets, matching, navigation
---
Use `%` to jump to the matching bracket, parenthesis, or brace.

#### Example

```vim
%  " jump to matching bracket
```
===

# Title: Set marks
# Category: Marks
# Tags: marks, position, bookmark
---
Use `m{letter}` to set a mark at current position. Use lowercase letters for file-specific marks and uppercase for global marks.

#### Example

```vim
ma  " set mark 'a'
mB  " set global mark 'B'
```
===

# Title: Jump to marks
# Category: Marks
# Tags: marks, jump, navigation
---
Use `'{letter}` to jump to beginning of line with mark, or \`{letter}\` to jump to exact mark position.

#### Example

```vim
'a   " jump to line with mark 'a'
`a   " jump to exact position of mark 'a'
```
===

# Title: View marks
# Category: Marks
# Tags: marks, list, view
---
Use `:marks` to list all current marks.

#### Example

```vim
:marks
```
===

# Title: Record macro
# Category: Macros
# Tags: macro, record, automation
---
Use `q{letter}` to start recording a macro into register {letter}, then `q` again to stop recording.

#### Example

```vim
qa  " start recording macro 'a'
q   " stop recording
```
===

# Title: Execute macro
# Category: Macros
# Tags: macro, execute, replay
---
Use `@{letter}` to execute macro stored in register {letter}, or `@@` to repeat the last executed macro.

#### Example

```vim
@a  " execute macro 'a'
@@  " repeat last macro
```
===

# Title: Cut/delete line
# Category: Cut and Paste
# Tags: cut, delete, line
---
Use `dd` to cut (delete) the current line, or `{number}dd` to cut multiple lines.

#### Example

```vim
dd   " cut current line
3dd  " cut 3 lines
```
===

# Title: Cut/delete word
# Category: Cut and Paste
# Tags: cut, delete, word
---
Use `dw` to delete from cursor to start of next word, `de` to delete to end of current word, or `db` to delete to start of current word.

#### Example

```vim
dw  " delete to next word
de  " delete to end of word
db  " delete to start of word
```
===

# Title: Cut to end of line
# Category: Cut and Paste
# Tags: cut, line, end
---
Use `D` or `d$` to delete from cursor to end of line.

#### Example

```vim
D    " delete to end of line
d$   " delete to end of line
```
===

# Title: Yank line
# Category: Cut and Paste
# Tags: yank, copy, line
---
Use `yy` to yank (copy) the current line, or `{number}yy` to yank multiple lines.

#### Example

```vim
yy   " yank current line
3yy  " yank 3 lines
```
===

# Title: Yank word
# Category: Cut and Paste
# Tags: yank, copy, word
---
Use `yw` to yank from cursor to start of next word, `ye` to yank to end of current word.

#### Example

```vim
yw  " yank to next word
ye  " yank to end of word
```
===

# Title: Paste text
# Category: Cut and Paste
# Tags: paste, put, text
---
Use `p` to paste after cursor/line and `P` to paste before cursor/line.

#### Example

```vim
p  " paste after
P  " paste before
```
===

# Title: Auto indent
# Category: Indentation
# Tags: indent, auto, format
---
Use `==` to auto-indent current line, or `{number}==` to auto-indent multiple lines.

#### Example

```vim
==   " auto-indent current line
5==  " auto-indent 5 lines
```
===

# Title: Indent lines
# Category: Indentation
# Tags: indent, shift, format
---
Use `>>` to indent current line right, `<<` to indent left, or use with numbers for multiple lines.

#### Example

```vim
>>   " indent line right
<<   " indent line left
3>>  " indent 3 lines right
```
===

# Title: Quit Vim
# Category: Exit
# Tags: quit, exit, close
---
Use `:q` to quit, `:q!` to quit without saving, `:wq` or `:x` to write and quit, or `ZZ` to save and exit.

#### Example

```vim
:q   " quit
:q!  " quit without saving
:wq  " write and quit
ZZ   " save and exit
```
===

# Title: Open new tab
# Category: Tabs
# Tags: tab, new, open
---
Use `:tabnew` or `:tabedit {file}` to open a new tab, optionally with a file.

#### Example

```vim
:tabnew
:tabedit file.txt
```
===

# Title: Navigate tabs
# Category: Tabs
# Tags: tab, navigate, switch
---
Use `gt` to go to next tab, `gT` to go to previous tab, or `{number}gt` to go to specific tab.

#### Example

```vim
gt   " next tab
gT   " previous tab
2gt  " go to tab 2
```
===

# Title: Close tab
# Category: Tabs
# Tags: tab, close, exit
---
Use `:tabclose` to close current tab.

#### Example

```vim
:tabclose
```
===

# Title: Open file
# Category: File Operations
# Tags: file, open, edit
---
Use `:e {file}` to edit/open a file, or `:edit {file}` as the full command.

#### Example

```vim
:e file.txt
:edit ../other.txt
```
===

# Title: Save file
# Category: File Operations
# Tags: file, save, write
---
Use `:w` to save current file, `:w {file}` to save as new file, or `:wall` to save all files.

#### Example

```vim
:w             " save current file
:w newfile.txt " save as new file
:wall          " save all files
```
===

# Title: Buffer operations
# Category: File Operations
# Tags: buffer, file, switch
---
Use `:ls` to list buffers, `:b {number}` to switch to buffer, `:bn` for next buffer, `:bp` for previous buffer.

#### Example

```vim
:ls   " list buffers
:b2   " switch to buffer 2
:bn   " next buffer
:bp   " previous buffer
```
===

# Title: Search with confirmation
# Category: Search
# Tags: replace, confirm, interactive
---
Use `:%s/old/new/gc` to replace with confirmation for each match.

#### Example

```vim
:%s/foo/bar/gc  " replace with confirmation
```
===

# Title: Search in selection
# Category: Search
# Tags: replace, selection, range
---
Use `:'<,'>s/old/new/g` to replace only in visual selection.

#### Example

```vim
:'<,'>s/foo/bar/g  " replace in selection
```
===

# Title: Case insensitive search
# Category: Search
# Tags: search, case, insensitive
---
Use `/pattern\c` for case insensitive search, or `/pattern\C` for case sensitive search.

#### Example

```vim
/hello\c  " case insensitive
/hello\C  " case sensitive
```
===

# Title: Move line down
# Category: Clever Tricks
# Tags: line, move, transpose
---
Use `ddp` to move current line down one position. This deletes the line and pastes it below.

#### Example

```vim
ddp  " move line down
```
===

# Title: Move line up
# Category: Clever Tricks
# Tags: line, move, transpose
---
Use `ddkP` to move current line up one position. This deletes the line, moves up, and pastes above.

#### Example

```vim
ddkP  " move line up
```
===

# Title: Duplicate line
# Category: Clever Tricks
# Tags: line, duplicate, copy
---
Use `yyp` to duplicate current line below, or `yyP` to duplicate above.

#### Example

```vim
yyp  " duplicate line below
yyP  " duplicate line above
```
===

# Title: Swap two characters
# Category: Clever Tricks
# Tags: character, swap, transpose
---
Use `xp` to swap current character with next character.

#### Example

```vim
xp  " swap characters
```
===

# Title: Quick substitute word
# Category: Clever Tricks
# Tags: substitute, word, replace
---
Use `ciw{newword}` to change inner word. Position cursor anywhere in word and type replacement.

#### Example

```vim
ciwfoo  " change word to 'foo'
```
===

# Title: Quick fix typo
# Category: Clever Tricks
# Tags: typo, fix, undo
---
Use `~` to toggle case of character under cursor, or `g~iw` to toggle case of entire word.

#### Example

```vim
~     " toggle character case
g~iw  " toggle word case
```
===

# Title: Split line at cursor
# Category: Clever Tricks
# Tags: split, line, break
---
Use `i` followed by `Enter` then `Esc`, or more efficiently `r` followed by `Enter` to break line at cursor.

#### Example

```vim
i<Enter><Esc>  " split line at cursor
```
===

# Title: Quick number increment
# Category: Clever Tricks
# Tags: number, increment, math
---
Use `Ctrl+a` to increment number under cursor, `Ctrl+x` to decrement. Works with decimals and hex.

#### Example

```vim
Ctrl+a  " increment number
Ctrl+x  " decrement number
```
===

# Title: Visual line selection shortcut
# Category: Clever Tricks
# Tags: visual, line, selection
---
Use `V` to select entire line immediately, then `j`/`k` to extend selection.

#### Example

```vim
Vjjj  " select current line + 3 below
```
===

# Title: Change until character
# Category: Clever Tricks
# Tags: change, until, character
---
Use `ct{char}` to change text up to but not including character, or `cf{char}` to include the character.

#### Example

```vim
ct;  " change until semicolon
cf;  " change including semicolon
```
===

# Title: Jump to matching quote
# Category: Clever Tricks
# Tags: quote, matching, jump
---
Use `ci'` or `ci"` to change inside quotes, `ca'` or `ca"` to change including quotes.

#### Example

```vim
ci'  " change inside single quotes
ca"  " change including double quotes
```
===

# Title: Quick paragraph navigation
# Category: Clever Tricks
# Tags: paragraph, navigation, block
---
Use `{` to jump to previous paragraph/block, `}` to jump to next paragraph/block.

#### Example

```vim
{  " previous paragraph
}  " next paragraph
```
===

# Title: Smart word boundaries
# Category: Clever Tricks
# Tags: word, boundary, navigation
---
Use `W` for WORD (space-separated) vs `w` for word (punctuation-separated). Same with `B` vs `b` and `E` vs `e`.

#### Example

```vim
W  " next WORD (space-separated)
w  " next word (punctuation-separated)
```
===

# Title: Reselect last selection
# Category: Clever Tricks
# Tags: visual, reselect, selection
---
Use `gv` to reselect the last visual selection.

#### Example

```vim
gv  " reselect last visual selection
```
===

# Title: Center line after jump
# Category: Clever Tricks
# Tags: center, jump, navigation
---
Append `zz` after navigation commands to center the line. Works with searches, line jumps, etc.

#### Example

```vim
42Gzz   " jump to line 42 and center
/foozz  " search for 'foo' and center
```
===

# Title: Quick comment toggle
# Category: Neovim Features
# Tags: comment, toggle, modern
---
Use `gcc` to toggle comment on current line, or `gc` in visual mode to toggle comments on selection (requires comment plugin).

#### Example

```vim
gcc  " toggle line comment
gc   " toggle visual selection comment
```
===

# Title: Multiple cursors simulation
# Category: Neovim Features
# Tags: cursor, multiple, editing
---
Use `cgn` after searching to change next match, then press `.` to repeat on subsequent matches.

#### Example

```vim
/word   " search for 'word'
cgn     " change next match
.       " repeat change on next match
```
===

# Title: Tree-sitter text objects
# Category: Neovim Features
# Tags: treesitter, textobject, modern
---
Use `vaf` to select around function, `vif` for inside function, `vac` for around class (requires treesitter text objects).

#### Example

```vim
vaf  " select around function
vif  " select inside function
vac  " select around class
```
===

# Title: LSP hover info
# Category: Neovim Features
# Tags: lsp, hover, documentation
---
Use `K` in normal mode to show hover documentation when LSP is active. Press `K` again to enter the hover window.

#### Example

```vim
K  " show hover documentation
```
===

# Title: Quick fix navigation
# Category: Neovim Features
# Tags: quickfix, navigation, errors
---
Use `:cn` to go to next error/item in quickfix list, `:cp` for previous, `:copen` to open quickfix window.

#### Example

```vim
:cn     " next quickfix item
:cp     " previous quickfix item
:copen  " open quickfix window
```
===

# Title: Built-in terminal
# Category: Neovim Features
# Tags: terminal, integrated, modern
---
Use `:term` to open terminal, `Ctrl+\` followed by `Ctrl+n` to exit terminal mode to normal mode.

#### Example

```vim
:term           " open terminal
Ctrl+\ Ctrl+n   " exit terminal mode
```
===

# Title: Window splitting shortcuts
# Category: Neovim Features
# Tags: window, split, navigation
---
Use `Ctrl+w s` for horizontal split, `Ctrl+w v` for vertical split, `Ctrl+w w` to cycle windows.

#### Example

```vim
Ctrl+w s  " horizontal split
Ctrl+w v  " vertical split
Ctrl+w w  " cycle windows
```
===

