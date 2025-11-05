# Title: Silent and no-remap mappings
# Category: Key Mappings
# Tags: noremap, silent, mapping, recursive
---
Use `noremap` and `<silent>` modifiers to create safe, non-recursive mappings that don't echo commands.

```vim
:nnoremap <silent> <leader>w :w<CR>
:inoremap jk <Esc>
" noremap prevents recursive mapping, silent suppresses command echo
" Use noremap by default to avoid unexpected behavior
```

Or:

```lua
vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>')
```
***
# Title: Buffer-local and mode-specific mappings
# Category: Key Mappings
# Tags: buffer, local, mode, specific
---
Use `<buffer>` for buffer-local mappings and different mode prefixes for mode-specific key bindings.

```vim
:nnoremap <buffer> <F5> :!python %<CR>
:vnoremap <leader>s :sort<CR>
:inoremap <C-l> <Right>
:cnoremap <C-a> <Home>
" Buffer-local mappings only affect current buffer
```

Or:

```lua
vim.keymap.set('n', '<F5>', '<Cmd>python %<CR>', { buffer = true })
vim.keymap.set('v', '<leader>s', '<Cmd>sortCR>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('c', '<C-a>', '<Home>')
```
***
# Title: Leader key mappings
# Category: Key Mappings
# Tags: leader, mapleader, prefix, namespace
---
Use `mapleader` to create a personal namespace for custom mappings, avoiding conflicts with default keys.

```vim
:let mapleader = " "           " space as leader
:nnoremap <leader>f :find<Space>
:nnoremap <leader>b :buffer<Space>
:nnoremap <leader>w :write<CR>
" Creates ,f ,b ,w mappings (if comma is leader)
```

Or:

```lua
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>f', '<Cmd>find<Space>')
vim.keymap.set('n', '<leader>b', '<Cmd>buffer<Space>')
vim.keymap.set('n', '<leader>w', '<Cmd>write<Space>')
```
***
# Title: Expression mappings
# Category: Key Mappings  
# Tags: expr, expression, mapping, dynamic
---
Use `<expr>` mappings to create dynamic key behaviors that evaluate expressions.

```vim
:inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
:nnoremap <expr> n 'Nn'[v:searchforward]
" Tab for completion navigation, Enter to accept
```

Or:

```lua
vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })
vim.keymap.set('i', '<CR>', function()
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true })
vim.keymap.set('n', 'n', function()
    return vim.v.searchforward == 1 and 'n' or 'N'
end, { expr = true })
```
***
# Title: Script-local mappings
# Category: Key Mappings
# Tags: script, local, SID, unique
---
Use `<SID>` (Script ID) to create mappings that call script-local functions, avoiding global namespace pollution.

```vim
:nnoremap <silent> <F5> :call <SID>CompileAndRun()<CR>
function! s:CompileAndRun()
    " Script-local function
    execute '!gcc % -o %:r && ./%:r'
endfunction
" <SID> ensures function is only accessible from this script
```

Or:

```lua
local function compile_and_run()
    vim.cmd('!ggc % -o %:r && ./%:r')
end

vim.keymap.set('n', '<F5>', compile_and_run, { silent = true })
```

***
# Title: Special key notation
# Category: Key Mappings
# Tags: special, keys, notation, modifiers
---
Use special key notation like `<C-key>`, `<M-key>`, `<S-key>` for modifier combinations and special keys.

```vim
:nnoremap <C-j> <C-w>j        " Ctrl+j to move down
:nnoremap <M-h> :tabprev<CR>  " Alt+h for previous tab
:nnoremap <S-Tab> :bprev<CR>  " Shift+Tab for previous buffer
:nnoremap <F12> :set invnumber<CR>  " F12 to toggle line numbers
```

Or:

