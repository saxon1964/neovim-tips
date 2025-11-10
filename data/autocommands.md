# Title: Smart auto-save with update command
# Category: Autocommands
# Tags: autocmd, auto-save, update, silent, efficient
---
Use `silent! update` for efficient auto-save that only writes when buffer is modified and file has changed.

```lua
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  pattern = "*",
  command = "silent! update",
  desc = "Auto-save on leave/lost focus",
})
```
***
# Title: Auto-save on focus lost
# Category: Autocommands
# Tags: autocmd, FocusLost, auto-save, backup
---
Use `FocusLost` autocommand to automatically save all buffers when vim loses focus.

```vim
:autocmd FocusLost * :wa
" Auto-save all buffers when switching away from vim
```

Or:

```lua
vim.api.nvim_create_autocmd('FocusLost', {
    pattern = '*',
    command = 'wa'
    desc = 'Auto-save all buffers when switching away from vim'
})
```
***
# Title: Auto-reload changed files
# Category: Autocommands
# Tags: autocmd, checktime, FileChangedShellPost, reload
---
Use `FileChangedShellPost` and `checktime` to automatically reload files changed by external programs.

```vim
:set autoread
:autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
:autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
```

Or:

```lua
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CurtorHold', 'CursorHoldI'}, {
    pattern = '*',
    command = 'checktime'
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    pattern = '*',
    callback = function()
        vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
    end
})
```
***
# Title: Remove trailing whitespace on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, whitespace, cleanup
---
Use `BufWritePre` autocommand to automatically remove trailing whitespace before saving files.

```vim
:autocmd BufWritePre * :%s/\s\+$//e
" Remove trailing whitespace on all file saves
" 'e' flag prevents error if no matches found
```

Or:

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    command = [[%s/\s\+$//e]],
    desc = 'Remove trailing whitespace on all file saves'
})
```
***
# Title: Create directory on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, mkdir, directory
---
Use `BufWritePre` to automatically create parent directories when saving files to new paths.

```vim
:autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')
" Creates parent directories if they don't exist
" 'p' creates intermediate directories like mkdir -p
```

Or:

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function(args)
        local dir = vim.fn.fnamemodify(args.file, ':p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
    desc = 'Creates parent directories if they don\'t exist' 
})
```
***
# Title: Jump to last cursor position
# Category: Autocommands
# Tags: autocmd, BufReadPost, cursor, position
---
Use `BufReadPost` to automatically jump to the last known cursor position when reopening files.

```vim
:autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Jumps to last position if it exists and is valid
```

Or:

```lua
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end
})
```
***
# Title: Set file type based on content
# Category: Autocommands
# Tags: autocmd, BufRead, filetype, detection
---
Use `BufRead` autocommands to set file types based on file content or patterns not caught by default detection.

```vim
:autocmd BufRead,BufNewFile *.conf set filetype=conf
:autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy  
:autocmd BufRead * if getline(1) =~ '^#!/usr/bin/env python' | set ft=python | endif
```

Or:

```lua
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.conf',
    callback = function()
        vim.bo.filetype = 'conf'
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = 'Jenkinsfile',
    callback = function()
        vim.bo.filetype = 'groovy'
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead' }, {
    pattern = '*',
    callback = function()
        local firt_line = vim.fn.getline(1)

        if first_line:match('^#!/usr/bin/env python') then
            vim.bo.filetype = 'python'
        end
    end,
})
```
***
# Title: Auto-format code on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, format, lsp
---
Use `BufWritePre` with LSP or external formatters to automatically format code before saving.

```vim
:autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx lua vim.lsp.buf.format()
:autocmd BufWritePre *.py !black %
:autocmd BufWritePre *.go !gofmt -w %
" Format different file types with appropriate tools
```

Or:

```lua
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.js', '*.ts', '*.jsx', '*.tsx'},
    callback = function()
        vim.lsp.buf.format()
    end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = '*.py',
    callback = function()
        vim.cmd('!black %')
    end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = '*.go',
    callback = function()
        vim.cmd('!gofmt -w %')
    end,
})
```
***
# Title: Highlight long lines
# Category: Autocommands
# Tags: autocmd, ColorColumn, textwidth, highlight
---
Use autocommands to dynamically highlight long lines or set color column based on file type.

```vim
:autocmd FileType python setlocal colorcolumn=88
:autocmd FileType javascript,typescript setlocal colorcolumn=100
:autocmd FileType gitcommit setlocal colorcolumn=72
" Set different line length limits per file type
```

