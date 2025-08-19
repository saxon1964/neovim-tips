# Title: Toggle fold
# Category: Folding
# Tags: fold, toggle, code
---
Use `za` to toggle fold under cursor open/closed.

#### Example

```vim
za  " toggle fold under cursor
```
===
# Title: Open and close folds
# Category: Folding
# Tags: fold, open, close
---
Use `zo` to open fold under cursor and `zc` to close fold under cursor.

#### Example

```vim
zo  " open fold
zc  " close fold
```
===
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
===
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
===
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
===
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
===
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
===
# Title: Fold navigation shortcuts
# Category: Folding
# Tags: fold, navigation, movement, shortcuts
---
Navigate efficiently between folds using specialized movement commands.

#### Example

```vim
zj              " move to start of next fold
zk              " move to end of previous fold
[z              " move to start of current open fold
]z              " move to end of current open fold
```
===
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
===
# Title: Z-commands - recursive fold operations
# Category: Folding
# Tags: fold, recursive, nested
---
Use `zA` to toggle fold recursively, `zO` to open all nested folds, `zC` to close all nested folds.

#### Example

```vim
zA  " toggle fold and all nested folds
zO  " open fold recursively (all levels)
zC  " close fold recursively (all levels)
```
===
# Title: Z-commands - fold deletion
# Category: Folding
# Tags: fold, delete, remove
---
Use `zd` to delete fold under cursor, `zD` to delete fold recursively, `zE` to eliminate all folds.

#### Example

```vim
zd  " delete fold under cursor
zD  " delete fold recursively 
zE  " eliminate all folds in buffer
```
===
# Title: Z-commands - fold navigation
# Category: Folding
# Tags: fold, navigation, movement
---
Use `zj` to move to start of next fold and `zk` to move to end of previous fold.

#### Example

```vim
zj  " jump to start of next fold
zk  " jump to end of previous fold
```
===
# Title: Z-commands - fold enable/disable
# Category: Folding
# Tags: fold, enable, disable, toggle
---
Use `zi` to toggle folding on/off, `zn` to disable folding, `zN` to enable folding.

#### Example

```vim
zi  " toggle folding enabled/disabled
zn  " disable folding
zN  " enable folding
```
===
# Title: Z-commands - fold view and level
# Category: Folding
# Tags: fold, view, level, cursor
---
Use `zv` to open enough folds to view cursor line, `zx` to re-apply foldlevel and update view.

#### Example

```vim
zv  " open folds to view cursor line
zx  " re-apply foldlevel and update
```
===
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
===