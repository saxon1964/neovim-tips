# Title: Time-based undo navigation
# Category: Edit
# Tags: undo, time, history
---
Use `:earlier 10m` to revert buffer to state 10 minutes ago, or `:later 5m` to go forward 5 minutes.

```vim
:earlier 10m  " revert to 10 minutes ago
:later 5m     " go forward 5 minutes
```
***
# Title: Redraw screen
# Category: Edit
# Tags: redraw, screen, refresh, display
---
Use `Ctrl+l` to redraw the screen, useful when display gets corrupted or needs refreshing.

```vim
Ctrl+l  " redraw screen
```
***
# Title: Show file information
# Category: Edit
# Tags: file, info, position, status
---
Use `Ctrl+g` to display current file name, cursor position, and buffer information.

```vim
Ctrl+g  " show file info and cursor position
```
***
# Title: Substitute characters
# Category: Edit
# Tags: substitute, character, delete, insert
---
Use `s` to substitute (delete character under cursor and enter insert mode) and `S` to substitute entire line.

```vim
s   " substitute character under cursor
S   " substitute entire line
5s  " substitute 5 characters
```
***
# Title: Repeat last change
# Category: Edit
# Tags: repeat, change, command
---
Use `.` (dot) to repeat the last change command.

```vim
.  " repeat last change
```
***
# Title: Operator-pending mode basics
# Category: Edit
# Tags: operator, pending, mode, motion
---
After typing an operator (d, c, y, etc.), you enter operator-pending mode where you can provide motion or text object to complete the operation.

```vim
d    " delete operator (enters pending mode)
dw   " delete word (operator + motion)
ci(  " change inside parentheses (operator + text object)
```
***
# Title: Operator-pending mode - force operation type
# Category: Edit
# Tags: operator, pending, force, characterwise, linewise, blockwise
---
Use `v` for characterwise, `V` for linewise, `Ctrl+v` for blockwise operation after an operator.

```vim
dvw   " force characterwise delete word
dV    " force linewise delete (whole line)
dCtrl+v}  " force blockwise delete to closing brace
```
***
# Title: Operator-pending mode - cancel operations
# Category: Edit
# Tags: operator, pending, cancel, abort, undo
---
Use `Esc` to abandon the operator or `Backspace` to undo/cancel the operator in pending mode.

```vim
d<Esc>         " abandon delete operation
c<Backspace>   " cancel change operation
```
***
# Title: Common operators with motions
# Category: Edit
# Tags: operator, motion, combination, examples
---
Operators like `d` (delete), `c` (change), `y` (yank), `>` (indent) work with any motion or text object.

```vim
dw    " delete word
c3j   " change 3 lines down
y$    " yank to end of line
>i{   " indent inside braces
=ap   " format around paragraph
```
***
# Title: Operator-pending mode with text objects
# Category: Edit
# Tags: operator, text, object, combination
---
All text objects (iw, aw, i(, a(, ip, ap, etc.) work in operator-pending mode for precise text manipulation.

```vim
ciw   " change inside word
da(   " delete around parentheses
yi"   " yank inside quotes
>ap   " indent around paragraph
=i{   " format inside braces
```
***
# Title: Adding prefix/suffix to multiline text easily
# Category: Edit
# Tags: text, object, advanced
---
Suppose that you have multiple lines of text. You want to put `<b>` and `</b>` tags around each line:

- Position the cursor in normal mode over the first char of the frist line
- Enter visual block mode: `<C-v>`
- Select all first characters in all lines under the first one by using normal cursor keys
- Switch to insert mode: `I`
- Start changing the first line by typing `<b>`
- When you are done, press `<ESC>` and all lines will have the same `<b>` prefix.
- Now let's add `</b>` to the end of each line. Press `gv` - the first column gets selected.
- Press `$` to go to the end of the line.
- Now type `A` to append to the line
- The cursor goes to the end of the top line. Enter the closing tag `</b>`.
- Now pres `ESC` to leave the insert mode and you are done!

Credits: [Henry Misc](https://www.youtube.com/watch?v=RdyfT2dbt78https://www.youtube.com/watch?v=RdyfT2dbt78)
***