Or:

```lua
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'python',
    callback = function()
        vim.bo.colorcolumn = 88
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'javascript', 'typescript' },
    callback = function()
        vim.bo.colorcolumn = 100
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'gitcommit',
    callback = function()
        vim.bo.colorcolumn = 72 
    end,
})
```
***
# Title: Auto-compile on save
# Category: Autocommands
# Tags: autocmd, BufWritePost, compile, build
---
Use `BufWritePost` to automatically compile or build files after saving them.

```vim
:autocmd BufWritePost *.c,*.cpp !gcc % -o %:r
:autocmd BufWritePost *.tex !pdflatex %
:autocmd BufWritePost init.lua source %
" Compile C files, build LaTeX, reload Lua config
```

Or:

```lua
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.c', '*.cpp' },
    callback = function()
        vim.cmd('!gcc % -o %:r')
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.tex' },
    callback = function()
        vim.cmd('!pdflatex %')
    end
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'init.lua' },
    callback = function()
        vim.cmd('source %')
    end
})
```
***
# Title: Show cursor line only in active window
# Category: Autocommands
# Tags: autocmd, WinEnter, WinLeave, cursorline
---
Use `WinEnter` and `WinLeave` to show cursor line highlighting only in the active window.

```vim
:autocmd WinEnter * set cursorline
:autocmd WinLeave * set nocursorline
" Cursor line only visible in focused window
```

Or:

```lua
vim.api.nvim_create_autocmd('WinEnter', {
    pattern = '*',
    callback = function()
        vim.bo.cursorline = true
    end
})

vim.api.nvim_create_autocmd('WinLeave', {
    pattern = '*',
    callback = function()
        vim.bo.cursorline = false
    end
})
```
***
# Title: Auto-resize windows on terminal resize
# Category: Autocommands
# Tags: autocmd, VimResized, windows, resize
---
Use `VimResized` autocommand to automatically redistribute window sizes when terminal is resized.

```vim
:autocmd VimResized * wincmd =
" Equalizes window sizes when vim is resized
" Useful when terminal window size changes
```

Or:

```lua
vim.api.nvim_create_autocmd('VimResized', {
    pattern = '*',
    command = 'wincmd =',
    desc = 'Equalizes window sizes when vim is resized'
})
```
***
# Title: Change directory to current file with autocommand
# Category: Autocommands
# Tags: autocmd, BufEnter, cd, directory
---
Use `BufEnter` to automatically change working directory to the current file's directory.

```vim
:autocmd BufEnter * cd %:p:h
" Always work in current file's directory
" Alternative: use 'autochdir' option
:set autochdir  " same effect as above
```

Or:

```lua
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    command = 'cd %:p:h',
    desc = 'Always work in current file directory'
})

vim.opt.autochdir = true
```
***
# Title: Template insertion for new files
# Category: Autocommands
# Tags: autocmd, BufNewFile, template, skeleton
---
Use `BufNewFile` to automatically insert templates or skeleton code for new files.

```vim
:autocmd BufNewFile *.html 0r ~/.vim/templates/html_template.html
:autocmd BufNewFile *.py 0r ~/.vim/templates/python_template.py
:autocmd BufNewFile *.sh 0put ='#!/bin/bash' | $put ='' | 1
```

Or:

```lua
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.html',
    callback = function()
        local template = vim.fn.stdpath('config') .. '/templates/html_template.html'
        if vim.fn.filereadable(template) == 1 then
            vim.cmd('0read ' .. vim.fn.fnameescape(template))
        end
    end
})

vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.py',
    callback = function()
        local template = vim.fn.stdpath('config') .. '/templates/python_template.html'
        if vim.fn.filereadable(template) == 1 then
            vim.cmd('0read ' .. vim.fn.fnameescape(template))
        end
    end
})

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.sh',
  callback = function()
    local lines = { '#!/bin/bash', '' }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.api.nvim_win_set_cursor(0, {2, 0})
  end
})
```
***
# Title: Auto-toggle relative numbers
# Category: Autocommands
# Tags: autocmd, InsertEnter, InsertLeave, relativenumber
---
Use insert mode events to toggle relative line numbers, showing absolute numbers in insert mode.

```vim
:autocmd InsertEnter * set norelativenumber
:autocmd InsertLeave * set relativenumber
" Absolute numbers in insert mode, relative in normal mode
```

