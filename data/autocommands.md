Use `FileChangedShellPost` and `checktime` to automatically reload files changed by external programs.
Or:

```vim
:set autoread
:autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
:autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
```

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

**Source:** Community contributed
***
# Title: Create directory on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, mkdir, directory
---
Use `BufWritePre` to automatically create parent directories when saving files to new paths.
Or:

```vim
:autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')
" Creates parent directories if they don't exist
" 'p' creates intermediate directories like mkdir -p
```

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

**Source:** Community contributed
***
# Title: Jump to last cursor position
# Category: Autocommands
# Tags: autocmd, BufReadPost, cursor, position
---
Use `BufReadPost` to automatically jump to the last known cursor position when reopening files.
Or:

```vim
:autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Jumps to last position if it exists and is valid
```

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

**Source:** Community contributed
***
# Title: Set file type based on content
# Category: Autocommands
# Tags: autocmd, BufRead, filetype, detection
---
Use `BufRead` autocommands to set file types based on file content or patterns not caught by default detection.
Or:

```vim
:autocmd BufRead,BufNewFile *.conf set filetype=conf
:autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
:autocmd BufRead * if getline(1) =~ '^#!/usr/bin/env python' | set ft=python | endif
```

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

**Source:** Community contributed
***
# Title: Auto-format code on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, format, lsp
---
Use `BufWritePre` with LSP or external formatters to automatically format code before saving.
Or:

```vim
:autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx lua vim.lsp.buf.format()
:autocmd BufWritePre *.py !black %
:autocmd BufWritePre *.go !gofmt -w %
" Format different file types with appropriate tools
```

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

**Source:** Community contributed
***
# Title: Highlight long lines
# Category: Autocommands
# Tags: autocmd, ColorColumn, textwidth, highlight
---
Use autocommands to dynamically highlight long lines or set color column based on file type.
Or:

```vim
:autocmd FileType python setlocal colorcolumn=88
:autocmd FileType javascript,typescript setlocal colorcolumn=100
:autocmd FileType gitcommit setlocal colorcolumn=72
" Set different line length limits per file type
```

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

**Source:** Community contributed
***
# Title: Auto-compile on save
# Category: Autocommands
# Tags: autocmd, BufWritePost, compile, build
---
Use `BufWritePost` to automatically compile or build files after saving them.
Or:

```vim
:autocmd BufWritePost *.c,*.cpp !gcc % -o %:r
:autocmd BufWritePost *.tex !pdflatex %
:autocmd BufWritePost init.lua source %
" Compile C files, build LaTeX, reload Lua config
```

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

**Source:** Community contributed
***
# Title: Auto-resize windows on terminal resize
# Category: Autocommands
# Tags: autocmd, VimResized, windows, resize
---
Use `VimResized` autocommand to automatically redistribute window sizes when terminal is resized.
Or:

```vim
:autocmd VimResized * wincmd =
" Equalizes window sizes when vim is resized
" Useful when terminal window size changes
```

```lua
vim.api.nvim_create_autocmd('VimResized', {
    pattern = '*',
    command = 'wincmd =',
    desc = 'Equalizes window sizes when vim is resized'
})
```

**Source:** Community contributed
***
# Title: Change directory to current file with autocommand
# Category: Autocommands
# Tags: autocmd, BufEnter, cd, directory
---
Use `BufEnter` to automatically change working directory to the current file's directory.
Or:

```vim
:autocmd BufEnter * cd %:p:h
" Always work in current file's directory
" Alternative: use 'autochdir' option
:set autochdir  " same effect as above
```

```lua
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    command = 'cd %:p:h',
    desc = 'Always work in current file directory'
})

vim.opt.autochdir = true
```

**Source:** Community contributed
***
# Title: Template insertion for new files
# Category: Autocommands
# Tags: autocmd, BufNewFile, template, skeleton
---
Use `BufNewFile` to automatically insert templates or skeleton code for new files.
Or:

```vim
:autocmd BufNewFile *.html 0r ~/.vim/templates/html_template.html
:autocmd BufNewFile *.py 0r ~/.vim/templates/python_template.py
:autocmd BufNewFile *.sh 0put ='#!/bin/bash' | $put ='' | 1
```

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

**Source:** Community contributed
***
# Title: Auto-toggle relative numbers
# Category: Autocommands
# Tags: autocmd, InsertEnter, InsertLeave, relativenumber
---
Use insert mode events to toggle relative line numbers, showing absolute numbers in insert mode.
Or:

```vim
:autocmd InsertEnter * set norelativenumber
:autocmd InsertLeave * set relativenumber
" Absolute numbers in insert mode, relative in normal mode
```

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

**Source:** Community contributed
***
# Title: Spell check for specific file types
# Category: Autocommands
# Tags: autocmd, FileType, spell, markdown
---
Use `FileType` autocommands to enable spell checking for text-based file types automatically.
Or:

```vim
:autocmd FileType markdown,text,gitcommit set spell spelllang=en_us
:autocmd FileType help set nospell
" Enable spell check for text files, disable for help
```

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

**Source:** Community contributed
***
# Title: Highlight yanked text
# Category: Autocommands
# Tags: autocmd, TextYankPost, highlight, yank
---
Use `TextYankPost` to briefly highlight yanked text, making copy operations more visible.
Or:

```vim
:autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" In vimscript:
:autocmd TextYankPost * silent! call matchadd('Search', @", 86400)
:autocmd TextYankPost * silent! call timer_start(150, {-> clearmatches()})
```

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

**Source:** Community contributed
***
# Title: Auto-backup important files
# Category: Autocommands
# Tags: autocmd, BufWritePre, backup, copy
---
Use `BufWritePre` to create timestamped backups of important configuration files before saving.
Or:

```vim
:autocmd BufWritePre .vimrc,init.lua,init.vim
    \ execute 'write! ' . expand('%') . '.backup.' . strftime('%Y%m%d_%H%M%S')
" Creates timestamped backups of config files
```

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

**Source:** Community contributed
***
# Title: Auto-chmod executable scripts
# Category: Autocommands
# Tags: autocmd, BufWritePost, chmod, executable
---
Use `BufWritePost` to automatically make shell scripts executable after saving them.
Or:

```vim
:autocmd BufWritePost *.sh,*.py,*.pl,*.rb silent !chmod +x %
:autocmd BufWritePost *
    \ if getline(1) =~ "^#!" |
    \   silent !chmod +x % |
    \ endif
" Make files with shebang executable
```

```lua
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.sh', '*.py', '*.pl', '*.rb' },
  command = 'silent !chmod +x %'
})
```

**Source:** Community contributed
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

**Source:** Community contributed
***
# Title: Dynamically Adjust Screen Brightness in Vim
# Category: autocmds
# Tags: focus-events, macos, display
---
Automatically adjust screen brightness when Vim gains or loses focus, useful for reducing eye strain and improving visibility

```vim
:au FocusGained * :!brightness 1
:au FocusLost * :!brightness 0.5
```

```lua
vim.api.nvim_create_augroup('BrightnessAdjust', { clear = true })

vim.api.nvim_create_autocmd('FocusGained', {
  group = 'BrightnessAdjust',
  callback = function()
    vim.fn.system('brightness 1')
  end
})

vim.api.nvim_create_autocmd('FocusLost', {
  group = 'BrightnessAdjust',
  callback = function()
    vim.fn.system('brightness 0.5')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Adjust_Brightness_Automatically_on_Focus)
***
# Title: Conditional Fold Handling for File Types
# Category: autocmds
# Tags: folding, file-type, autocmd
---
Automatically set fold method and open folds for specific file types while maintaining fold control

```vim
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
```

```lua
vim.api.nvim_create_augroup('CustomFolding', { clear = true })

vim.api.nvim_create_autocmd('Syntax', {
  group = 'CustomFolding',
  pattern = {'c', 'cpp', 'vim', 'xml', 'html', 'xhtml', 'perl'},
  callback = function()
    vim.opt_local.foldmethod = 'syntax'
    vim.cmd('normal zR')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/All_folds_open_when_opening_a_file)
***
# Title: Always Start on First Line of Git Commit
# Category: autocmds
# Tags: git, commit-message, cursor-positioning
---
Automatically position cursor at the first line of git commit messages, overriding Vim's default cursor restoration

```vim
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  callback = function()
    vim.fn.setpos('.', {0, 1, 1, 0})
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Always_start_on_first_line_of_git_commit_message)
***
# Title: Auto-save Buffer Periodically
# Category: autocmds
# Tags: auto-save, buffer-management, event-handling
---
Automatically save the current buffer after a specified time interval using CursorHold event, providing a non-intrusive auto-save mechanism

```vim
au BufRead,BufNewFile * let b:start_time=localtime()

au CursorHold * call UpdateFile()

function! UpdateFile()
  if ((localtime() - b:start_time) >= 60)
    update
    let b:start_time=localtime()
  endif
endfunction

au BufWritePre * let b:start_time=localtime()
```

```lua
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  callback = function()
    vim.b.start_time = os.time()
  end
})

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if os.time() - vim.b.start_time >= 60 then
      vim.cmd('update')
      vim.b.start_time = os.time()
    end
  end
})

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.b.start_time = os.time()
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto-save_current_buffer_periodically)
***
# Title: Filetype-Specific Periodic Saving
# Category: autocmds
# Tags: file-type, auto-save, notes
---
Create a custom auto-save for specific file types like notes, enabling periodic saving only for certain buffers