```lua
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<M-h>', '<Cmd>tabprev<CR>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprev<CR>')
vim.keymap.set('n', '<F12>', '<Cmd>set invnumber<CR>')
```
***
# Title: Mapping timeouts
# Category: Key Mappings
# Tags: timeout, ttimeout, delay, response
---
Use timeout settings to control how long vim waits for key sequence completion in mappings.

```vim
:set timeoutlen=500    " wait 500ms for mapped sequence
:set ttimeoutlen=50    " wait 50ms for key code sequence
" Affects leader key combinations and escape sequences
" Lower ttimeoutlen for faster escape in terminal
```

Or:

```lua
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 50
```
***
# Title: Abbreviations vs mappings
# Category: Key Mappings
# Tags: abbreviation, iabbrev, expand, text
---
Use abbreviations for text expansion that only triggers after whitespace, unlike mappings which are immediate.

```vim
:iabbrev teh the
:iabbrev @@ your.email@domain.com
:iabbrev dts <C-r>=strftime('%Y-%m-%d')<CR>
" Abbreviations expand after whitespace/punctuation
" Mappings activate immediately when typed
```

Or:

```lua
vim.keymap.set('ia', 'teh', 'the')
vim.keymap.set('ia', '@@', 'your.email@domain.com')
vim.keymap.set('ia', 'dts', function() 
    return os.date('%Y-%m-%d')
end, { expr = true })
```
***
# Title: Mapping special characters
# Category: Key Mappings
# Tags: special, characters, escape, literal
---
Use proper escaping and notation for mapping special characters like quotes, backslashes, and pipes.

```vim
:nnoremap <leader>" ciw"<C-r>""<Esc>
:nnoremap <leader>' ciw'<C-r>"'<Esc>
:nnoremap <leader>\ :nohlsearch<CR>
" Surround word with quotes, backslash to clear search
```

Or:

```lua
vim.keymap.set('n', '<leader>"', 'ciw"<C-r>""<Esc>')
vim.keymap.set('n', "<leader>'", "ciw'<C-r>\"'<Esc>")
vim.keymap.set('n', '<leader>\\', '<Cmd>nohlsearch<CR>')
```
***
# Title: Conditional mappings
# Category: Key Mappings
# Tags: conditional, exists, hasmapto, check
---
Use `exists()` and `hasmapto()` to create conditional mappings that don't override existing ones.

```vim
if !hasmapto(':make<CR>')
    nnoremap <F5> :make<CR>
endif
if exists(':Gdiff')
    nnoremap <leader>gd :Gdiff<CR>
endif
" Only create mapping if it doesn't exist or command is available
```

Or:

```lua
if vim.fn.mapcheck('<F5>', 'n') == '' then
    vim.keymap.set('n', '<F5>', '<Cmd>make<CR>')
end

if vim.fn.exists(':Gdiff') == 2 then
    vim.keymap.set('n', '<leader>gd', '<Cmd>Gdiff<CR>')
end
```
***
# Title: Recursive abbreviations
# Category: Key Mappings
# Tags: abbreviation, recursive, noreabbrev, expand
---
Use `noreabbrev` to prevent recursive abbreviation expansion, similar to noremap for mappings.

```vim
:abbreviate W w
:noreabbrev Wq wq
:abbreviate Q q
" 'W' expands to 'w', but 'Wq' won't recursively expand the 'W' part
```

Or:

```lua
vim.keymap.set('ca', 'W', 'w')
vim.keymap.set('ca', 'Wq', 'wq')
vim.keymap.set('ca', 'Q', 'q')
```

***
# Title: Visual mode mappings
# Category: Key Mappings
# Tags: visual, vnoremap, selection, range
---
Use visual mode mappings to operate on selections with custom key combinations.

```vim
:vnoremap <leader>s :sort<CR>
:vnoremap <leader>u :!uniq<CR>
:vnoremap * y/\V<C-r>"<CR>
:vnoremap # y?\V<C-r>"<CR>
" Sort selection, remove duplicates, search for selection
```

Or:

