# Title: Format with Treesitter
# Category: Formatting
# Tags: treesitter, format, syntax
---
Use `=ap` to format syntax-aware regions using Treesitter (when available).

#### Example

```vim
=ap  " format around paragraph with Treesitter
```
***
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
***
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
***
# Title: Automatic text width formatting
# Category: Formatting
# Tags: text, width, format, autowrap, textwidth
---
Use `:set textwidth=80` to automatically wrap lines at 80 characters while typing.

#### Example

```vim
:set textwidth=80   " wrap at 80 characters
:set textwidth=0    " disable automatic wrapping  
:set formatoptions+=t  " enable automatic text wrapping
gqap                " manually format current paragraph to textwidth
```
***