```vim
au CursorHold <buffer> update
```

```lua
vim.api.nvim_create_autocmd('CursorHold', {
  buffer = 0,  -- current buffer
  command = 'update'
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto-save_current_buffer_periodically)
***
# Title: Advanced HTML Tag Completion Function
# Category: autocmds
# Tags: html, auto-completion, insert-mode
---
Comprehensive function to auto-complete HTML tags with additional features like indentation

```vim
function s:CompleteTags()
  inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
  inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()
```

```lua
-- Lua equivalent for advanced HTML tag completion
local function complete_tags()
  vim.api.nvim_buf_set_keymap(0, 'i', '>', '>/<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '><Leader>', '>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(0, 'i', '><CR>', '>/<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$', { noremap = true, silent = true })
end

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.html', '*.js', '*.xml'},
  callback = complete_tags
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_Closing_an_HTML_tag)
***
# Title: Automatic Header File Template Generation
# Category: autocmds
# Tags: file-templates, header-files, auto-generation
---
Automatically generate header file templates with timestamps, filename, and boilerplate content when creating new C/C++ header files

```vim
augroup HeaderTemplate
  autocmd BufNewFile *.h call InsertCHHeader()
autocmd BufWrite *.h call ModifyTime()
endgroup

function! InsertCHHeader()
  call InsertSkeleton('skeleton.h')
  call InsertFname()
  1
  call search('Description:')
  normal $
  startinsert
endfunction
```

```lua
vim.api.nvim_create_augroup('HeaderTemplate', { clear = true })

vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*.h',
  group = 'HeaderTemplate',
  callback = function()
    vim.fn.InsertCHHeader()
  end
})

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*.h',
  group = 'HeaderTemplate',
  callback = function()
    vim.fn.ModifyTime()
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_commands_for_C/C%2B%2B_editing)
***
# Title: Automatic Last Modified Timestamp Update
# Category: autocmds
# Tags: timestamps, file-modification, auto-update
---
Automatically update the 'Last Modified' timestamp when saving a header file

```vim
function! ModifyTime()
  if &modified == 1
    let current_time = strftime('%b %d %Y %X')
    normal mi
    let modified_line_no = search('Last modified:')
    if modified_line_no != 0 && modified_line_no < 10
      exe "normal f:2l" . strlen(current_time) . "s" . current_time
      normal `i
    endif
  endif
endfunction
```

```lua
function _G.ModifyTime()
  if vim.bo.modified then
    local current_time = os.date('%b %d %Y %X')
    vim.cmd('normal mi')
    local modified_line_no = vim.fn.search('Last modified:')
    if modified_line_no ~= 0 and modified_line_no < 10 then
      vim.cmd('normal f:2l' .. #current_time .. 's' .. current_time)
      vim.cmd('normal `i')
    end
  end
end

vim.cmd('function! ModifyTime() lua _G.ModifyTime() end')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_commands_for_C/C%2B%2B_editing)
***
# Title: Autocompile JavaScript with Closure Compiler
# Category: autocmds
# Tags: javascript, compilation, auto-save
---
Automatically compile JavaScript files using Google Closure Compiler when saving, creating a minified version

```vim
BufWriteCmd *.js :call CompileJS()
function! CompileJS()
  if &modified
    write
    let fn = shellescape(expand('%:p'))
    let pn = shellescape(expand('%:p:h'))
    let fnm = expand('%:r.js')
    let cpa = '/home/username/closure/compiler.jar'
    execute "! java -jar " . cpa . " --js=" . fn . " --js_output_file=" . pn . "/" . fnm . ".min.js"
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('BufWriteCmd', {
  pattern = '*.js',
  callback = function()
    if vim.bo.modified then
      vim.cmd('write')
      local fn = vim.fn.shellescape(vim.fn.expand('%:p'))
      local pn = vim.fn.shellescape(vim.fn.expand('%:p:h'))
      local fnm = vim.fn.expand('%:r.js')
      local cpa = '/home/username/closure/compiler.jar'
      vim.fn.system(string.format('java -jar %s --js=%s --js_output_file=%s/%s.min.js',
        cpa, fn, pn, fnm))
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_compile_Javascript_with_Closure)
***
# Title: Automatic JavaScript Compilation with Error Handling
# Category: autocmds
# Tags: javascript, compilation, error-handling
---
Set up automatic JavaScript compilation using Closure compiler with error tracking in quickfix window

```vim
autocmd FileType javascript compiler closure
autocmd BufWritePost *.js make!
autocmd BufWritePost *.js cwindow
```

```lua
vim.api.nvim_create_augroup('JavaScriptCompilation', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'JavaScriptCompilation',
  pattern = 'javascript',
  command = 'compiler closure'
})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'JavaScriptCompilation',
  pattern = '*.js',
  callback = function()
    vim.cmd('make!')
    vim.cmd('cwindow')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_compile_Javascript_with_Closure)
***
# Title: Auto-Generate Java Class Template
# Category: autocmds
# Tags: java, file-templates, autocommands
---
Automatically insert a basic Java class template when creating a new .java file, using the filename as the class name

```vim
autocmd BufNewFile *.java \
  \ exe "normal Opublic class " . expand('%:t:r') . "\n{\n}\<Esc>1G"
```

```lua
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    local filename = vim.fn.expand('%:t:r')
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {
      "public class " .. filename .. " {",
      "",
      "}"
    })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_insert_Java_class_template_when_editing_a_new_Java_file)
***
# Title: Auto-Insert Java Package Name
# Category: autocmds
# Tags: java, package-management, file-templates
---
Automatically detect and insert the correct package name based on the file's directory structure

```vim
function! InsertJavaPackage()
  let dir = getcwd()
  let dir = substitute(dir, "^.*\/src\/", "", "")
  let dir = substitute(dir, "\/", ".", "g")
  let dir = "package " . dir . ";"
  let filename = expand("%:t:r")
  let result = append(0, dir)
  let result = append(1, "")
  let result = append(2, "public class " . filename . " {")
  let result = append(3, "}")
endfunction
```

```lua
function InsertJavaPackage()
  local cwd = vim.fn.getcwd()
  local dir = cwd:gsub("^.*\/src\/", ""):gsub("\/", ".")
  local filename = vim.fn.expand('%:t:r')

  local lines = {
    "package " .. dir .. ";",
    "",
    "public class " .. filename .. " {",
    "}"
  }

  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = InsertJavaPackage
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_insert_Java_class_template_when_editing_a_new_Java_file)
***
# Title: Auto Save Files When Focus Is Lost
# Category: autocmds
# Tags: auto-save, file-management, workflow
---
Automatically save all modified files when Vim loses focus, reducing manual save steps and preventing data loss

```vim
:au FocusLost * silent! wa
```

```lua
vim.api.nvim_create_autocmd('FocusLost', {
  pattern = '*',
  callback = function()
    vim.cmd('silent! wa')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost)
***
# Title: Automatic Perforce File Checkout
# Category: autocmds
# Tags: version-control, workflow, automation
---
Automatically check out files from Perforce when modifying read-only files, with user confirmation

```vim
function IsUnderPerforce()
  if exists("$P4HOME")
    if expand("%:p") =~ ("^" . $P4HOME)
      let b:p4path = substitute(expand("%:p"), $P4HOME, "//depot", "")
    endif
  endif
endfunction

function P4Checkout()
  if exists("b:p4path")
    if (confirm("Checkout from Perforce?", "&Yes\n&No", 1) == 1)
      call system("p4 edit " . b:p4path . " > /dev/null")
      if v:shell_error == 0
        set noreadonly
      endif
    endif
  endif
endfunction

if !exists("au_p4_cmd")
  let au_p4_cmd=1
  au BufEnter * call IsUnderPerforce()
  au FileChangedRO * call P4Checkout()
endif
```

```lua
local function is_under_perforce()
  local p4home = vim.env.P4HOME
  if p4home then
    local current_file = vim.fn.expand('%:p')
    if current_file:match('^' .. p4home) then
      vim.b.p4path = current_file:gsub(p4home, '//depot')
    end
  end
end

local function p4_checkout()
  if vim.b.p4path then
    local choice = vim.fn.confirm('Checkout from Perforce?', '&Yes\n&No', 1)
    if choice == 1 then
      local result = vim.fn.system('p4 edit ' .. vim.b.p4path .. ' > /dev/null')
      if vim.v.shell_error == 0 then
        vim.opt.readonly = false
      end
    end
  end
