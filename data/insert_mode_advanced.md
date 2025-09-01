# Title: Insert mode navigation without exiting
# Category: Insert Mode Advanced
# Tags: navigation, cursor, movement, arrow
---
Use arrow keys or `Ctrl+h` (left), `Ctrl+j` (down), `Ctrl+k` (up), `Ctrl+l` (right) to navigate in insert mode.

```vim
" In insert mode:
<Left>/<Right>  " move by character
<Up>/<Down>     " move by line
Ctrl+h          " move left (backspace)
Ctrl+l          " move right
```
===
# Title: Word movement in insert mode
# Category: Insert Mode Advanced
# Tags: word, movement, navigation, shift
---
Use `Shift+Left` and `Shift+Right` to move by words in insert mode.

```vim
" In insert mode:
Shift+Left      " move to beginning of previous word
Shift+Right     " move to beginning of next word
Ctrl+Left       " alternative word movement left
Ctrl+Right      " alternative word movement right
```
===
# Title: Line movement in insert mode
# Category: Insert Mode Advanced
# Tags: line, movement, beginning, end
---
Use `Ctrl+o` to execute one normal command, then return to insert mode at same position.

```vim
" In insert mode:
Ctrl+o ^        " go to first non-blank character
Ctrl+o $        " go to end of line
Ctrl+o gg       " go to first line
Ctrl+o G        " go to last line
```
===
# Title: Delete operations in insert mode
# Category: Insert Mode Advanced
# Tags: delete, backspace, word, line
---
Use various delete operations without leaving insert mode.

```vim
" In insert mode:
<BS>            " delete character before cursor
<Del>           " delete character under cursor
Ctrl+h          " delete character before cursor (same as backspace)
Ctrl+w          " delete word before cursor
Ctrl+u          " delete from cursor to beginning of line
```
===
# Title: Advanced completion modes
# Category: Insert Mode Advanced
# Tags: completion, advanced, keyword, line
---
Use specialized completion commands for different contexts.

```vim
" In insert mode:
Ctrl+x Ctrl+l   " complete whole lines
Ctrl+x Ctrl+n   " complete keywords in current file
Ctrl+x Ctrl+k   " complete from dictionary
Ctrl+x Ctrl+t   " complete from thesaurus
Ctrl+x Ctrl+i   " complete from included files
Ctrl+x Ctrl+]   " complete from tags
Ctrl+x Ctrl+s   " spelling suggestions
Ctrl+x Ctrl+u   " user defined completion
Ctrl+x Ctrl+v   " vim command-line completion
Ctrl+x Ctrl+o   " omni completion
```
===
# Title: Literal character insertion
# Category: Insert Mode Advanced
# Tags: literal, character, special, escape
---
Use `Ctrl+v` to insert special characters literally in insert mode.

```vim
" In insert mode:
Ctrl+v <Tab>    " insert literal tab character
Ctrl+v <Esc>    " insert literal escape character
Ctrl+v <Enter>  " insert literal newline
Ctrl+v Ctrl+m   " insert carriage return
```
===
# Title: Insert mode register shortcuts
# Category: Insert Mode Advanced  
# Tags: register, shortcut, special, paste
---
Use special register shortcuts for common insert operations.

```vim
" In insert mode:
Ctrl+r %        " insert current filename
Ctrl+r #        " insert alternate filename
Ctrl+r :        " insert last command line
Ctrl+r /        " insert last search pattern
Ctrl+r .        " insert last inserted text
```
===
# Title: Insert mode window operations
# Category: Insert Mode Advanced
# Tags: window, scroll, operation, view
---
Use window operations without leaving insert mode.

```vim
" In insert mode:
Ctrl+x Ctrl+e   " scroll window down one line
Ctrl+x Ctrl+y   " scroll window up one line  
Ctrl+o zz       " center current line
Ctrl+o zt       " move current line to top
Ctrl+o zb       " move current line to bottom
```
===
# Title: Completion menu navigation
# Category: Insert Mode Advanced
# Tags: completion, menu, navigate, popup
---
Navigate and control completion popup menus effectively.

```vim
" When completion menu is open:
Ctrl+n          " next item in menu
Ctrl+p          " previous item in menu
Ctrl+y          " accept current selection
Ctrl+e          " close menu without selecting
<Enter>         " accept current selection
<Esc>           " close menu and exit insert mode
```
===
# Title: Smart indentation in insert mode
# Category: Insert Mode Advanced
# Tags: indent, smart, automatic, programming
---
Control automatic indentation behavior in insert mode.