Or:

```lua
vim.api.nvim_create_autocmd('InsertEnter', {
    pattern = '*',
    callback = function()
        vim.bo.relativenumber = false
    end
})
vim.api.nvim_create_autocmd('InsertLeave', {
    pattern = '*',
    callback = function()
        vim.bo.relativenumber = true
    end
})
```
***
# Title: Spell check for specific file types
# Category: Autocommands
# Tags: autocmd, FileType, spell, markdown
---
Use `FileType` autocommands to enable spell checking for text-based file types automatically.

```vim
:autocmd FileType markdown,text,gitcommit set spell spelllang=en_us
:autocmd FileType help set nospell
" Enable spell check for text files, disable for help
```

Or:

```lua
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'text', 'gitcommit' },
    callback = function()
        vim.bo.spell = true
        vim.bo.spelllang = 'en_us'
    end,
    desc = 'Enable spell check for text files'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help'
    callback = function()
        vim.bo.spell = false
    end,
    desc = 'Disable spell check for help'
})
```
***
# Title: Auto-close quickfix window
# Category: Autocommands
# Tags: autocmd, QuickFixCmdPost, quickfix, close
---
Use `QuickFixCmdPost` to automatically close quickfix window when it's empty or open it when populated.

```vim
:autocmd QuickFixCmdPost [^l]* copen
:autocmd QuickFixCmdPost l* lopen
" Auto-open quickfix/location list after commands
" Close if empty: :autocmd QuickFixCmdPost * if len(getqflist()) == 0 | cclose | endif
```

Or:

```lua
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = '[^l]*'
    command = 'copen'
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'l*',
  command = 'lopen'
})
```
***
# Title: Highlight yanked text
# Category: Autocommands
# Tags: autocmd, TextYankPost, highlight, yank
---
Use `TextYankPost` to briefly highlight yanked text, making copy operations more visible.

```vim
:autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" In vimscript: 
:autocmd TextYankPost * silent! call matchadd('Search', @", 86400)
:autocmd TextYankPost * silent! call timer_start(150, {-> clearmatches()})
```

Or:

```lua
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Search',
      timeout = 150
    })
  end
})
```
***
# Title: Auto-backup important files
# Category: Autocommands
# Tags: autocmd, BufWritePre, backup, copy
---
Use `BufWritePre` to create timestamped backups of important configuration files before saving.

```vim
:autocmd BufWritePre .vimrc,init.lua,init.vim 
    \ execute 'write! ' . expand('%') . '.backup.' . strftime('%Y%m%d_%H%M%S')
" Creates timestamped backups of config files
```

Or:

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '.vimrc', 'init.lua', 'init.vim'},
  callback = function()
    local filename = vim.fn.expand('%')
    local timestamp = os.date('%Y%m%d_%H%M%S')
    local backup_name = filename .. '.backup.' .. timestamp
    vim.cmd('write! ' .. vim.fn.fnameescape(backup_name))
  end
})
```
***
# Title: Set indent based on file type
# Category: Autocommands
# Tags: autocmd, FileType, indent, tabstop
---
Use `FileType` autocommands to set language-specific indentation and tab settings.

```vim
:autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
:autocmd FileType javascript,json setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
```

Or:

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'json' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end
})
```
***
# Title: Auto-chmod executable scripts
# Category: Autocommands
# Tags: autocmd, BufWritePost, chmod, executable
---
Use `BufWritePost` to automatically make shell scripts executable after saving them.

```vim
:autocmd BufWritePost *.sh,*.py,*.pl,*.rb silent !chmod +x %
:autocmd BufWritePost *
    \ if getline(1) =~ "^#!" |
    \   silent !chmod +x % |
    \ endif
" Make files with shebang executable
```

Or:

```lua
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.sh', '*.py', '*.pl', '*.rb' },
  command = 'silent !chmod +x %'
})
```
***
# Title: Lua autocommands with pattern matching
# Category: Autocommands
# Tags: lua, autocmd, pattern, nvim_create_autocmd, event
---
Create autocommands in Lua using `vim.api.nvim_create_autocmd` with powerful pattern matching and callback functions.

```lua
-- Basic autocommand with single event:
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
  desc = "Format Lua files before saving"
})

-- Multiple events and patterns:
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.md", "*.markdown"},
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Using augroup for organization:
local group = vim.api.nvim_create_augroup("MyAutocommands", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- With buffer-specific autocommand:
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
  end,
})
```
***