end

vim.api.nvim_create_augroup('PerforceAutocheckout', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'PerforceAutocheckout',
  callback = is_under_perforce
})
vim.api.nvim_create_autocmd('FileChangedRO', {
  group = 'PerforceAutocheckout',
  callback = p4_checkout
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Autocheckout_from_perforce)
***
# Title: Auto-Update ctags on File Write
# Category: autocmds
# Tags: ctags, project-navigation, auto-generation
---
Automatically update ctags file when saving source code files, keeping tags current for easy code navigation

```vim
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()
```

```lua
local function del_tag_of_file(file)
  local fullpath = file
  local cwd = vim.fn.getcwd()
  local tagfilename = cwd .. "/tags"
  local f = fullpath:gsub(cwd .. "/", "")
  f = f:gsub('([%.%/%*])', '\%1')
  local cmd = string.format('sed -i "/%s/d" "%s"', f, tagfilename)
  vim.fn.system(cmd)
end

local function update_tags()
  local f = vim.fn.expand('%:p')
  local cwd = vim.fn.getcwd()
  local tagfilename = cwd .. "/tags"
  local cmd = string.format('ctags -a -f %s --c++-kinds=+p --fields=+iaS --extra=+q "%s"', tagfilename, f)
  del_tag_of_file(f)
  vim.fn.system(cmd)
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {'*.cpp', '*.h', '*.c'},
  callback = update_tags
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Autocmd_to_update_ctags_file)
***
# Title: Autoconvert Spaces to Tabs in Makefiles
# Category: autocmds
# Tags: file-specific, makefile, formatting
---
Automatically convert leading 8 spaces to a tab in Makefiles when typing or pasting, ensuring consistent indentation

```vim
" Autoconvert 8 spaces to tab in Makefiles
au FileType make :inoremap <buffer><silent><Space> <Space><c-o>:call MapSpaceInMakefile()<CR>

function! MapSpaceInMakefile()
  let line = getline('.')
  let col = col('.')
  if strpart(line, 0, 8) == ' '
    let new = "\t" . strpart(line,8)
    call setline('.', new )
  endif
  return ""
endfunction
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  callback = function()
    vim.keymap.set('i', ' ', function()
      local line = vim.api.nvim_get_current_line()
      if line:sub(1, 8):match('^%s+$') then
        local new_line = '\t' .. line:sub(9)
        vim.api.nvim_set_current_line(new_line)
      end
      return ' '
    end, { buffer = true, expr = true })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Autoconvert_leading_eight_spaces_to_tab_when_type_or_paste_in_Makefile)
***
# Title: Autocompile LaTeX on Write
# Category: autocmds
# Tags: latex, autocmd, compilation
---
Automatically compile LaTeX document and refresh xdvi viewer when saving a .tex file

```vim
au BufWritePost *.tex silent call Tex_RunLaTeX()
au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
```

```lua
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  callback = function()
    vim.fn['Tex_RunLaTeX']()
    vim.fn.system('pkill -USR1 xdvi.bin')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatic_LaTeX_compile_and_XDVI_refresh)
***
# Title: Automatic Filetype Detection for ClearCase Files
# Category: autocmds
# Tags: version-control, file-detection, autocmd
---
Automatically detect file types for ClearCase version-controlled files with complex filenames

```vim
augroup filetypedetect
 au BufNewFile,BufRead *@@/*
 \ if expand("<afile>") =~ '@@' |
 \ exe "doau filetypedetect BufRead " . expand("<afile>:s?@@.*$??") |
 \ endif
augroup END
```

```lua
vim.api.nvim_create_augroup('filetypedetect', { clear = true })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*@@/*',
  group = 'filetypedetect',
  callback = function()
    local filename = vim.fn.expand('<afile>')
    if filename:match('@@') then
      local clean_filename = filename:gsub('@@.*$', '')
      vim.cmd('doautocmd filetypedetect BufRead ' .. clean_filename)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatic_file_type_detection_with_fully_qualified_ClearCase_names)
***
# Title: Automatic C/C++ Header Include Guards
# Category: autocmds
# Tags: c-cpp, code-generation, header-files
---
Automatically insert preprocessor include guards when creating new C/C++ header files to prevent multiple inclusions

```vim
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
```

```lua
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = {'*.h', '*.hpp'},
  callback = function()
    local filename = vim.fn.expand('%:t')
    local gatename = string.upper(filename:gsub('%.',  '_'))
    local lines = {
      '#ifndef ' .. gatename,
      '#define ' .. gatename .. ' ',
      '',
      '#endif /* ' .. gatename .. ' */'
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
    vim.cmd('normal! 2k')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatic_insertion_of_C/C%2B%2B_header_gates)
***
# Title: Automatic Git Project Session Management
# Category: autocmds
# Tags: session-management, git-integration, workflow
---
Automatically save and restore Vim sessions for each Git project, enabling quick context switching between projects

```vim
function! FindProjectName()
  let s:name = getcwd()
  if !isdirectory(".git")
    let s:name = substitute(finddir(".git", ".;"), "/.git", "", "")
  end
  if s:name != ""
    let s:name = matchstr(s:name, ".*", strridx(s:name, "/") + 1)
  end
  return s:name
endfunction

" Sessions only restored if we start Vim without args.
function! RestoreSession(name)
  if a:name != ""
    if filereadable($HOME . "/.vim/sessions/" . a:name)
      execute 'source ' . $HOME . "/.vim/sessions/" . a:name
    end
  end
endfunction

" Sessions only saved if we start Vim without args.
function! SaveSession(name)
  if a:name != ""
    execute 'mksession! ' . $HOME . '/.vim/sessions/' . a:name
  end
endfunction

" Restore and save sessions.
if argc() == 0
  autocmd VimEnter * call RestoreSession(FindProjectName())
  autocmd VimLeave * call SaveSession(FindProjectName())
end
```

```lua
local function find_project_name()
  local name = vim.fn.getcwd()
  if vim.fn.isdirectory('.git') == 0 then
    name = vim.fn.substitute(vim.fn.finddir('.git', '.;'), '/.git', '', '')
  end
  if name ~= '' then
    name = vim.fn.matchstr(name, '.*', vim.fn.strridx(name, '/') + 1)
  end
  return name
end

local function restore_session(name)
  if name ~= '' then
    local session_path = vim.fn.expand('~/.vim/sessions/' .. name)
    if vim.fn.filereadable(session_path) == 1 then
      vim.cmd('source ' .. session_path)
    end
  end
end

local function save_session(name)
  if name ~= '' then
    vim.cmd('mksession! ' .. vim.fn.expand('~/.vim/sessions/' .. name))
  end
end

if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      restore_session(find_project_name())
    end
  })
  vim.api.nvim_create_autocmd('VimLeave', {
    callback = function()
      save_session(find_project_name())
    end
  })
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatic_session_restore_in_git_directories)
***
# Title: Auto-Update Copyright Notice in Files
# Category: autocmds
# Tags: copyright, text-manipulation, automation
---
Automatically update copyright years in file headers when saving modified files, supporting single years and year ranges

```vim
" Automatically update copyright notice with current year
autocmd BufWritePre *
  \ if &modified |
  \   exe "g#\cCOPYRIGHT \(".strftime("%Y")."\)\@![0-9]\{4\}\(-".strftime("%Y")."\)\@!#s#\([0-9]\{4\}\)\(-[0-9]\{4\}\)\?#\1-".strftime("%Y") |
  \ endif
```

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if vim.bo.modified then
      local current_year = os.date('%Y')
      vim.cmd(string.format(
        'silent! g/\cCOPYRIGHT %s/s/\(\d\{4\}\)\(-\d\{4\}\)\?/%s-%s/',
        current_year, '\1', current_year
      ))
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatically_Update_Copyright_Notice_in_Files)
***
# Title: Auto-Position Cursor for Email Editing
# Category: autocmds
# Tags: email-editing, cursor-placement, automation
---
Automatically close Vim when the quickfix window is the only remaining window, which helps clean up after compilation or search results

```vim
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  if &buftype=="quickfix"
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.buftype == 'quickfix' and vim.fn.winnr('$') == 1 then
      vim.cmd('quit')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last)
***
# Title: Automatically Sort and Deduplicate Quickfix List
# Category: autocmds
# Tags: quickfix, sorting, deduplication
---
Automatically sort quickfix list entries by filename and line number, removing duplicate entries after commands like grep or cscope

```vim
function! s:CompareQuickfixEntries(i1, i2)
  if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
    return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
  else
    return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
  endif
endfunction

function! s:SortUniqQFList()
  let sortedList = sort(getqflist(), 's:CompareQuickfixEntries')
  let uniqedList = []
  let last = ''
  for item in sortedList
    let this = bufname(item.bufnr) . "\t" . item.lnum
    if this !=# last
      call add(uniqedList, item)
      let last = this
    endif
  endfor
  call setqflist(uniqedList)
endfunction

autocmd! QuickfixCmdPost * call s:SortUniqQFList()
```

