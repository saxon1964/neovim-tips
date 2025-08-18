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

LSP go to definition
# Title: LSP go to definition
# Category: LSP
# Tags: lsp, definition, goto, navigation
---
Use `gd` to jump to definition of symbol under cursor.

#### Example

```vim
gd  " go to definition
```
===

LSP go to declaration
# Title: LSP go to declaration
# Category: LSP
# Tags: lsp, declaration, goto, navigation
---
Use `gD` to jump to declaration of symbol under cursor.

#### Example

```vim
gD  " go to declaration
```
===

LSP show hover information
# Title: LSP show hover information
# Category: LSP
# Tags: lsp, hover, documentation, help
---
Use `K` to show hover information for symbol under cursor.

#### Example

```vim
K  " show hover info
```
===

LSP show signature help
# Title: LSP show signature help
# Category: LSP
# Tags: lsp, signature, parameters, help
---
Use `:lua vim.lsp.buf.signature_help()` to show function signature help.

#### Example

```vim
:lua vim.lsp.buf.signature_help()
```
===

LSP find references
# Title: LSP find references
# Category: LSP
# Tags: lsp, references, search, usage
---
Use `gr` to find all references of symbol under cursor.

#### Example

```vim
gr  " find references
```
===

LSP workspace symbols
# Title: LSP workspace symbols
# Category: LSP
# Tags: lsp, symbols, workspace, search
---
Use `:lua vim.lsp.buf.workspace_symbol()` to search workspace symbols.

#### Example

```vim
:lua vim.lsp.buf.workspace_symbol()
```
===

LSP document symbols
# Title: LSP document symbols
# Category: LSP
# Tags: lsp, symbols, document, outline
---
Use `:lua vim.lsp.buf.document_symbol()` to show document symbols.

#### Example

```vim
:lua vim.lsp.buf.document_symbol()
```
===

LSP code actions
# Title: LSP code actions
# Category: LSP
# Tags: lsp, actions, refactor, fix
---
Use `:lua vim.lsp.buf.code_action()` to show available code actions.

#### Example

```vim
:lua vim.lsp.buf.code_action()
```
===

LSP format document
# Title: LSP format document
# Category: LSP
# Tags: lsp, format, style, beautify
---
Use `:lua vim.lsp.buf.format()` to format current buffer using LSP.

#### Example

```vim
:lua vim.lsp.buf.format()
```
===

LSP diagnostic navigation
# Title: LSP diagnostic navigation
# Category: LSP
# Tags: lsp, diagnostics, navigation, errors
---
Use `]d` to go to next diagnostic and `[d` to go to previous diagnostic.

#### Example

```vim
]d  " next diagnostic
[d  " previous diagnostic
```
===

LSP diagnostic list
# Title: LSP diagnostic list
# Category: LSP
# Tags: lsp, diagnostics, list, quickfix
---
Use `:lua vim.diagnostic.setqflist()` to populate quickfix list with diagnostics.

#### Example

```vim
:lua vim.diagnostic.setqflist()
```
===

LSP type definition
# Title: LSP type definition
# Category: LSP
# Tags: lsp, type, definition, goto
---
Use `:lua vim.lsp.buf.type_definition()` to jump to type definition.

#### Example

```vim
:lua vim.lsp.buf.type_definition()
```
===

LSP incoming calls
# Title: LSP incoming calls
# Category: LSP
# Tags: lsp, calls, incoming, hierarchy
---
Use `:lua vim.lsp.buf.incoming_calls()` to show incoming call hierarchy.

#### Example

```vim
:lua vim.lsp.buf.incoming_calls()
```
===

LSP outgoing calls
# Title: LSP outgoing calls
# Category: LSP
# Tags: lsp, calls, outgoing, hierarchy
---
Use `:lua vim.lsp.buf.outgoing_calls()` to show outgoing call hierarchy.

#### Example

```vim
:lua vim.lsp.buf.outgoing_calls()
```
===

LSP add workspace folder
# Title: LSP add workspace folder
# Category: LSP
# Tags: lsp, workspace, folder, add
---
Use `:lua vim.lsp.buf.add_workspace_folder()` to add folder to workspace.

#### Example

```vim
:lua vim.lsp.buf.add_workspace_folder()
```
===

LSP remove workspace folder
# Title: LSP remove workspace folder
# Category: LSP
# Tags: lsp, workspace, folder, remove
---
Use `:lua vim.lsp.buf.remove_workspace_folder()` to remove folder from workspace.

#### Example

```vim
:lua vim.lsp.buf.remove_workspace_folder()
```
===

LSP list workspace folders
# Title: LSP list workspace folders
# Category: LSP
# Tags: lsp, workspace, folder, list
---
Use `:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))` to list workspace folders.

#### Example

```vim
:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
```
===
