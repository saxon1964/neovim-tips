Multiple cursors simulation
# Title: Multiple cursors simulation
# Category: Neovim Features
# Tags: cursor, multiple, editing
---
Use `cgn` after searching to change next match, then press `.` to repeat on subsequent matches.

#### Example

```vim
/word   " search for 'word'
cgn     " change next match
.       " repeat change on next match
```
===

Tree-sitter text objects
# Title: Tree-sitter text objects
# Category: Neovim Features
# Tags: treesitter, textobject, modern
---
Use `vaf` to select around function, `vif` for inside function, `vac` for around class (requires treesitter text objects).

#### Example

```vim
vaf  " select around function
vif  " select inside function
vac  " select around class
```
===

LSP hover info
# Title: LSP hover info
# Category: Neovim Features
# Tags: lsp, hover, documentation
---
Use `K` in normal mode to show hover documentation when LSP is active. Press `K` again to enter the hover window.

#### Example

```vim
K  " show hover documentation
```
===

Quick fix navigation
# Title: Quick fix navigation
# Category: Neovim Features
# Tags: quickfix, navigation, errors
---
Use `:cn` to go to next error/item in quickfix list, `:cp` for previous, `:copen` to open quickfix window.

#### Example

```vim
:cn     " next quickfix item
:cp     " previous quickfix item
:copen  " open quickfix window
```
===

Built-in terminal
# Title: Built-in terminal
# Category: Neovim Features
# Tags: terminal, integrated, modern
---
Use `:term` to open terminal, `Ctrl+\` followed by `Ctrl+n` to exit terminal mode to normal mode.

#### Example

```vim
:term           " open terminal
Ctrl+\ Ctrl+n   " exit terminal mode
```
===

Window splitting shortcuts
# Title: Window splitting shortcuts
# Category: Neovim Features
# Tags: window, split, navigation
---
Use `Ctrl+w s` for horizontal split, `Ctrl+w v` for vertical split, `Ctrl+w w` to cycle windows.

#### Example

```vim
Ctrl+w s  " horizontal split
Ctrl+w v  " vertical split
Ctrl+w w  " cycle windows
```
===
