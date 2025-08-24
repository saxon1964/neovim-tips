# Title: Auto-save on focus lost
# Category: Autocommands  
# Tags: autocmd, FocusLost, auto-save, backup
---
Use `FocusLost` autocommand to automatically save all buffers when vim loses focus.

#### Example

```vim
:autocmd FocusLost * :wa
" Auto-save all buffers when switching away from vim
```
===
# Title: Auto-reload changed files
# Category: Autocommands
# Tags: autocmd, checktime, FileChangedShellPost, reload
---
Use `FileChangedShellPost` and `checktime` to automatically reload files changed by external programs.

#### Example

```vim
:set autoread
:autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
:autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
```
===
# Title: Remove trailing whitespace on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, whitespace, cleanup
---
Use `BufWritePre` autocommand to automatically remove trailing whitespace before saving files.

#### Example

```vim
:autocmd BufWritePre * :%s/\s\+$//e
" Remove trailing whitespace on all file saves
" 'e' flag prevents error if no matches found
```
===
# Title: Create directory on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, mkdir, directory
---
Use `BufWritePre` to automatically create parent directories when saving files to new paths.

#### Example

```vim
:autocmd BufWritePre * call mkdir(expand('<afile>:p:h'), 'p')
" Creates parent directories if they don't exist
" 'p' creates intermediate directories like mkdir -p
```
===
# Title: Jump to last cursor position
# Category: Autocommands
# Tags: autocmd, BufReadPost, cursor, position
---
Use `BufReadPost` to automatically jump to the last known cursor position when reopening files.

#### Example

```vim
:autocmd BufReadPost * 
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Jumps to last position if it exists and is valid
```
===
# Title: Set file type based on content
# Category: Autocommands
# Tags: autocmd, BufRead, filetype, detection
---
Use `BufRead` autocommands to set file types based on file content or patterns not caught by default detection.

#### Example

```vim
:autocmd BufRead,BufNewFile *.conf set filetype=conf
:autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy  
:autocmd BufRead * if getline(1) =~ '^#!/usr/bin/env python' | set ft=python | endif
```
===
# Title: Auto-format code on save
# Category: Autocommands
# Tags: autocmd, BufWritePre, format, lsp
---
Use `BufWritePre` with LSP or external formatters to automatically format code before saving.

#### Example

```vim
:autocmd BufWritePre *.js,*.ts,*.jsx,*.tsx lua vim.lsp.buf.format()
:autocmd BufWritePre *.py !black %
:autocmd BufWritePre *.go !gofmt -w %
" Format different file types with appropriate tools
```
===
# Title: Highlight long lines
# Category: Autocommands
# Tags: autocmd, ColorColumn, textwidth, highlight
---
Use autocommands to dynamically highlight long lines or set color column based on file type.

#### Example

```vim
:autocmd FileType python setlocal colorcolumn=88
:autocmd FileType javascript,typescript setlocal colorcolumn=100
:autocmd FileType gitcommit setlocal colorcolumn=72
" Set different line length limits per file type
```
===
# Title: Auto-compile on save
# Category: Autocommands
# Tags: autocmd, BufWritePost, compile, build
---
Use `BufWritePost` to automatically compile or build files after saving them.

#### Example

```vim
:autocmd BufWritePost *.c,*.cpp !gcc % -o %:r
:autocmd BufWritePost *.tex !pdflatex %
:autocmd BufWritePost init.lua source %
" Compile C files, build LaTeX, reload Lua config
```
===
# Title: Show cursor line only in active window
# Category: Autocommands
# Tags: autocmd, WinEnter, WinLeave, cursorline
---
Use `WinEnter` and `WinLeave` to show cursor line highlighting only in the active window.

#### Example

```vim
:autocmd WinEnter * set cursorline
:autocmd WinLeave * set nocursorline
" Cursor line only visible in focused window
```
===
# Title: Auto-resize windows on terminal resize
# Category: Autocommands
# Tags: autocmd, VimResized, windows, resize
---
Use `VimResized` autocommand to automatically redistribute window sizes when terminal is resized.

#### Example

