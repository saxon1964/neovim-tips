# Title: LSP implementation
# Category: LSP
# Tags: lsp, implementation, goto
---
Use `gi` to jump to implementation of symbol under cursor.

#### Example

```vim
gi  " jump to implementation
```
***
# Title: LSP rename
# Category: LSP
# Tags: lsp, rename, refactor
---
Use `:lua vim.lsp.buf.rename()` to rename symbol under cursor across the project.

#### Example

```vim
:lua vim.lsp.buf.rename()
```
***
# Title: LSP show signature help
# Category: LSP
# Tags: lsp, signature, parameters, help
---
Use `:lua vim.lsp.buf.signature_help()` to show function signature help.

#### Example

```vim
:lua vim.lsp.buf.signature_help()
```
***
# Title: LSP code actions
# Category: LSP
# Tags: lsp, actions, refactor, fix
---
Use `:lua vim.lsp.buf.code_action()` to show available code actions.

#### Example

```vim
:lua vim.lsp.buf.code_action()
```
***
# Title: LSP format document
# Category: LSP
# Tags: lsp, format, style, beautify
---
Use `:lua vim.lsp.buf.format()` to format current buffer using LSP.

#### Example

```vim
:lua vim.lsp.buf.format()
```
***
# Title: LSP incoming calls
# Category: LSP
# Tags: lsp, calls, incoming, hierarchy
---
Use `:lua vim.lsp.buf.incoming_calls()` to show incoming call hierarchy.

#### Example

```vim
:lua vim.lsp.buf.incoming_calls()
```
***
# Title: LSP remove workspace folder
# Category: LSP
# Tags: lsp, workspace, folder, remove
---
Use `:lua vim.lsp.buf.remove_workspace_folder()` to remove folder from workspace.

#### Example

```vim
:lua vim.lsp.buf.remove_workspace_folder()
```
***
# Title: LSP list workspace folders
# Category: LSP
# Tags: lsp, workspace, folder, list
---
Use `:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))` to list workspace folders.

#### Example

```vim
:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
```
***