```lua
local function compare_quickfix_entries(i1, i2)
  local buf1 = vim.fn.bufname(i1.bufnr)
  local buf2 = vim.fn.bufname(i2.bufnr)

  if buf1 == buf2 then
    return i1.lnum < i2.lnum
  else
    return buf1 < buf2
  end
end

local function sort_uniq_qf_list()
  local qf_list = vim.fn.getqflist()
  table.sort(qf_list, compare_quickfix_entries)

  local uniqed_list = {}
  local last = ''

  for _, item in ipairs(qf_list) do
    local current = vim.fn.bufname(item.bufnr) .. '\t' .. item.lnum
    if current ~= last then
      table.insert(uniqed_list, item)
      last = current
    end
  end

  vim.fn.setqflist(uniqed_list)
end

vim.api.nvim_create_autocmd('QuickfixCmdPost', {
  callback = sort_uniq_qf_list
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Automatically_sort_Quickfix_list)
***
# Title: Automatically Set Compiler by Filetype
# Category: autocmds
# Tags: compiler, filetype, automation
---
Automatically set the appropriate compiler for a file based on its filetype when opened

```vim
au BufRead * try | execute "compiler ".&filetype | catch /./ | endtry
```

```lua
vim.api.nvim_create_autocmd('BufRead', {
  callback = function()
    pcall(function()
      vim.cmd('compiler ' .. vim.bo.filetype)
    end)
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Autoselect_the_right_compiler_using_the_filetype)
***
# Title: Dynamic Color Scheme Based on Buffer/Directory
# Category: autocmds
# Tags: color-scheme, buffer-management, workflow
---
Automatically change color scheme to visually distinguish different files, directories, or Vim instances

```vim
au BufEnter * if (exists("b:colors_name")) | let b:current_colors=colors_name
 | execute "colorscheme " . b:colors_name | endif
au BufLeave * if (exists("b:current_colors")) | execute "colorscheme " . b:current_colors | endif
```

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.b.colors_name then
      vim.g.current_colors = vim.g.colors_name
      vim.cmd('colorscheme ' .. vim.b.colors_name)
    end
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.g.current_colors then
      vim.cmd('colorscheme ' .. vim.g.current_colors)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Change_colors_when_switching_to_other_directory)
***
# Title: Change Color Scheme for Different Directories
# Category: autocmds
# Tags: color-scheme, directory-specific, workflow
---
Dynamically change color scheme based on the current file's directory to provide visual context

```vim
autocmd BufEnter * if match(@%,'/otherdir/')>=0 | colorscheme oceanblack | else | colorscheme inkpot | end
```

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local current_file = vim.fn.expand('%:p')
    if current_file:match('/otherdir/') then
      vim.cmd('colorscheme oceanblack')
    else
      vim.cmd('colorscheme inkpot')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Change_colors_when_switching_to_other_directory)
***
# Title: Colorscheme for Focused Vim Instance
# Category: autocmds
# Tags: color-scheme, focus, multi-window
---
Change color scheme to highlight the currently focused Vim instance

```vim
autocmd FocusLost * :colorscheme desert
autocmd FocusGained * :colorscheme default
```

```lua
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.cmd('colorscheme desert')
  end
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd('colorscheme default')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Change_colors_when_switching_to_other_directory)
***
# Title: Set Syntax for Files in Specific Directory
# Category: autocmds
# Tags: autocmd, syntax-highlighting, file-type
---
Automatically set syntax highlighting for files in a specific directory path, useful for handling files with non-standard extensions or special content types

```vim
autocmd BufRead,BufNewFile ~/.pyblosxom/data/* set syntax=html
```

```lua
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = vim.fn.expand('~/.pyblosxom/data/*'),
  callback = function()
    vim.bo.syntax = 'html'
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Change_filetype_based_on_directory_path)
***
# Title: Automatic XML Formatting
# Category: autocmds
# Tags: xml, formatting, auto-command
---
Automatically format XML files using Tidy whenever a file with XML filetype is opened

```vim
" Automatically format XML files
:au FileType xml :%!tidy -i -xml --show-errors 0 2>/dev/null
```

```lua
-- Automatically format XML files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'xml',
  callback = function()
    vim.cmd('%!tidy -i -xml --show-errors 0 2>/dev/null')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Cleanup_your_HTML)
***
# Title: Cursor Line Only in Active Window
# Category: autocmds
# Tags: window-management, ui, autocmd
---
Highlight the cursor line only in the active window to reduce visual clutter

```vim
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
```

```lua
vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter', 'BufWinEnter'}, {
  group = 'CursorLine',
  callback = function()
    vim.wo.cursorline = true
  end
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = 'CursorLine',
  callback = function()
    vim.wo.cursorline = false
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Color_active_line)
***
# Title: Filetype-Specific Commenting Function
# Category: autocmds
# Tags: commenting, filetype, autocmd
---
A function that automatically sets up commenting mappings for different filetypes when a buffer is entered

```vim
function CommentIt()
  if &filetype == "vim"
    vmap +# :s/^/"/<CR>
    vmap -# :s/^"//
  elseif &filetype == "tcl"
    vmap +# :s/^/#/<CR>
    vmap -# :s/^#//
  elseif &filetype == "c"
    vmap +# I/*<Esc>gv<End><Esc>a*/<Esc>
    vmap -# I<Esc>2xgv$<Esc>h2x<Esc>
  endif
endfunction

autocmd BufEnter * call CommentIt()
```

```lua
local function comment_it()
  local ft = vim.bo.filetype
  if ft == "vim" then
    vim.keymap.set('v', '+#', ':s/^/"/<CR>', { buffer = true })
    vim.keymap.set('v', '-#', ':s/^"///<CR>', { buffer = true })
  elseif ft == "tcl" then
    vim.keymap.set('v', '+#', ':s/^/#/<CR>', { buffer = true })
    vim.keymap.set('v', '-#', ':s/^#///<CR>', { buffer = true })
  elseif ft == "c" then
    vim.keymap.set('v', '+#', 'I/*<Esc>gv<End><Esc>a*/<Esc>', { buffer = true })
    vim.keymap.set('v', '-#', 'I<Esc>2xgv$<Esc>h2x<Esc>', { buffer = true })
  end
end

vim.api.nvim_create_autocmd('BufEnter', {
  callback = comment_it
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Comment_lines_in_different_filetypes)
***
# Title: Persistent Doxygen Comment Configuration
# Category: autocmds
# Tags: file-type, comments, configuration
---
Use autocmd to set Doxygen comment behavior for C/C++ files, preventing syntax file overrides

```vim
autocmd FileType c,cpp set comments-=://
autocmd FileType c,cpp set comments+=:///
autocmd FileType c,cpp set comments+=://
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp'},
  callback = function()
    vim.opt.comments:remove(':/')
    vim.opt.comments:append('://!')
    vim.opt.comments:append('://')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Continuing_doxygen_comments)
***
# Title: Language-Specific Tab Settings
# Category: autocmds
# Tags: file-type, configuration, indentation
---
Automatically set different tab settings for specific file types like Python

```vim
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType make setlocal noexpandtab
```

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
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Converting_tabs_to_spaces)
***
# Title: Context-Specific Menus for Different Filetypes
# Category: autocmds
# Tags: buffer-management, filetype, menu-customization
---
Dynamically show and hide menus based on the current buffer's filetype, allowing context-specific menu interactions

```vim
au BufEnter * if exists('b:BuffEnter')|exec b:BuffEnter|endif
au BufLeave * if exists('b:BuffEnter')|exec b:BuffLeave|endif

" Example for a specific filetype
let b:BuffEnter='amenu C.added ...'
let b:BuffLeave='unmenu! C|unmenu C'
```

```lua
vim.api.nvim_create_autocmd({'BufEnter', 'BufLeave'}, {
  callback = function(event)
    local buffer_enter = vim.b[event.buf].BuffEnter
    local buffer_leave = vim.b[event.buf].BuffLeave

    if event.event == 'BufEnter' and buffer_enter then
      vim.cmd(buffer_enter)
    elseif event.event == 'BufLeave' and buffer_leave then
      vim.cmd(buffer_leave)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Current_buffer_based_menus)
***
# Title: Debug Window Autocommands Interactively
# Category: autocmds
# Tags: debugging, autocommands, troubleshooting
---
Interactively debug autocommands triggered by window actions like closing or loading buffers

```vim
:debug quit
:debug edit <file>
```

```lua
-- For Neovim, use similar Ex commands with interactive debugging
-- Use :debug to step through autocommands when triggering specific actions
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Debugging_window_autocommands)
***
# Title: Automatically Decompile Java Class Files
# Category: autocmds
# Tags: java, file-reading, automation
---
Automatically decompile Java .class files when opened in Vim/Neovim using javap command

```vim
function s:ReadClass(dir, classname)
  execute "cd " . a:dir
  execute "0read !javap -c " . a:classname
  1
  setlocal readonly
  setlocal nomodified
endfunction

autocmd BufReadCmd *.class
  \ call <SID>ReadClass(expand("<afile>:p:h"), expand("<afile>:t:r"))
```

```lua
vim.api.nvim_create_autocmd('BufReadCmd', {
  pattern = '*.class',
  callback = function()
    local file = vim.fn.expand('<afile>')
    local dir = vim.fn.expand('<afile>:p:h')
    local classname = vim.fn.expand('<afile>:t:r')

    vim.cmd('cd ' .. dir)
    vim.cmd('0read !javap -c ' .. classname)
    vim.cmd('1')
    vim.bo.readonly = true
    vim.bo.modified = false
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Decompile_Java_.class_files_automatically)
***
# Title: Detect New Window Creation with Window-Local Variable
# Category: autocmds
# Tags: window-management, autocmd, initialization
---
Reliably detect when a new window is created using a window-local variable, allowing custom initialization for new windows

```vim
" Set window-local variable when a new window is created
autocmd VimEnter * autocmd WinEnter * let w:created=1

" Initialize window-specific options only for new windows
autocmd WinEnter * if !exists('w:created') | setlocal nu | endif
```

```lua
-- Set up autocommand to mark new windows
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        vim.w.created = true
      end
    })
  end
})

-- Initialize options only for new windows
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    if vim.w.created == nil then
      vim.wo.number = true
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Detect_window_creation)
***
# Title: Detect New Window Creation Reliably
# Category: autocmds
# Tags: window-management, autocmd, initialization
---
Provides a robust method to detect and initialize new windows, avoiding common pitfalls with WinEnter autocmd

```vim
" Set window-local created flag
autocmd VimEnter * autocmd WinEnter * let w:created=1

" Initialize options only for new windows
autocmd WinEnter * if !exists('w:created') | setlocal nu | endif
```

```lua
-- Set window-local created flag
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        vim.w.created = true
      end
    })
  end
})

