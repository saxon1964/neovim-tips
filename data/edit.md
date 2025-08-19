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
# Title: Time-based undo navigation
# Category: Edit
# Tags: undo, time, history
---
Use `:earlier 10m` to revert buffer to state 10 minutes ago, or `:later 5m` to go forward 5 minutes.

#### Example

```vim
:earlier 10m  " revert to 10 minutes ago
:later 5m     " go forward 5 minutes
```
===
# Title: Increment and decrement numbers
# Category: Edit
# Tags: number, increment, decrement, arithmetic
---
Use `Ctrl+a` to increment the number at or after cursor and `Ctrl+x` to decrement it.

#### Example

```vim
Ctrl+a  " increment number under/after cursor
Ctrl+x  " decrement number under/after cursor
```
===
# Title: Redraw screen
# Category: Edit
# Tags: redraw, screen, refresh, display
---
Use `Ctrl+l` to redraw the screen, useful when display gets corrupted or needs refreshing.

#### Example

```vim
Ctrl+l  " redraw screen
```
===
# Title: Show file information
# Category: Edit
# Tags: file, info, position, status
---
Use `Ctrl+g` to display current file name, cursor position, and buffer information.

#### Example

```vim
Ctrl+g  " show file info and cursor position
```
===
# Title: Join lines
# Category: Edit
# Tags: join, lines, merge
---
Use `J` to join the current line with the next line, removing the line break and adding appropriate spacing.

#### Example

```vim
J   " join current line with next line
3J  " join 3 lines together
```
===
# Title: Substitute characters
# Category: Edit
# Tags: substitute, character, delete, insert
---
Use `s` to substitute (delete character under cursor and enter insert mode) and `S` to substitute entire line.

#### Example

```vim
s   " substitute character under cursor
S   " substitute entire line
5s  " substitute 5 characters
```
===
# Title: Change commands
# Category: Edit
# Tags: change, delete, insert, modify
---
Use `C` to change from cursor to end of line and `cc` to change entire line.

#### Example

```vim
C   " change to end of line
cc  " change entire line
c3w " change 3 words
```
===
# Title: Delete to end of line
# Category: Edit
# Tags: delete, line, end
---
Use `D` to delete from cursor to the end of the current line.

#### Example

```vim
D  " delete to end of line
```
===
# Title: Repeat last change
# Category: Edit
# Tags: repeat, change, command
---
Use `.` (dot) to repeat the last change command.

#### Example

```vim
.  " repeat last change
```
===
# Title: Operator-pending mode basics
# Category: Edit
# Tags: operator, pending, mode, motion
---
After typing an operator (d, c, y, etc.), you enter operator-pending mode where you can provide motion or text object to complete the operation.

#### Example

```vim
d    " delete operator (enters pending mode)
dw   " delete word (operator + motion)
ci(  " change inside parentheses (operator + text object)
```
===
# Title: Operator-pending mode - force operation type
# Category: Edit
# Tags: operator, pending, force, characterwise, linewise, blockwise
---
Use `v` for characterwise, `V` for linewise, `Ctrl+v` for blockwise operation after an operator.

#### Example

```vim
dvw   " force characterwise delete word
dV    " force linewise delete (whole line)
dCtrl+v}  " force blockwise delete to closing brace
```
===
# Title: Operator-pending mode - cancel operations
# Category: Edit
# Tags: operator, pending, cancel, abort, undo
---
Use `Esc` to abandon the operator or `Backspace` to undo/cancel the operator in pending mode.

#### Example

```vim
d<Esc>         " abandon delete operation
c<Backspace>   " cancel change operation
```
===
# Title: Common operators with motions
# Category: Edit
# Tags: operator, motion, combination, examples
---
Operators like `d` (delete), `c` (change), `y` (yank), `>` (indent) work with any motion or text object.

#### Example

```vim
dw    " delete word
c3j   " change 3 lines down
y$    " yank to end of line
>i{   " indent inside braces
=ap   " format around paragraph
```
===
# Title: Operator-pending mode with text objects
# Category: Edit
# Tags: operator, text, object, combination
---
All text objects (iw, aw, i(, a(, ip, ap, etc.) work in operator-pending mode for precise text manipulation.

#### Example

```vim
ciw   " change inside word
da(   " delete around parentheses
yi"   " yank inside quotes
>ap   " indent around paragraph
=i{   " format inside braces
```
===