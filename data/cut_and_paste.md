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