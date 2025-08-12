Toggle fold
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

Open and close folds
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

Open and close all folds
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

Create fold from selection
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

Fold levels
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
