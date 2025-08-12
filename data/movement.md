Basic cursor movement
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

Word movement
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

Line navigation
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

Document navigation
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

Screen scrolling
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

Center cursor on screen
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

Page movement
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

Jump to specific line
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

Character search on line
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

Repeat character search
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

Matching brackets
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

Screen position navigation
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
===
