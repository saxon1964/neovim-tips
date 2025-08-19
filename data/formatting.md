# Title: Format with Treesitter
# Category: Formatting
# Tags: treesitter, format, syntax
---
Use `=ap` to format syntax-aware regions using Treesitter (when available).

#### Example

```vim
=ap  " format around paragraph with Treesitter
```
===
# Title: Automatic paragraph formatting
# Category: Formatting
# Tags: paragraph, textwidth, reflow
---
Automatically format paragraphs to specified width using textwidth and format commands.

#### Example

```vim
:set textwidth=60      " set line width to 60 characters
:set fo=aw2tq          " format options for auto-formatting
gqip                   " reformat inner paragraph
```
===
# Title: Generate increasing numbers
# Category: Formatting
# Tags: numbers, increment, column, sequence
---
Generate a column of increasing numbers using visual block mode and increment commands.

#### Example

```vim
" Select column with Ctrl-v, then:
:I                     " replace selection with incremental numbers
:I 5                   " increment by 5
:II                    " increment with left padding
```
===
# Title: Comment lines by filetype
# Category: Formatting
# Tags: comment, filetype, toggle
---
Automatically comment/uncomment lines based on current file type.

#### Example

```vim
function CommentIt()
  if &filetype == "vim"
    vmap +# :s/^/"/<CR>
    vmap -# :s/^"//<CR>
  elseif &filetype == "python"
    vmap +# :s/^/#/<CR>
    vmap -# :s/^#//<CR>
  endif
endfunction
autocmd BufEnter * call CommentIt()
```
===