```vim
:autocmd VimResized * wincmd =
" Equalizes window sizes when vim is resized
" Useful when terminal window size changes
```
===
# Title: Change directory to current file
# Category: Autocommands
# Tags: autocmd, BufEnter, cd, directory
---
Use `BufEnter` to automatically change working directory to the current file's directory.

#### Example

```vim
:autocmd BufEnter * cd %:p:h
" Always work in current file's directory
" Alternative: use 'autochdir' option
:set autochdir  " same effect as above
```
===
# Title: Template insertion for new files
# Category: Autocommands
# Tags: autocmd, BufNewFile, template, skeleton
---
Use `BufNewFile` to automatically insert templates or skeleton code for new files.

#### Example

```vim
:autocmd BufNewFile *.html 0r ~/.vim/templates/html_template.html
:autocmd BufNewFile *.py 0r ~/.vim/templates/python_template.py
:autocmd BufNewFile *.sh 0put ='#!/bin/bash' | $put ='' | 1
```
===
# Title: Auto-toggle relative numbers
# Category: Autocommands
# Tags: autocmd, InsertEnter, InsertLeave, relativenumber
---
Use insert mode events to toggle relative line numbers, showing absolute numbers in insert mode.

#### Example

```vim
:autocmd InsertEnter * set norelativenumber
:autocmd InsertLeave * set relativenumber
" Absolute numbers in insert mode, relative in normal mode
```
===
# Title: Spell check for specific file types
# Category: Autocommands
# Tags: autocmd, FileType, spell, markdown
---
Use `FileType` autocommands to enable spell checking for text-based file types automatically.

#### Example

```vim
:autocmd FileType markdown,text,gitcommit set spell spelllang=en_us
:autocmd FileType help set nospell
" Enable spell check for text files, disable for help
```
===
# Title: Auto-close quickfix window
# Category: Autocommands
# Tags: autocmd, QuickFixCmdPost, quickfix, close
---
Use `QuickFixCmdPost` to automatically close quickfix window when it's empty or open it when populated.

#### Example

```vim
:autocmd QuickFixCmdPost [^l]* copen
:autocmd QuickFixCmdPost l* lopen
" Auto-open quickfix/location list after commands
" Close if empty: :autocmd QuickFixCmdPost * if len(getqflist()) == 0 | cclose | endif
```
===
# Title: Highlight yanked text
# Category: Autocommands
# Tags: autocmd, TextYankPost, highlight, yank
---
Use `TextYankPost` to briefly highlight yanked text, making copy operations more visible.

#### Example

```vim
:autocmd TextYankPost * silent! lua vim.highlight.on_yank()
" In vimscript: 
:autocmd TextYankPost * silent! call matchadd('Search', @", 86400)
:autocmd TextYankPost * silent! call timer_start(150, {-> clearmatches()})
```
===
# Title: Auto-backup important files
# Category: Autocommands
# Tags: autocmd, BufWritePre, backup, copy
---
Use `BufWritePre` to create timestamped backups of important configuration files before saving.

#### Example

```vim
:autocmd BufWritePre .vimrc,init.lua,init.vim 
    \ execute 'write! ' . expand('%') . '.backup.' . strftime('%Y%m%d_%H%M%S')
" Creates timestamped backups of config files
```
===
# Title: Set indent based on file type
# Category: Autocommands
# Tags: autocmd, FileType, indent, tabstop
---
Use `FileType` autocommands to set language-specific indentation and tab settings.

#### Example

```vim
:autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
:autocmd FileType javascript,json setlocal tabstop=2 shiftwidth=2 expandtab
:autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
```
===
# Title: Auto-chmod executable scripts
# Category: Autocommands
# Tags: autocmd, BufWritePost, chmod, executable
---
Use `BufWritePost` to automatically make shell scripts executable after saving them.

#### Example

```vim
:autocmd BufWritePost *.sh,*.py,*.pl,*.rb silent !chmod +x %
:autocmd BufWritePost * 
    \ if getline(1) =~ "^#!" | 
    \   silent !chmod +x % | 
    \ endif
" Make files with shebang executable
```
===