# Title: Increment and decrement numbers
# Category: Normal Mode
# Tags: number, increment, decrement, arithmetic
---
Use `Ctrl+a` to increment number under cursor, `Ctrl+x` to decrement. Works with decimal, hex, octal, and binary.

```vim
Ctrl+a    " increment number under cursor
Ctrl+x    " decrement number under cursor
5Ctrl+a   " increment by 5
```

Works on hex (0x1F), octal (017), binary (0b1010), and decimals.
===
# Title: Repeat last command
# Category: Normal Mode
# Tags: repeat, command, dot, redo
---
Use `.` to repeat the last change command. One of Vim's most powerful features for efficient editing.

```vim
.         " repeat last change
dd.       " delete line, then repeat delete
cw foo<Esc>.  " change word to foo, then repeat on next word
```
===
# Title: Record and replay macros
# Category: Normal Mode
# Tags: macro, record, replay, automation
---
Use `q{letter}` to start recording macro, `q` to stop, `@{letter}` to replay, `@@` to replay last macro.

```vim
qa        " start recording macro to register 'a'
... commands ...
q         " stop recording
@a        " replay macro 'a'
@@        " replay last macro
5@a       " replay macro 'a' 5 times
```
===
# Title: Case conversion commands
# Category: Normal Mode
# Tags: case, upper, lower, toggle, conversion
---
Use `~` to toggle case of character, `g~` with motion for range case toggle, `gu` for lowercase, `gU` for uppercase.

```vim
~         " toggle case of character under cursor
g~w       " toggle case of word
guw       " lowercase word
gUw       " uppercase word  
g~~       " toggle case of entire line
```
===
# Title: Join lines with space control
# Category: Normal Mode
# Tags: join, lines, space, merge
---
Use `J` to join current line with next (adds space), `gJ` to join without adding space.

```vim
J         " join lines with space
gJ        " join lines without space
3J        " join current line with next 2 lines
```
===
# Title: Replace single character
# Category: Normal Mode
# Tags: replace, character, single, substitute
---
Use `r{char}` to replace character under cursor with {char}, `R` to enter replace mode.

```vim
ra        " replace character under cursor with 'a'
r<Space>  " replace with space
R         " enter replace mode
```
===
# Title: Change case of text
# Category: Normal Mode
# Tags: case, change, text, range
---
Use `g~` followed by motion to toggle case, `gu` for lowercase, `gU` for uppercase.

```vim
g~$       " toggle case from cursor to end of line
guw       " lowercase word under cursor
gUiw      " uppercase inner word
g~ap      " toggle case of paragraph
```
===
# Title: Insert at line ends/beginnings
# Category: Normal Mode
# Tags: insert, line, beginning, end, multiple
---
Use `I` to insert at beginning of line, `A` to append at end of line.

```vim
I         " insert at beginning of line (first non-blank)
A         " append at end of line
gI        " insert at column 1 (absolute beginning)
```
===
# Title: Open new lines
# Category: Normal Mode
# Tags: open, line, above, below, insert
---
Use `o` to open line below cursor, `O` to open line above cursor (both enter insert mode).

```vim
o         " open new line below and enter insert mode
O         " open new line above and enter insert mode
3o        " open 3 new lines below
```
===
# Title: Delete characters and words
# Category: Normal Mode
# Tags: delete, character, word, backspace
---
Use `x` to delete character under cursor, `X` to delete before cursor, `dw` to delete word, `dd` to delete line.

```vim
x         " delete character under cursor
X         " delete character before cursor
dw        " delete word
dd        " delete entire line
D         " delete from cursor to end of line
```
===
# Title: Yank operations
# Category: Normal Mode  
# Tags: yank, copy, line, word, clipboard
---
Use `y` with motion to yank (copy), `yy` to yank line, `Y` to yank to end of line.

```vim
yy        " yank entire line
yw        " yank word
y$        " yank from cursor to end of line
Y         " yank from cursor to end of line (same as y$)
yap       " yank around paragraph
```
===
# Title: Put operations
# Category: Normal Mode
# Tags: put, paste, register, before, after
---
Use `p` to put (paste) after cursor, `P` to put before cursor. Works with any register content.

```vim
p         " put after cursor/line
P         " put before cursor/line
"ap       " put from register 'a' after cursor
"0p       " put from yank register (register 0)
```
===
# Title: Undo and redo
# Category: Normal Mode
# Tags: undo, redo, history, changes
---
Use `u` to undo last change, `Ctrl+r` to redo, `U` to undo all changes on current line.

```vim
u         " undo last change
Ctrl+r    " redo last undone change
U         " undo all changes on current line
```
===
# Title: Change operations
# Category: Normal Mode
# Tags: change, replace, word, line, text
---
Use `c` with motion to change (delete and enter insert mode), `cc` to change line, `C` to change to end.

```vim
cw        " change word
cc        " change entire line
C         " change from cursor to end of line
ciw       " change inner word
cip       " change inner paragraph
```
===
# Title: Visual selection commands
# Category: Normal Mode
# Tags: visual, select, line, block, character
---
Use `v` for character-wise visual, `V` for line-wise visual, `Ctrl+v` for block-wise visual.

```vim
v         " start character-wise visual selection
V         " start line-wise visual selection
Ctrl+v    " start block-wise visual selection
gv        " reselect last visual selection
```
===
# Title: Go to column
# Category: Normal Mode
# Tags: column, position, horizontal, goto
---
Use `{number}|` to go to specific column number on current line.