```vim
" In insert mode:
Ctrl+f          " re-indent current line
0 Ctrl+d        " remove all indent from current line
^ Ctrl+d        " remove indent to previous shiftwidth
Ctrl+o >>       " indent current line
Ctrl+o <<       " unindent current line
```
===
# Title: Insert mode text objects
# Category: Insert Mode Advanced
# Tags: text, object, change, delete
---
Use text objects with `Ctrl+o` to operate on text without leaving insert mode.

```vim
" In insert mode:
Ctrl+o diw      " delete inner word
Ctrl+o ciw      " change inner word (stay in insert)
Ctrl+o yiw      " yank inner word
Ctrl+o daw      " delete a word (including spaces)
```
===
# Title: Insert mode marks and jumps
# Category: Insert Mode Advanced
# Tags: mark, jump, position, navigation
---
Set marks and jump to positions without leaving insert mode.

```vim
" In insert mode:
Ctrl+o ma       " set mark 'a' at current position
Ctrl+o 'a       " jump to line of mark 'a'
Ctrl+o `a       " jump to exact position of mark 'a'
Ctrl+o ''       " jump to position before last jump
```
===
# Title: Insert mode search operations
# Category: Insert Mode Advanced
# Tags: search, find, pattern, navigate
---
Perform searches without leaving insert mode.

```vim
" In insert mode:
Ctrl+o /pattern " search forward for pattern
Ctrl+o ?pattern " search backward for pattern
Ctrl+o n        " repeat last search
Ctrl+o N        " repeat last search in opposite direction
Ctrl+o *        " search for word under cursor
```
===
# Title: Insert mode case conversion
# Category: Insert Mode Advanced
# Tags: case, conversion, upper, lower, toggle
---
Convert case of text without leaving insert mode.

```vim
" In insert mode:
Ctrl+o ~        " toggle case of character under cursor  
Ctrl+o guw      " lowercase word under cursor
Ctrl+o gUw      " uppercase word under cursor
Ctrl+o g~w      " toggle case of word under cursor
```
===
# Title: Insert mode abbreviation control
# Category: Insert Mode Advanced
# Tags: abbreviation, control, expand, prevent
---
Control abbreviation expansion in insert mode.

```vim
" In insert mode:
Ctrl+v <Space>  " insert space without expanding abbreviation
Ctrl+]          " manually expand abbreviation
```

After setting `:iabbrev teh the`, typing "teh " expands to "the ".
===
# Title: Insert mode formatting and alignment  
# Category: Insert Mode Advanced
# Tags: format, align, text, paragraph
---
Format and align text without leaving insert mode.

```vim
" In insert mode:
Ctrl+o gqap     " format around paragraph
Ctrl+o =ap      " indent around paragraph
Ctrl+o >ap      " increase indent of paragraph
Ctrl+o <ap      " decrease indent of paragraph
```
===
# Title: Insert mode buffer operations
# Category: Insert Mode Advanced
# Tags: buffer, file, operation, switch
---
Perform buffer operations without leaving insert mode.

```vim
" In insert mode:
Ctrl+o :w       " save current buffer
Ctrl+o :e       " reload current buffer
Ctrl+o Ctrl+^   " switch to alternate buffer
Ctrl+r Ctrl+f   " insert filename under cursor
```
===
# Title: Insert mode folding control
# Category: Insert Mode Advanced  
# Tags: fold, unfold, toggle, code
---
Control code folding without leaving insert mode.

```vim
" In insert mode:
Ctrl+o za       " toggle fold at cursor
Ctrl+o zo       " open fold at cursor
Ctrl+o zc       " close fold at cursor
Ctrl+o zR       " open all folds
Ctrl+o zM       " close all folds
```
===
# Title: Insert mode macro operations
# Category: Insert Mode Advanced
# Tags: macro, record, replay, register
---
Work with macros without leaving insert mode.

```vim
" In insert mode:
Ctrl+o @a       " replay macro 'a'
Ctrl+o @@       " replay last macro
Ctrl+o qa       " start recording macro (then exit insert)
```

Note: Recording typically requires exiting insert mode first.
===
# Title: Insert mode terminal integration
# Category: Insert Mode Advanced
# Tags: terminal, command, external, shell  
---
Execute external commands and insert their output.

```vim
" In insert mode:
Ctrl+r !date    " insert output of date command
Ctrl+r !whoami  " insert current username
Ctrl+r !pwd     " insert current directory
Ctrl+o :r !ls   " read output of ls into buffer
```
===