```lua
vim.keymap.set('v', '<leader>s', '<Cmd>sort<CR>')
vim.keymap.set('v', '<leader>u', '<Cmd>!uniq<CR>')
vim.keymap.set('v', '*', 'y/\\V<C-r>"<CR>')
vim.keymap.set('v', '#', 'y?\\V<C-r>"<CR>')
```
***
# Title: Command-line mappings
# Category: Key Mappings
# Tags: cnoremap, command, line, navigation
---
Use command-line mode mappings to improve command-line editing with familiar key bindings.

```vim
:cnoremap <C-a> <Home>
:cnoremap <C-e> <End>
:cnoremap <C-b> <Left>
:cnoremap <C-f> <Right>
:cnoremap <C-d> <Delete>
" Emacs-style command line navigation
```

Or:

```lua
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-d>', '<Delete>')
```
***
# Title: Plug mappings
# Category: Key Mappings
# Tags: plug, scriptname, unique, naming
---
Use `<Plug>` prefix to create unique mapping names that users can map to their preferred keys.

```vim
:nnoremap <Plug>MyPluginFunction :call MyFunction()<CR>
:nmap <F5> <Plug>MyPluginFunction
" Plugin provides <Plug> mapping, user maps it to preferred key
" Prevents conflicts and allows customization
```

Or:

```lua
vim.keymap.set('n', '<Plug>MyPluginFunction', '<Cmd>call MyFunction()<CR>')
vim.keymap.set('n', '<F5>', '<Plug>MyPluginFunction')
```
***
# Title: Operator-pending mappings
# Category: Key Mappings
# Tags: onoremap, operator, pending, motion
---
Use operator-pending mappings to create custom text objects and motions.

```vim
:onoremap in( :<C-u>normal! f(vi(<CR>
:onoremap an( :<C-u>normal! f(va(<CR>
:onoremap in{ :<C-u>normal! f{vi{<CR>
" Creates 'in(' and 'an(' text objects
" Now you can use din( to delete inside next parentheses
```

Or:

```lua
vim.keymap.set('o', 'in(', '<Cmd><C-u>normal! f(vi(<CR>')
vim.keymap.set('o', 'an(', '<Cmd><C-u>normal! f(va(<CR>')
vim.keymap.set('o', 'in{', '<Cmd><C-u>normal! f{va{<CR>')
```
***
# Title: Terminal mode mappings
# Category: Key Mappings
# Tags: tnoremap, terminal, mode, escape
---
Use terminal mode mappings to control built-in terminal behavior and key bindings.

```vim
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-w>h <C-\><C-n><C-w>h
:tnoremap <C-w>j <C-\><C-n><C-w>j
:tnoremap <C-w>k <C-\><C-n><C-w>k
:tnoremap <C-w>l <C-\><C-n><C-w>l
" Escape to exit terminal mode, window navigation
```

Or:

```lua
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')
```
***
# Title: Multiple key mappings
# Category: Key Mappings
# Tags: multiple, keys, sequence, chain
---
Create mappings that respond to multiple key sequences or provide alternative bindings.

```vim
:nnoremap <leader>fs :w<CR>
:nnoremap <leader>ff :find<Space>
:nnoremap <leader>fb :buffer<Space>
:nnoremap <C-s> :w<CR>
:inoremap <C-s> <Esc>:w<CR>a
" Multiple ways to save: <leader>fs and <C-s>
```

Or:

```lua
vim.keymap.set('n', '<leader>fs', '<Cmd>w<CR>')
vim.keymap.set('n', '<leader>ff', '<Cmd>find<Space>')
vim.keymap.set('n', '<leader>fb', '<Cmd>buffer<Space>')
vim.keymap.set('n', '<C-s>', '<Cmd>w<Space>')
vim.keymap.set('i', '<C-s>', '<Esc><Cmd>w<CR>a')
```
***
# Title: Mapping with arguments
# Category: Key Mappings
# Tags: arguments, parameters, count, range
---
Use `<count>` and ranges in mappings to create flexible key bindings that accept numeric arguments.

