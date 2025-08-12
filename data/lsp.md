LSP implementation
# Title: LSP implementation
# Category: LSP
# Tags: lsp, implementation, goto
---
Use `gi` to jump to implementation of symbol under cursor.

#### Example

```vim
gi  " jump to implementation
```
===

LSP rename
# Title: LSP rename
# Category: LSP
# Tags: lsp, rename, refactor
---
Use `:lua vim.lsp.buf.rename()` to rename symbol under cursor across the project.

#### Example

```vim
:lua vim.lsp.buf.rename()
```
===

Floating diagnostics
# Title: Floating diagnostics
# Category: LSP
# Tags: diagnostics, floating, popup
---
Use `vim.diagnostic.open_float()` to show diagnostics in a floating window.

#### Example

```vim
:lua vim.diagnostic.open_float()
```
===