-- Initialize options only for new windows
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    if vim.w.created == nil then
      vim.wo.number = true
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Detect_window_creation_with_WinEnter)
***
# Title: Filetype-Specific Dictionary Completion
# Category: autocmds
# Tags: filetype, completion, customization
---
Automatically load filetype-specific dictionaries to provide context-aware word completion

```vim
" Automatically load filetype-specific dictionary
au FileType * execute 'setlocal dict+=~/.vim/words/'.&filetype.'.txt'
```

```lua
-- Automatically load filetype-specific dictionary
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local dict_path = string.format('~/.vim/words/%s.txt', vim.bo.filetype)
    vim.opt_local.dictionary:append(dict_path)
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Dictionary_completions)
***
# Title: Set Default Filetype for New Buffers
# Category: autocmds
# Tags: filetype, buffer-management, startup
---
Automatically set a default filetype (e.g., Python) for new blank buffers

```vim
let g:do_filetype = 0
au BufWinEnter,BufAdd * if expand('<afile>') == "" | let g:do_filetype = 1 | endif
au BufEnter * if g:do_filetype | setf python | let g:do_filetype = 0 | endif
```

```lua
vim.g.do_filetype = 0

vim.api.nvim_create_augroup('DefaultFiletype', { clear = true })

vim.api.nvim_create_autocmd({'BufWinEnter', 'BufAdd'}, {
  group = 'DefaultFiletype',
  callback = function()
    if vim.fn.expand('<afile>') == '' then
      vim.g.do_filetype = 1
    end
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'DefaultFiletype',
  callback = function()
    if vim.g.do_filetype == 1 then
      vim.bo.filetype = 'python'
      vim.g.do_filetype = 0
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Disabling_default_ftplugins)
***
# Title: Set UTF-8 Encoding for Mac Quicklook
# Category: autocmds
# Tags: encoding, mac-os, file-operations
---
Automatically set UTF-8 extended attributes for files to ensure correct display in Mac Quicklook

```vim
au BufWritePost * :if &fenc=='utf-8' || (&fenc=='' && &enc=='utf-8') | exec "silent !xattr -w com.apple.TextEncoding 'UTF-8;134217984' '%'" | endif
```

```lua
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    if vim.o.fileencoding == 'utf-8' or (vim.o.fileencoding == '' and vim.o.encoding == 'utf-8') then
      vim.fn.system('xattr -w com.apple.TextEncoding "UTF-8;134217984" "' .. vim.fn.expand('%') .. '"')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Display_UTF-8_characters_in_Mac_Quicklook)
***
# Title: Dynamic Language-Specific Commenting Functions
# Category: autocmds
# Tags: language-support, file-type, key-mapping
---
Automatically set up comment mappings based on the current file type, providing a consistent commenting experience across languages

```vim
function! PoundComment()
  map - :s/^/# /<CR>
  map _ :s/^\s*# \=//<CR>
  set comments=:#
endfunction

autocmd FileType perl,cgi,csh,sh call PoundComment()
autocmd FileType java call SlashComment()
```

```lua
local function setup_comment_mapping(comment_char)
  vim.keymap.set('n', '-', function()
    vim.api.nvim_command(string.format('s/^/%s /', comment_char))
  end)
  vim.keymap.set('n', '_', function()
    vim.api.nvim_command(string.format('s/^\s*%s \?//', comment_char))
  end)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'perl', 'cgi', 'csh', 'sh'},
  callback = function() setup_comment_mapping('#') end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'java', 'cpp'},
  callback = function() setup_comment_mapping('//') end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Easy_(un)commenting_out_of_source_code)
***
# Title: MoinMoin File Type Detection
# Category: autocmds
# Tags: file-type, detection
---
Automatically detect and set filetype for MoinMoin wiki files with .moin extension

```vim
au! BufNewFile,BufRead *.moin setf moin
```

```lua
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.moin',
  command = 'setf moin'
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Edit_MoinMoin_wiki_files_with_folding)
***
# Title: Detect Perl Batch Files in Vim
# Category: autocmds
# Tags: filetype, detection, scripting
---
Automatically detect and set filetype for Perl batch files based on first line content

```vim
au BufRead,BufNewFile *.bat 	if getline(1) =~ '--*-Perl-*--' | setf perl | endif
```

```lua
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.bat',
  callback = function()
    local first_line = vim.fn.getline(1)
    if first_line:match('--*-Perl-*--') then
      vim.bo.filetype = 'perl'
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Editing_ActiveState_Perl_batch_files)
***
# Title: GPG File Encryption Autocommands
# Category: autocmds
# Tags: encryption, gpg, security
---
Automatically handle GPG-encrypted files with transparent editing and encryption

```vim
augroup encrypted
  au!
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
augroup END
```

```lua
vim.api.nvim_create_augroup('encrypted', { clear = true })
vim.api.nvim_create_autocmd({'BufReadPre', 'FileReadPre'}, {
  group = 'encrypted',
  pattern = '*.gpg',
  callback = function()
    vim.opt.viminfo = ''
    vim.opt.swapfile = false
    vim.opt.undofile = false
    vim.opt.backup = false
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Encryption)
***
# Title: Automate File Explorer Startup and Cleanup
# Category: autocmds
# Tags: file-explorer, window-management, startup
---
Automatically open a file explorer when Vim starts and close it when it's the last window, with version-specific handling for different Vim versions

```vim
func OpenFileWindow()
 :20vs
 :Explore
 wincmd p
endfunc

func CloseIfLast()
 if v:version >= 700
  if exists("b:netrw_curdir")
   let n = winnr()
   wincmd p
   if n == winnr()
    quit
   endif
   wincmd p
  endif
 endif
endfunc

if has("autocmd")
 autocmd VimEnter * call OpenFileWindow()
 autocmd WinEnter * call CloseIfLast()
endif
```

```lua
local function open_file_window()
 vim.cmd('20vs')
 vim.cmd('Explore')
 vim.cmd('wincmd p')
end

local function close_if_last()
 if vim.fn.exists('b:netrw_curdir') == 1 then
  local current_win = vim.fn.winnr()
  vim.cmd('wincmd p')
  if vim.fn.winnr() == current_win then
   vim.cmd('quit')
  end
  vim.cmd('wincmd p')
 end
end

vim.api.nvim_create_augroup('FileExplorer', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
 group = 'FileExplorer',
 callback = open_file_window
})

