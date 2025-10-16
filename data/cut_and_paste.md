# Title: Cut/delete word
# Category: Cut and Paste
# Tags: cut, delete, word
---
Use `dw` to delete from cursor to start of next word, `de` to delete to end of current word, or `db` to delete to start of current word.

```vim
dw  " delete to next word
de  " delete to end of word
db  " delete to start of word
```
***
# Title: Yank line
# Category: Cut and Paste
# Tags: yank, copy, line
---
Use `yy` to yank (copy) the current line, or `{number}yy` to yank multiple lines.

```vim
yy   " yank current line
3yy  " yank 3 lines
```
***
# Title: Yank word
# Category: Cut and Paste
# Tags: yank, copy, word
---
Use `yw` to yank from cursor to start of next word, `ye` to yank to end of current word.

```vim
yw  " yank to next word
ye  " yank to end of word
```
***
# Title: Paste text
# Category: Cut and Paste
# Tags: paste, put, text
---
Use `p` to paste after cursor/line and `P` to paste before cursor/line.

```vim
p  " paste after
P  " paste before
```
***
# Title: Paste with automatic indentation
# Category: Cut and Paste
# Tags: paste, indent, automatic
---
Use `[p` and `[P` to paste and automatically adjust indentation to match current line.

```vim
[p  " paste after with auto-indent
[P  " paste before with auto-indent  
]p  " paste after with auto-indent
]P  " same as [P
```
***