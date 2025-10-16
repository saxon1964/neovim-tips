# Title: Edit file under cursor with gf
# Category: Navigation
# Tags: g-commands, file, navigation, cursor
---
Use `gf` to edit the file whose path is under the cursor. Useful for navigating to files in code.

```vim
" Place cursor on a file path and press:
gf  " open file in current window

" Related commands:
CTRL-W f  " open file in new window
CTRL-W gf " open file in new tab
```
***
# Title: Open URL or file with gx
# Category: Navigation
# Tags: g-commands, url, file, open, external
---
Use `gx` to open the file or URL under the cursor with the system's default application.

```vim
" Place cursor on URL or file path:
gx  " open with default application (browser for URLs, etc.)
```
***
# Title: Return to last insert position with gi
# Category: Navigation
# Tags: g-commands, insert, navigation, jump
---
Use `gi` to jump to the last position where you were in INSERT mode and enter INSERT mode.

```vim
gi  " jump to last insertion point and enter INSERT mode
```
***
# Title: Reselect last visual selection with gv
# Category: Visual
# Tags: g-commands, visual, selection, reselect
---
Use `gv` to reselect the last visual selection. Useful for reapplying operations.

```vim
" After making a visual selection and returning to normal mode:
gv  " reselect the same area
```
***
# Title: Select last search match with gn
# Category: Search
# Tags: g-commands, search, visual, selection
---
Use `gn` to visually select the next match of the last search pattern. Powerful for targeted changes.

```vim
" After searching with /pattern:
gn    " select next match
cgn   " change next match (then use . to repeat)
dgn   " delete next match
```
***
# Title: Insert at line start with gI
# Category: Insert
# Tags: g-commands, insert, column, line-start
---
Use `gI` to insert text at the first column of the line (before any indentation).

```vim
gI  " insert at column 1 (ignoring indentation)
I   " insert before first non-blank character (respects indentation)
```
***
# Title: Show ASCII value with ga
# Category: Utilities
# Tags: g-commands, ascii, character, info
---
Use `ga` to display the ASCII/Unicode value of the character under the cursor.

```vim
" Place cursor on a character:
ga  " shows decimal, hex, and octal values
```
***
# Title: Change case with gu and gU
# Category: Text
# Tags: g-commands, case, uppercase, lowercase
---
Use `gu` and `gU` to change the case of text with motion or in visual mode.

```vim
" In normal mode:
guw   " lowercase word
gUw   " uppercase word
guiw  " lowercase inner word
gU$   " uppercase to end of line

" In visual mode:
gu    " lowercase selection
gU    " uppercase selection
```
***
# Title: Join lines without spaces with gJ
# Category: Text
# Tags: g-commands, join, lines
---
Use `gJ` to join lines without inserting spaces between them.

```vim
gJ   " join current line with next, no space added
J    " join with space added (standard join)
```
***
# Title: Move to middle of screen line with gm
# Category: Navigation
# Tags: g-commands, navigation, screen, middle
---
Use `gm` to move the cursor to the middle of the screen line.

```vim
gm  " jump to middle of screen line
```
***
# Title: Navigate screen lines with gj and gk
# Category: Navigation
# Tags: g-commands, navigation, screen-lines, wrapped
---
Use `gj` and `gk` to move by screen lines instead of actual lines (useful for wrapped text).

```vim
gj  " move down one screen line
gk  " move up one screen line

" Compare with:
j   " move down one actual line
k   " move up one actual line
```
***
# Title: Move to screen line positions with g0, g^, g$
# Category: Navigation
# Tags: g-commands, navigation, screen-lines, position
---
Use `g0`, `g^`, and `g$` to move to positions within screen lines (for wrapped text).

```vim
g0  " move to first character of screen line
g^  " move to first non-blank of screen line
g$  " move to last character of screen line

" Compare with regular commands:
0   " first character of actual line
^   " first non-blank of actual line
$   " last character of actual line
```
***
# Title: Go to previous/next tab with gT and gt
# Category: Tabs
# Tags: g-commands, tabs, navigation
---
Use `gt` and `gT` to navigate between tabs.

```vim
gt   " go to next tab
gT   " go to previous tab
{n}gt " go to tab number n
```
***
# Title: Format text with gq
# Category: Formatting
# Tags: g-commands, format, text, wrap
---
Use `gq` to format text according to 'textwidth' and other formatting options.

```vim
gqap  " format around paragraph
gqq   " format current line
gq}   " format until end of paragraph

" In visual mode:
gq    " format selection
```
***
# Title: Format without moving cursor with gw
# Category: Formatting
# Tags: g-commands, format, cursor, text
---
Use `gw` to format text like `gq` but keep the cursor position.

```vim
gwap  " format around paragraph, cursor stays
gww   " format current line, cursor stays
```
***
# Title: Swap character case with g~
# Category: Text
# Tags: g-commands, case, swap, toggle
---
Use `g~` to swap the case of text (uppercase ↔ lowercase).

```vim
g~w   " swap case of word
g~iw  " swap case of inner word
g~$   " swap case to end of line

" In visual mode:
g~    " swap case of selection
```
***
# Title: Repeat last command with g.
# Category: Editing
# Tags: g-commands, repeat, command, redo
---
Use `g.` to jump to the position of the last change.

```vim
g;  " go to position of previous change (older)
g,  " go to position of next change (newer)
```
***
# Title: Increment numbers in sequence with g CTRL-A
# Category: Editing
# Tags: g-commands, numbers, increment, sequence
---
Use `g CTRL-A` in visual mode to increment numbers sequentially (1, 2, 3, ...).

```vim
" Select multiple lines with same number:
1
1
1

" Press g CTRL-A to get:
1
2
3

" Similarly, g CTRL-X decrements sequentially
```
***