vim.api.nvim_create_autocmd('WinEnter', {
 group = 'FileExplorer',
 callback = close_if_last
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Explorer_startup_and_shutdown)
***
# Title: Detect and Mark Buffer as Modified When File Deleted
# Category: autocmds
# Tags: file-handling, buffer-management, error-handling
---
Automatically mark a buffer as modified when its underlying file is deleted, preventing accidental buffer abandonment

```vim
au FileChangedShell * call FCSHandler(expand("<afile>:p"))
function FCSHandler(name)
  if v:fcs_reason == "deleted"
    call setbufvar(expand(a:name), '&modified', '1')
    echohl WarningMsg
    echomsg 'File "'.a:name.'" no longer available - ''modified'' set'
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('FileChangedShell', {
  callback = function(event)
    local filename = event.file
    if vim.v.fcs_reason == 'deleted' then
      vim.api.nvim_buf_set_option(0, 'modified', true)
      vim.notify('File "' .. filename .. '" no longer available - modified set', vim.log.levels.WARN)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/File_no_longer_available_-_mark_buffer_modified)
***
# Title: Speed Up Searches by Disabling Autocmds
# Category: autocmds
# Tags: performance, search, autocmd
---
Use noautocmd to significantly speed up vimgrep searches by temporarily disabling autocommands

```vim
:noautocmd vimgrep /{pattern}/[flags] {file(s)}
```

```lua
vim.cmd('noautocmd vimgrep /{pattern}/[flags] {file(s)}')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Find_in_files_within_Vim)
***
# Title: Auto-Save and Highlight Unsaved Buffers on Focus Lost
# Category: autocmds
# Tags: buffer-management, focus-events, ui-feedback
---
Automatically check for modified buffers when losing focus and provide visual feedback via background color

```vim
augroup focus_buffer_check
  au FocusGained * :hi Normal guibg='#000000'
  au FocusLost * let i = 0
  au FocusLost * while i < bufnr('$')
  au FocusLost *  if getbufvar(winbufnr(i), '&modified')
  au FocusLost *   break
  au FocusLost *  endif
  au FocusLost *  let i = i+1
  au FocusLost * endwhile
  au FocusLost * if i < bufnr("$")
  au FocusLost *  :hi Normal guibg='#330000'
  au FocusLost * else
  au FocusLost *  :hi Normal guibg='#000033'
  au FocusLost *  cclose
  au FocusLost * endif
augroup END
```

```lua
vim.api.nvim_create_augroup('focus_buffer_check', { clear = true })

vim.api.nvim_create_autocmd('FocusGained', {
  group = 'focus_buffer_check',
  callback = function()
    vim.cmd('hi Normal guibg=#000000')
  end
})

vim.api.nvim_create_autocmd('FocusLost', {
  group = 'focus_buffer_check',
  callback = function()
    for i = 1, vim.fn.bufnr('$') do
      if vim.fn.getbufvar(vim.fn.winbufnr(i), '&modified') == 1 then
        vim.cmd('hi Normal guibg=#330000')
        return
      end
    end
    vim.cmd('hi Normal guibg=#000033')
    vim.cmd('cclose')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Forgetting_to_save_changes_on_FocusLost)
***
# Title: Automatically Check for External File Changes
# Category: autocmds
# Tags: file-monitoring, buffer-management, autocommands
---
Automatically detect and reload files that have been modified externally, improving workflow when working with dynamic files like logs or collaborative documents

```vim
" Watch for external file changes
command! -bang WatchForChanges :call WatchForChanges(@%, {'toggle': 1, 'autoread': <bang>0})
```

```lua
-- Lua equivalent for watching file changes
vim.api.nvim_create_user_command('WatchForChanges', function(opts)
  -- Implementation would require translating the full Vimscript function
  -- Core functionality: periodically check if file changed externally
  vim.opt.autoread = true
end, { bang = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally)
***
# Title: Check File Changes on Focus
# Category: autocmds
# Tags: file-monitoring, events, autocommands
---
Automatically check and reload files when Vim regains focus or enters a buffer, ensuring you always have the latest version

```vim
au FocusGained,BufEnter * :checktime
```

```lua
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally)
***
# Title: Conditional File Encoding Auto-Command
# Category: autocmds
# Tags: file-encoding, buffer-settings, conditional-config
---
Safely set file encoding for specific file types while handling non-modifiable buffers

```vim
function! Noma_workaround()
  if &modifiable
    set tw=77 ai nocindent fileencoding=iso-8859-1
  else
    set tw=77 ai nocindent
  endif
endfunction
au BufNewFile,BufRead mutt*,*.txt,*/.followup call Noma_workaround()
```

```lua
local function noma_workaround()
  if vim.opt.modifiable:get() then
    vim.opt.textwidth = 77
    vim.opt.autoindent = true
    vim.opt.cindent = false
    vim.opt.fileencoding = 'iso-8859-1'
  else
    vim.opt.textwidth = 77
    vim.opt.autoindent = true
    vim.opt.cindent = false
  end
end

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'mutt*', '*.txt', '*/.followup'},
  callback = noma_workaround
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Helpfiles_and_avoiding_E21_error_with_fileencoding)
***
# Title: Automatic Binary File Hex Mode Detection
# Category: autocmds
# Tags: file-detection, binary-files, autocmd
---
Automatically detect and open binary files in hex mode, with intelligent handling of file types and write operations

```vim
augroup Binary
  au!
  au BufReadPre *.bin,*.hex setlocal binary
  au BufReadPost *
        \ if &binary | Hexmode | endif
  au BufWritePre *
        \ if exists("b:editHex") && b:editHex && &binary |
        \  let oldro=&ro | let &ro=0 |
        \  let oldma=&ma | let &ma=1 |
        \  silent exe "%!xxd -r" |
        \  let &ma=oldma | let &ro=oldro |
        \ endif
augroup END
```

```lua
local binary_augroup = vim.api.nvim_create_augroup('BinaryFileHandling', { clear = true })

vim.api.nvim_create_autocmd({'BufReadPre'}, {
  pattern = {'*.bin', '*.hex'},
  group = binary_augroup,
  callback = function()
    vim.bo.binary = true
  end
})

vim.api.nvim_create_autocmd({'BufReadPost'}, {
  pattern = '*',
  group = binary_augroup,
  callback = function()
    if vim.o.binary then
      vim.cmd('Hexmode')
    end
  end
})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = '*',
  group = binary_augroup,
  callback = function()
    if vim.b.edit_hex and vim.o.binary then
      local readonly = vim.o.readonly
      local modifiable = vim.bo.modifiable

      vim.o.readonly = false
      vim.bo.modifiable = true

      vim.cmd('%!xxd -r')

      vim.o.readonly = readonly
      vim.bo.modifiable = modifiable
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Hex)
***
# Title: Dynamic Folding with Indent and Manual Override
# Category: autocmds
# Tags: folding, buffer-management, configuration
---
Create a flexible folding configuration that uses indent-based folding by default but allows manual fold creation during editing

```vim
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
```

```lua
vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd({'BufReadPre'}, {
  group = 'vimrc',
  pattern = '*',
  callback = function() vim.opt_local.foldmethod = 'indent' end
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  group = 'vimrc',
  pattern = '*',
  callback = function()
    if vim.o.foldmethod == 'indent' then
      vim.opt_local.foldmethod = 'manual'
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Hide/show_parts_of_your_code)
***
# Title: Colorscheme Cycling Autocommand
# Category: autocmds
# Tags: colorscheme, auto-command, window-event
---
Automatically cycle through color schemes when entering a new window, creating a dynamic visual effect

```vim
:au WinEnter * :silent CN
```

```lua
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    vim.cmd('silent CN')
  end
})
```

**WARNING**: This tip reuqires ScrollColors plugin to be installed. Popular pickers like **Fzf-lua** or **Telescope** already have this  functionality built in.

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/How_to_Have_a_Vim_Rave)
***
# Title: Automatic Hex Mode for Binary Files
# Category: autocmds
# Tags: binary-files, file-detection, auto-conversion
---
Automatically detect and enter hex mode for binary files with .bin and .hex extensions

```vim
augroup Binary
  au!
  au BufReadPre *.bin,*.hex setlocal binary
  au BufReadPost *
        \ if &binary | Hexmode | endif
  au BufWritePre *
        \ if exists("b:editHex") && b:editHex && &binary |
        \  let oldro=&ro | let &ro=0 |
        \  let oldma=&ma | let &ma=1 |
        \  silent exe "%!xxd -r" |
        \  let &ma=oldma | let &ro=oldro |
        \ endif
augroup END
```

```lua
vim.api.nvim_create_augroup('Binary', { clear = true })

vim.api.nvim_create_autocmd({'BufReadPre'}, {
  group = 'Binary',
  pattern = {'*.bin', '*.hex'},
  callback = function()
    vim.o.binary = true
  end
})

vim.api.nvim_create_autocmd({'BufReadPost'}, {
  group = 'Binary',
  callback = function()
    if vim.o.binary then
      vim.cmd('Hexmode')
    end
  end
})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
  group = 'Binary',
  callback = function()
    if vim.b.edit_hex and vim.o.binary then
      local readonly = vim.o.readonly
      local modifiable = vim.o.modifiable
      vim.o.readonly = false
      vim.o.modifiable = true
      vim.cmd('%!xxd -r')
      vim.o.modifiable = modifiable
      vim.o.readonly = readonly
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Improved_hex_editing)
***
# Title: Automatically Update Last Modified Timestamp
# Category: autocmds
# Tags: file-management, timestamps, autocmd
---
Automatically update 'Last modified' timestamp when saving a file

```vim
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.*Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call setpos('.', save_cursor)
  endif
