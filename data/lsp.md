# Title: LSP implementation
# Category: LSP
# Tags: lsp, implementation, goto
---
Use `gi` to jump to implementation of symbol under cursor.

```vim
gi  " jump to implementation
```
***
# Title: LSP rename
# Category: LSP
# Tags: lsp, rename, refactor
---
Use `:lua vim.lsp.buf.rename()` to rename symbol under cursor across the project.

```vim
:lua vim.lsp.buf.rename()
```
***
# Title: LSP show signature help
# Category: LSP
# Tags: lsp, signature, parameters, help
---
Use `:lua vim.lsp.buf.signature_help()` to show function signature help.

```vim
:lua vim.lsp.buf.signature_help()
```
***
# Title: LSP code actions
# Category: LSP
# Tags: lsp, actions, refactor, fix
---
Use `:lua vim.lsp.buf.code_action()` to show available code actions.

```vim
:lua vim.lsp.buf.code_action()
```
***
# Title: LSP format document
# Category: LSP
# Tags: lsp, format, style, beautify
---
Use `:lua vim.lsp.buf.format()` to format current buffer using LSP.

```vim
:lua vim.lsp.buf.format()
```
***
# Title: LSP incoming calls
# Category: LSP
# Tags: lsp, calls, incoming, hierarchy
---
Use `:lua vim.lsp.buf.incoming_calls()` to show incoming call hierarchy.

```vim
:lua vim.lsp.buf.incoming_calls()
```
***
# Title: LSP remove workspace folder
# Category: LSP
# Tags: lsp, workspace, folder, remove
---
Use `:lua vim.lsp.buf.remove_workspace_folder()` to remove folder from workspace.

```vim
:lua vim.lsp.buf.remove_workspace_folder()
```
***
# Title: LSP list workspace folders
# Category: LSP
# Tags: lsp, workspace, folder, list
---
Use `:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))` to list workspace folders.

```vim
:lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
```
***
# Title: Toggle LSP inlay hints
# Category: LSP
# Tags: lsp, inlay-hints, toggle, display, parameters
---
Toggle inlay hints to show/hide parameter names, type annotations, and other inline information provided by LSP.

```lua
-- Toggle inlay hints on/off:
vim.keymap.set('n', '<leader>th', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })

-- Enable inlay hints by default for buffer with LSP:
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
```

```vim
" Check if inlay hints are available:
:lua print(vim.lsp.inlay_hint.is_enabled())
```
***