```vim
10|       " go to column 10
1|        " go to column 1 (beginning of line)
$         " go to end of line (last column)
```
===
# Title: Search under cursor
# Category: Normal Mode
# Tags: search, word, cursor, find, highlight
---
Use `*` to search forward for word under cursor, `#` to search backward.

```vim
*         " search forward for word under cursor
#         " search backward for word under cursor
g*        " search forward for partial word match
g#        " search backward for partial word match
```
===
# Title: Mark commands
# Category: Normal Mode
# Tags: mark, position, jump, navigate
---
Use `m{letter}` to set mark, `'{letter}` to jump to mark's line, `\`{letter}` to jump to exact position.

```vim
ma        " set mark 'a' at current position
'a        " jump to line of mark 'a' (first non-blank)
`a        " jump to exact position of mark 'a'
``        " jump to position before last jump
''        " jump to line before last jump
```
===
# Title: Filter through external command
# Category: Normal Mode
# Tags: filter, external, command, process
---
Use `!` with motion to filter text through external command, `!!` to filter current line.

```vim
!}sort    " sort from cursor to end of paragraph
!!date    " replace current line with date
!5jsort   " sort next 5 lines
!Gsort    " sort from cursor to end of file
```
===
# Title: Format text
# Category: Normal Mode
# Tags: format, indent, text, alignment
---
Use `=` with motion to format/indent text, `==` to format current line.

```vim
==        " format current line
=ap       " format around paragraph
=G        " format from cursor to end of file
gg=G      " format entire file
```
===
# Title: Indent and outdent
# Category: Normal Mode
# Tags: indent, outdent, shift, tab
---
Use `>` to indent, `<` to outdent. Works with motions and counts.

```vim
>>        " indent current line
<<        " outdent current line
>ap       " indent around paragraph
3>>       " indent next 3 lines
>G        " indent from cursor to end
```
===
# Title: Fold operations
# Category: Normal Mode
# Tags: fold, unfold, toggle, code
---
Use `za` to toggle fold, `zo` to open fold, `zc` to close fold, `zR` to open all folds.

```vim
za        " toggle fold at cursor
zo        " open fold at cursor
zc        " close fold at cursor
zR        " open all folds in buffer
zM        " close all folds in buffer
```
===
# Title: Window navigation
# Category: Normal Mode
# Tags: window, switch, navigate, split
---
Use `Ctrl+w` followed by direction to move between windows.

```vim
Ctrl+w h  " move to left window
Ctrl+w j  " move to window below
Ctrl+w k  " move to window above
Ctrl+w l  " move to right window
Ctrl+w w  " cycle through windows
```
===
# Title: Ex mode and command execution
# Category: Normal Mode
# Tags: ex, command, colon, execute
---
Use `:` to enter command-line mode, `Q` to enter Ex mode (rarely used).

```vim
:         " enter command-line mode
Q         " enter Ex mode (exit with :vi)
```
===
# Title: Spelling navigation
# Category: Normal Mode
# Tags: spell, navigation, error, correction
---
Use `]s` to go to next misspelled word, `[s` for previous, `z=` for suggestions.

```vim
]s        " next misspelled word
[s        " previous misspelled word
z=        " show spelling suggestions
zg        " add word to good word list
zw        " add word as misspelled
```
===
# Title: Completion in insert mode trigger
# Category: Normal Mode
# Tags: completion, insert, keyword, file
---
Use `Ctrl+n` and `Ctrl+p` in insert mode for word completion, `Ctrl+x Ctrl+f` for filename completion.

```vim
" In insert mode:
Ctrl+n    " next completion
Ctrl+p    " previous completion
Ctrl+x Ctrl+f  " filename completion
Ctrl+x Ctrl+l  " line completion
```
===
# Title: Digraph insertion
# Category: Normal Mode
# Tags: digraph, special, character, unicode
---
Use `Ctrl+k` in insert mode followed by two characters to insert special characters.

```vim
" In insert mode:
Ctrl+k a'  " insert á (a with acute accent)
Ctrl+k e`  " insert è (e with grave accent)
Ctrl+k c,  " insert ç (c with cedilla)
Ctrl+k >>  " insert » (right guillemet)
```
===
# Title: Tag navigation
# Category: Normal Mode
# Tags: tag, definition, ctags, jump
---
Use `Ctrl+]` to jump to tag under cursor, `Ctrl+t` to return from tag jump.

```vim
Ctrl+]    " jump to tag definition
Ctrl+t    " return from tag jump
g Ctrl+]  " show list of matching tags
```
===
# Title: File under cursor operations
# Category: Normal Mode
# Tags: file, cursor, edit, goto
---
Use `gf` to open file under cursor, `gF` to open file with line number.

```vim
gf        " open file under cursor
gF        " open file under cursor with line number
Ctrl+w f  " open file under cursor in new window
Ctrl+w gf " open file under cursor in new tab
```
===
# Title: Buffer navigation shortcuts
# Category: Normal Mode
# Tags: buffer, navigate, switch, file
---
Use `Ctrl+^` or `Ctrl+6` to switch to alternate buffer (previously edited file).

```vim
Ctrl+^    " switch to alternate buffer
Ctrl+6    " same as Ctrl+^ (switch to alternate)
```
===
# Title: Line completion and duplication
# Category: Normal Mode
# Tags: line, duplicate, copy, complete
---
Use `yyp` to duplicate current line, `Yp` for same effect, `yy` then `p` anywhere to paste line.

```vim
yyp       " duplicate current line below
yyP       " duplicate current line above
Yp        " same as yyp (Y yanks line, p pastes)
```
===