endfun

autocmd BufWritePre * call LastModified()
```

```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local modified = vim.bo.modified
    if modified then
      local save_cursor = vim.fn.getpos(".")
      local last_line = math.min(20, vim.fn.line("$"))
      vim.cmd(string.format('1,%ds#^\(.*Last modified: \).*#\1%s#e',
        last_line, os.date("%a %b %d, %Y  %I:%M%p")))
      vim.fn.setpos(".", save_cursor)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_current_date_or_time)
***
# Title: Auto-Insert Image Sizes in HTML
# Category: autocmds
# Tags: html, perl, automation
---
Automatically retrieve and insert image width and height into HTML <img> tags using Perl's Image::Size module

```vim
function! PerlImageSize()
  g/src
  normal $
  normal N
  normal 2w
  perl << EOF
  use Image::Size;
  $jo = VIM::Eval("expand('<cfile>')");
  $size = Image::Size::html_imgsize("$jo");
  VIM::Eval("setreg('a', '$size')");
EOF
  normal $
  normal "ap
endfunction
nnoremap <F4> :call PerlImageSize()<CR>
```

```lua
local function perl_image_size()
  -- Note: Requires Perl and Image::Size module
  vim.cmd('g/src')
  vim.cmd('normal! $N2w')
  local file = vim.fn.expand('<cfile>')

  -- This would require a Lua equivalent or external command
  -- Recommended to use a Lua image library or external command instead
end

-- Map to F4 in Neovim
vim.keymap.set('n', '<F4>', perl_image_size, { desc = 'Insert image sizes in HTML' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Insert_image_size_with_vim_(when_coding_html))
***
# Title: Append SQL Commands to History File
# Category: autocmds
# Tags: sql, logging, buffer-management
---
Automatically append SQL command buffer contents to a history file when saving

```vim
fu! Sqllog()
  1,$-1w! >> $SQLPATH/sqlplus.history
endf
au BufWrite afiedt.buf call Sqllog()
```

```lua
vim.api.nvim_create_autocmd('BufWrite', {
  pattern = 'afiedt.buf',
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -2, false)
    local sqlpath = vim.env.SQLPATH .. '/sqlplus.history'
    vim.fn.writefile(lines, sqlpath, 'a')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Keep_SQL-PLUS_command_history_under_Windows)
***
# Title: Automatic Backup on File Write
# Category: autocmds
# Tags: backup, file-write, auto-commands
---
Create a backup in a trash directory only if the file content has changed, using diff to check modifications

```vim
set backup

augroup backups
 au!
 autocmd BufWritePost,FileWritePost * !diff -d <afile> <afile>~ &> /dev/null;if [[ $? == 1 ]];then touch <afile>~;mv <afile>~ `mktemp ~/Desktop/Trash/<afile>.XXXXXX`;fi
augroup END
```

```lua
vim.api.nvim_create_augroup('backups', { clear = true })

vim.api.nvim_create_autocmd({'BufWritePost', 'FileWritePost'}, {
  group = 'backups',
  pattern = '*',
  callback = function()
    local file = vim.fn.expand('<afile>')
    local backup = file .. '~'
    local diff_cmd = string.format('diff -d %s %s &> /dev/null', file, backup)

    if vim.fn.system(diff_cmd) ~= 0 then
      vim.fn.system(string.format('touch %s && mv %s $(mktemp ~/Desktop/Trash/%s.XXXXXX)', backup, backup, file))
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Keep_incremental_backups_of_edited_files)
***
# Title: Automatically Set Listing Files as Read-Only
# Category: autocmds
# Tags: file-protection, autocmd, read-only
---
Automatically change color schemes to visually distinguish between different files, directories, or Vim instances, helping prevent accidental edits

```vim
au BufEnter * if (exists("b:colors_name")) | let b:current_colors=colors_name
  \ | execute "colorscheme " . b:colors_name | endif
au BufLeave * if (exists("b:current_colors")) | execute "colorscheme " . b:current_colors | endif
```

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.b.colors_name then
      vim.g.current_colors = vim.g.colors_name
      vim.cmd('colorscheme ' .. vim.b.colors_name)
    end
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.g.current_colors then
      vim.cmd('colorscheme ' .. vim.g.current_colors)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Localized_color_schemes)
***
# Title: Auto Open Quickfix Window After Make
# Category: autocmds
# Tags: build, quickfix, error-handling
---
Automatically open quickfix window after running make, showing compilation errors without manual intervention

```vim
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow
```

```lua
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  nested = true,
  callback = function()
    vim.cmd('cwindow')
  end
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = 'l*',
  nested = true,
  callback = function()
    vim.cmd('lwindow')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Make_make_more_helpful)
***
# Title: Automatic View and Fold Persistence
# Category: autocmds
# Tags: views, folds, persistence, buffer-management
---
Automatically save and restore views (including folds) when opening and closing files, preserving your folding and view state between sessions

```vim
set viewoptions-=options
augroup vimrc
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END
```

```lua
vim.opt.viewoptions:remove('options')

vim.api.nvim_create_augroup('view_persistence', { clear = true })
vim.api.nvim_create_autocmd({'BufWritePost', 'BufRead'}, {
  group = 'view_persistence',
  pattern = '*',
  callback = function()
    local filename = vim.fn.expand('%')
    local buftype = vim.o.buftype
    if filename ~= '' and not buftype:match('nofile') then
      if vim.api.nvim_call_function('expand', {'%'}) ~= '' then
        if vim.api.nvim_call_function('filereadable', {filename}) == 1 then
          vim.cmd(vim.api.nvim_call_function('winnr', {'$'}) .. 'wincmd w')
          vim.cmd('silent! loadview')
        end
      end
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Make_views_automatic)
***
# Title: Smart View Saving with Filters
# Category: autocmds
# Tags: views, file-management, buffer-filtering
---
Implement advanced filtering for view saving to avoid creating views for temporary, generated, or system files

```vim
let g:skipview_files = [
            \ '[EXAMPLE PLUGIN BUFFER]'
            \ ]
function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile'
        return 0
    endif
    if empty(glob(expand('%:p')))
        return 0
    endif
    if index(g:skipview_files, expand('%')) >= 0
        return 0
    endif
    return 1
endfunction
```

```lua
local M = {}

M.skipview_files = {
  '[EXAMPLE PLUGIN BUFFER]'
}

function M.make_view_check()
  -- Skip quickfix and nofile buffers
  if vim.wo.buftype:match('nofile') then
    return false
  end

  -- Skip non-existent files
  local filename = vim.fn.expand('%:p')
  if vim.fn.empty(vim.fn.glob(filename)) == 1 then
    return false
  end

  -- Skip files in skip list
  local current_file = vim.fn.expand('%')
  for _, skip_file in ipairs(M.skipview_files) do
    if current_file == skip_file then
      return false
    end
  end

  return true
end

return M
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Make_views_automatic)
***
# Title: Auto-Close Completion Preview Automatically
# Category: autocmds
# Tags: completion, preview, auto-close
---
Automatically close the preview window when moving cursor or leaving insert mode

```vim
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
```

```lua
vim.api.nvim_create_autocmd({'CursorMovedI', 'InsertLeave'}, {
  callback = function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd('pclose')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Omnicomplete_-_Remove_Python_Pydoc_Preview_Window)
***
# Title: Automatically Open Swap Files Read-Only
# Category: autocmds
# Tags: swap-files, buffer-management, file-handling
---
Automatically open files with existing swap files in read-only mode, reducing manual intervention when a file is already open elsewhere

```vim
func CheckSwap()
  swapname
  if v:statusmsg =~ '\.sw[^p]$'
    set ro
  endif
endfunc

if &swf
  set shm+=A
  au BufReadPre * call CheckSwap()
endif
```

```lua
vim.api.nvim_create_augroup('SwapFileCheck', { clear = true })

vim.api.nvim_create_autocmd('BufReadPre', {
  group = 'SwapFileCheck',
  callback = function()
    local swapname = vim.fn.swapname()
    if swapname:match('\.sw[^p]$') then
      vim.api.nvim_buf_set_option(0, 'readonly', true)
    end
  end
})

-- Optional: Modify short message to suppress swap file warnings
vim.opt.shortmess:append('A')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_same_file_read-only_in_second_Vim)
***
# Title: Automatic Tags Generation for Python Projects
# Category: autocmds
# Tags: tags, python, file-management
---
Automatically generate ctags for Python and template files on buffer write, ensuring updated tag files

```vim
function WritePythonTags()
  let foo = system("/usr/bin/ctags --langmap=python:.py.ptl *.py *.ptl")
endfunction

au BufWritePost *.py,*.ptl call WritePythonTags()
```

