# Title: Toggle fold
# Category: Folding
# Tags: fold, toggle, code
---
Use `za` to toggle fold under cursor open/closed.

#### Example

```vim
za  " toggle fold under cursor
```
***
# Title: Open and close all folds
# Category: Folding
# Tags: fold, all, global
---
Use `zR` to open all folds in buffer and `zM` to close all folds in buffer.

#### Example

```vim
zR  " open all folds
zM  " close all folds
```
***
# Title: Create fold from selection
# Category: Folding
# Tags: fold, create, selection
---
Use `zf` to create a fold from visual selection or with motion (e.g., `zf5j` to fold 5 lines down).

#### Example

```vim
zf5j  " create fold 5 lines down
zf    " create fold from visual selection
```
***
# Title: Fold levels
# Category: Folding
# Tags: fold, level, depth
---
Use `zm` to increase fold level (close more folds) and `zr` to reduce fold level (open more folds).

#### Example

```vim
zm  " increase fold level
zr  " reduce fold level
```
***
# Title: Fold by indentation
# Category: Folding
# Tags: fold, indent, automatic, method
---
Automatically fold code based on indentation levels using foldmethod=indent.

#### Example

```vim
set foldmethod=indent   " fold based on indentation
set foldlevelstart=1    " start with some folds open
set foldnestmax=3       " limit nested fold depth
```
***
# Title: Syntax-based folding
# Category: Folding
# Tags: fold, syntax, automatic, language
---
Use syntax-aware folding for programming languages that support fold markers in syntax files.

#### Example

```vim
set foldmethod=syntax   " fold based on file syntax
set foldlevel=2         " set initial fold level
```
***
# Title: Keep folds when inserting
# Category: Folding
# Tags: fold, insert, preserve, maintain
---
Configure Vim to maintain fold state when entering insert mode.

#### Example

```vim
" Prevent folds from opening when inserting
set foldopen-=insert

" Mapping to toggle fold with F9
nnoremap <F9> za
vnoremap <F9> zf
```
***
# Title: Z-commands - create folds
# Category: Folding
# Tags: fold, create, lines
---
Use `zF` to create fold for N lines or `zf{motion}` to create fold with motion.

#### Example

```vim
5zF   " create fold for 5 lines
zf3j  " create fold from cursor down 3 lines
zfip  " create fold for inner paragraph
```
***