```vim
:nnoremap <silent> <leader>d :<C-u>call DeleteLines(v:count1)<CR>
function! DeleteLines(count)
    execute 'normal! ' . a:count . 'dd'
endfunction
" 3<leader>d deletes 3 lines
```

Or:

```lua
local function delete_lines(count)
    vim.cmd('normal! ' .. count .. 'dd')
end

vim.keymap.set('n', '<leader>d' function() 
    delete_lines(vim.v.count1)
end)

-- Or even like this
vim.keymap.set('n', '<leader>d' function() 
    vim.cmd('normal! ' .. vim.v.count1 .. 'dd')
end, { silent = true })
```
***
# Title: Auto-pair mappings
# Category: Key Mappings
# Tags: autopair, brackets, quotes, matching
---
Create smart bracket and quote auto-pairing with conditional mappings.

```vim
:inoremap <expr> ( getline('.')[col('.')-2] =~ '\w' ? '(' : '()<Left>'
:inoremap <expr> { getline('.')[col('.')-2] =~ '\w' ? '{' : '{}<Left>'
:inoremap <expr> [ '[]<Left>'
:inoremap <expr> " '""<Left>'
" Smart auto-pairing that considers context
```

Or:

```lua
vim.keymap.set('i', '(', function()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')
  local char = line:sub(col - 1, col - 1)
  
  if char:match('%w') then
    return '('
  else
    return '()<Left>'
  end
end, { expr = true })

vim.keymap.set('i', '{', function()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')
  local char = line:sub(col - 1, col - 1)
  
  if char:match('%w') then
    return '{'
  else
    return '{}<Left>'
  end
end, { expr = true })

vim.keymap.set('i', '[', '[]<Left>', { expr = true })
vim.keymap.set('i', '"', '""<Left>', { expr = true })
```

***
# Title: Escape key alternatives
# Category: Key Mappings
# Tags: escape, alternative, jk, kj
---
Map common key combinations to escape key for faster mode switching without reaching for Esc.

```vim
:inoremap jk <Esc>
:inoremap kj <Esc>
:inoremap jj <Esc>
:vnoremap v <Esc>
" Popular alternatives: jk, kj, jj, or double-tap current mode key
```

Or:

```lua
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('v', 'v', '<Esc>')
```
***
# Title: Context-aware mappings
# Category: Key Mappings
# Tags: context, aware, conditional, filetype
---
Create mappings that behave differently based on file type, mode, or cursor context.

```vim
:autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>
:autocmd FileType javascript nnoremap <buffer> <F5> :!node %<CR>
:autocmd FileType sh nnoremap <buffer> <F5> :!bash %<CR>
" Same key, different behavior per file type
```

Or:

```lua
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.keymap.set('n', '<F5>', '<Cmd>python %<CR>', { buffer = true })
    end
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    callback = function()
        vim.keymap.set('n', '<F5>', '<Cmd>node %<CR>', { buffer = true })
    end
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sh',
    callback = function()
        vim.keymap.set('n', '<F5>', '<Cmd>bash %<CR>', { buffer = true })
    end
})
```
***
# Title: Buffer-local keymaps with Lua
# Category: Key Mappings
# Tags: lua, buffer, local, keymap, nvim_buf_set_keymap
---
Create buffer-specific keymaps in Lua that only apply to the current buffer without affecting global mappings.

```lua
-- Set keymap for current buffer (buffer 0):
vim.keymap.set('n', '<leader>r', ':!python %<CR>', {
  buffer = 0,
  desc = 'Run current file'
})

-- In autocommand for specific filetype:
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function(args)
    vim.keymap.set('n', '<leader>x', ':source %<CR>', {
      buffer = args.buf,
      desc = 'Source Lua file'
    })
  end,
})

-- In LspAttach autocommand:
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})
```
***