```lua
local function write_python_tags()
  vim.fn.system("/usr/bin/ctags --langmap=python:.py.ptl *.py *.ptl")
end

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {'*.py', '*.ptl'},
  callback = write_python_tags
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Optionally_open_matching_or_selected_tag_in_full_height_vertical_window)
***
# Title: Periodic Background Command Execution
# Category: autocmds
# Tags: timer, background-task, event-handling
---
Simulate a timer in Vim versions before 8.0 by using CursorHold autocommand to periodically execute a function

```vim
autocmd CursorHold * call Timer()
function! Timer()
  call feedkeys("f\e")
  " Periodically trigger a function
endfunction
```

```lua
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    -- Simulate periodic timer execution
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('f', true, false, true), 'n', true)
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Periodic_Commands_in_Background)
***
# Title: Track Cursor Position in Insert Mode
# Category: autocmds
# Tags: cursor-tracking, insert-mode, autocmd
---
Tracks and preserves cursor column position when exiting insert mode

```vim
let CursorColumnI = 0
autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
```

```lua
vim.api.nvim_create_augroup('CursorPositionTracking', { clear = true })
vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'CursorPositionTracking',
  callback = function()
    vim.b.cursor_column_i = vim.fn.col('.')
  end
})
vim.api.nvim_create_autocmd('CursorMovedI', {
  group = 'CursorPositionTracking',
  callback = function()
    vim.b.cursor_column_i = vim.fn.col('.')
  end
})
vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'CursorPositionTracking',
  callback = function()
    if vim.fn.col('.') ~= vim.b.cursor_column_i then
      vim.fn.cursor(0, vim.fn.col('.') + 1)
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Prevent_escape_from_moving_the_cursor_one_character_to_the_left)
***
# Title: Throttle Frequent Autocommands
# Category: autocmds
# Tags: performance, autocommands, cursor-movement
---
Prevent performance slowdowns by limiting how often autocommands are triggered during frequent events like cursor movement

```vim
function! LongEnough(timer, delay, ...)
  let result = 0
  let suppressionCount = a:0 ? a:1 : 0

  if (!exists(a:timer))
    let result = 1
  else
    let timeElapsed = localtime() - {a:timer}
    if (timeElapsed >= a:delay)
      let result = 1
    elseif (suppressionCount > 0)
      let {a:timer}_callCount += 1
      if ({a:timer}_callCount >= suppressionCount)
        let result = 1
      endif
    endif
  endif

  if (result)
    let {a:timer} = localtime()
    let {a:timer}_callCount = 0
  endif
  return result
endfunction

" Example usage
autocommand CursorMoved * if LongEnough("g:MatchParens", 1, 3) | call MatchParens() | endif
```

```lua
local function long_enough(timer, delay, suppression_count)
  suppression_count = suppression_count or 0
  local timer_var = vim.g[timer]
  local call_count_var = vim.g[timer .. '_callCount'] or 0

  if not timer_var then
    return true
  end

  local time_elapsed = os.time() - timer_var
  if time_elapsed >= delay then
    return true
  end

  if suppression_count > 0 then
    call_count_var = call_count_var + 1
    if call_count_var >= suppression_count then
      return true
    end
  end

  return false
end

-- Example usage
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    if long_enough('MatchParens', 1, 3) then
      -- Call your function here
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Prevent_frequent_commands_from_slowing_things_down)
***
# Title: Automatically Refresh Firefox When Saving HTML/CSS
# Category: autocmds
# Tags: automation, web-development, integration
---
Automatically refresh Firefox and preserve scroll position when saving HTML, CSS, or GTPL files using MozRepl

```vim
autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo 'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();' |
          \ nc -w 1 localhost 4242 2>&1 > /dev/null
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('BufWriteCmd', {
  pattern = {'*.html', '*.css', '*.gtpl'},
  callback = function()
    if vim.bo.modified then
      vim.cmd('write')
      vim.fn.system("echo 'vimYo = content.window.pageYOffset; " ..
                    "vimXo = content.window.pageXOffset; " ..
                    "BrowserReload(); " ..
                    "content.window.scrollTo(vimXo,vimYo); " ..
                    "repl.quit();' | nc -w 1 localhost 4242 2>&1 > /dev/null")
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Refresh_Firefox_(preserving_scroll)_on_Vim_save,_using_MozRepl)
***
# Title: Remove Trailing Whitespace on Save
# Category: autocmds
# Tags: whitespace, cleanup, file-saving
---
Automatically remove trailing whitespace when saving files, with optional file type filtering

```vim
autocmd BufWritePre *.{cpp,h,c} %s/\s\+$//e

" More selective version
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e
```

```lua
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.{cpp,h,c}'},
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end
})

-- With filetype filtering
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp', 'java', 'php'},
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = true,
      callback = function()
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
      end
    })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Remove_trailing_spaces)
***
# Title: Restore Cursor to Specific Line on File Open
# Category: autocmds
# Tags: cursor-position, file-editing
---
Automatically position cursor at a specific line when opening a file, useful for consistent editing workflow

```vim
au BufWinEnter * exe 'normal gg'  " Go to first line
au BufWinEnter * exe 'normal 6gg'  " Go to 6th line
```

```lua
vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    -- Go to first line
    vim.cmd('normal! gg')

    -- Or go to a specific line (e.g., 6th line)
    -- vim.cmd('normal! 6gg')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Restore_state_of_edited_files_when_reopened)
***
# Title: Restore Mode When Switching Tab Pages
# Category: autocmds
# Tags: tab-management, mode-persistence, workflow
---
Manually set Fortran source form for .for files to fix syntax highlighting issues

```vim
au BufRead,BufNewFile *.for let b:fortran_fixed_source=1
```

```lua
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.for',
  callback = function()
    vim.b.fortran_fixed_source = 1
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip449)
***
# Title: Persistent Command Window Line Position
# Category: autocmds
# Tags: command-line, workflow, automation
---
Create an autocmd to remember and restore the last line position in the command window when executing commands

```vim
" Autocmd to remember command window line position
autocmd CmdwinEnter * nnoremap <buffer> <F5> :let g:CmdWindowLineMark=line(".")<CR><CR>q::execute "normal ".g:CmdWindowLineMark."G"<CR>
```

```lua
-- Lua equivalent for remembering command window line position
vim.api.nvim_create_autocmd('CmdwinEnter', {
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      vim.g.CmdWindowLineMark = vim.fn.line('.')
      vim.cmd('normal! <CR>q:')
      vim.cmd('normal! ' .. vim.g.CmdWindowLineMark .. 'G')
    end, { buffer = true })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip45)
***
# Title: Auto-Close Quickfix Window When Last Buffer
# Category: autocmds
# Tags: window-management, quickfix, buffer-cleanup
---
Automatically close Vim/Neovim when the quickfix window is the last open window, keeping your editor clean after completing tasks like compilation or search results

```vim
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  if &buftype=="quickfix"
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.buftype == 'quickfix' and vim.fn.winnr('$') == 1 then
      vim.cmd('quit')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip536)
***
# Title: Handle File Change Notifications Safely
# Category: autocmds
# Tags: file-handling, error-management, autocmd
---
Safely handle file change events and ensure proper cleanup of autocmds after file modification

```vim
checktime
exe "au FileChangedShell " . expand("%") . " let &cpo = &cpo"
" Do stuff to the file.
checktime
exe "au! FileChangedShell " . expand("%")
```

```lua
vim.cmd('checktime')
vim.cmd(string.format('au FileChangedShell %s let &cpo = &cpo', vim.fn.expand('%')))
-- Do stuff to the file
vim.cmd('checktime')
vim.cmd(string.format('au! FileChangedShell %s', vim.fn.expand('%')))
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip595)
***
# Title: Automated PHP Syntax Checking on Write
# Category: autocmds
# Tags: php, syntax-checking, autocmd
---
Automatically check PHP syntax before saving the file, preventing syntax errors

```vim
au! BufWriteCmd *.php call PHPsynCHK()

function! PHPsynCHK()
  ccl
  let winnum = winnr()
  silent execute "%!php -l -f /dev/stdin | sed 's/\/dev\/stdin/".bufname("%").("/g') >.vimerr; cat"
  silent cf .vimerr
  cw
  execute winnum . "wincmd w"
  silent undo
  silent cf
  if 1 == len(getqflist())
    w
  endif
endfunction
```

```lua
vim.api.nvim_create_autocmd('BufWriteCmd', {
  pattern = '*.php',
  callback = function()
    vim.cmd('ccl')
    local winnum = vim.fn.winnr()
    -- Note: This is a direct translation and might need refinement
    vim.cmd("silent execute '%!php -l -f /dev/stdin | sed 's/\/dev\/stdin/" .. vim.fn.bufname('%') .. "/g' >.vimerr; cat'")
    vim.cmd('silent cf .vimerr')
    vim.cmd('cw')
    vim.cmd(winnum .. 'wincmd w')
    vim.cmd('silent undo')
    vim.cmd('silent cf')
    if #vim.fn.getqflist() == 1 then
      vim.cmd('w')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip692)
***
