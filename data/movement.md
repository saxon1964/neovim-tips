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
***
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
***
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
***
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
***
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
***
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
***
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
***
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
***
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
***
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
***
# Title: Matching brackets
# Category: Movement
# Tags: brackets, matching, navigation
---
Use `%` to jump to the matching bracket, parenthesis, or brace.

#### Example

```vim
%  " jump to matching bracket
```
***
# Title: Screen position navigation
# Category: Movement
# Tags: screen, position, navigation
---
Use `H` to move cursor to top of screen and `L` to move cursor to bottom of screen.

#### Example

```vim
H  " move to top of screen
L  " move to bottom of screen
```
***
# Title: Jump to definition
# Category: Movement
# Tags: definition, jump, lsp
---
Use `gd` to jump to the definition of the symbol under the cursor (requires LSP). Use `gD` to go to declaration instead of definition.

#### Example

```vim
gd  " go to definition
gD  " go to declaration
```
***
# Title: Jump list navigation
# Category: Movement
# Tags: jump, list, navigation
---
Use `Ctrl+o` to go back to previous location and `Ctrl+i` to go forward in the jump list. Use `:jumps` to see the jump list.

#### Example

```vim
Ctrl+o  " previous location
Ctrl+i  " next location
:jumps  " show jump list
```
***
# Title: Change list navigation
# Category: Movement
# Tags: change, list, edit
---
Use `g;` to go to previous change location and `g,` to go to next change location. Use `:changes` to see the change list.

#### Example

```vim
g;       " previous change
g,       " next change
:changes " show change list
```
***
# Title: Middle of screen
# Category: Movement
# Tags: middle, screen, position
---
Use `M` to move cursor to the middle line of the screen.

#### Example

```vim
M  " move to middle of screen
```
***
# Title: Paragraph movement
# Category: Movement
# Tags: paragraph, navigation, text
---
Use `{` to move to the beginning of current paragraph and `}` to move to the beginning of next paragraph.

#### Example

```vim
{  " previous paragraph
}  " next paragraph
```
***
# Title: Sentence movement
# Category: Movement
# Tags: sentence, navigation, text
---
Use `(` to move to the beginning of current sentence and `)` to move to the beginning of next sentence.

#### Example

```vim
(  " previous sentence
)  " next sentence
```
***
# Title: Word movement alternatives
# Category: Movement
# Tags: word, WORD, movement, whitespace
---
Use `W` to jump to start of next WORD, `E` to jump to end of current WORD, and `B` to jump to start of previous WORD (WORD means whitespace-separated).

#### Example

```vim
W  " next WORD (whitespace-separated)
E  " end of WORD
B  " previous WORD
```
***
# Title: Alternative movement keys
# Category: Movement
# Tags: alternative, movement, keys
---
Use `Ctrl+h` (same as `h`), `Ctrl+j` (same as `j`), `Ctrl+k` (same as `k`), `Ctrl+n` (same as `j`), `Ctrl+p` (same as `k`) as alternative movement keys.

#### Example

```vim
Ctrl+h  " same as h (left)
Ctrl+j  " same as j (down)  
Ctrl+k  " same as k (up)
Ctrl+n  " same as j (down)
Ctrl+p  " same as k (up)
```
***
# Title: Line number movement
# Category: Movement
# Tags: line, number, goto, absolute
---
Use `{number}gg` or `{number}G` to go to absolute line number, where `{number}` is the line you want to jump to.

#### Example

```vim
42gg  " go to line 42
100G  " go to line 100
1G    " go to first line (same as gg)
```
***
# Title: Suspend and background
# Category: Movement
# Tags: suspend, background, shell
---
Use `Ctrl+z` to suspend Neovim and return to shell (terminal). You can do whatever you want in the hsell. Use `jobs` in shell to list suspended jobs. The list contains rows formatted like the following one:

```
[5]  + suspended  nvim playground
```

The number in square brackets is the number of the job that can be resumed. Just use `fg #` (in the shell) followed by job number to resume the job:

#### Example

```vim
Ctrl+z  " suspend to shell
jobs    " list suspended jobs
fg #5   " resume job #5
```
***
# Title: Page scrolling with cursor positioning
# Category: Movement
# Tags: scroll, page, cursor, position
---
Use `Ctrl+f` to scroll forward full page, `Ctrl+b` backward full page, `Ctrl+d` down half page, `Ctrl+u` up half page, `Ctrl+e` scroll up (cursor stays), `Ctrl+y` scroll down (cursor stays).

#### Example

```vim
Ctrl+f  " page forward
Ctrl+b  " page backward  
Ctrl+d  " half page down
Ctrl+u  " half page up
Ctrl+e  " scroll up (cursor stays)
Ctrl+y  " scroll down (cursor stays)
```
***
# Title: Z-commands - redraw with cursor positioning
# Category: Movement
# Tags: redraw, cursor, position, screen
---
Use `z<Enter>` to redraw with cursor at top (first non-blank), `z.` for center, `z-` for bottom.

#### Example

```vim
z<Enter>  " redraw, cursor line at top (first non-blank)
z.        " redraw, cursor line at center (first non-blank)  
z-        " redraw, cursor line at bottom (first non-blank)
```
***
# Title: Z-commands - horizontal scrolling
# Category: Movement
# Tags: scroll, horizontal, wrap, screen
---
Use `zh`/`zl` to scroll left/right by character, `zH`/`zL` for half-screen, `zs`/`ze` to position cursor at start/end.

#### Example

```vim
zh  " scroll right (when wrap is off)
zl  " scroll left (when wrap is off)
zH  " scroll right half-screenwidth
zL  " scroll left half-screenwidth
zs  " scroll cursor to start of screen
ze  " scroll cursor to end of screen
```
***
# Title: Z-commands - window height adjustment
# Category: Movement
# Tags: window, height, resize, redraw
---
Use `z{height}<Enter>` to set window height and redraw, `z+` for line below window, `z^` for line above.

#### Example

```vim
z20<Enter>  " make window 20 lines high
z+          " cursor to line below window
z^          " cursor to line above window
```
***
# Title: Jump multiple lines with arrow keys
# Category: Movement
# Tags: jump, lines, arrows, count
---
Use number + arrow keys to jump multiple lines quickly. More intuitive than `j`/`k` for some users.

#### Example

```vim
5↑    " jump 5 lines up
5↓    " jump 5 lines down
10↑   " jump 10 lines up
3→    " move 3 characters right
```
***
