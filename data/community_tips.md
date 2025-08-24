# Title: Dynamic plugin management
# Category: Configuration
# Tags: lazy, plugin, dynamic, management
---
Use dynamic plugin installation and loading patterns inspired by TJ DeVries for self-bootstrapping configurations.

#### Example

```vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
```
===
# Title: Environment-aware configuration
# Category: Configuration
# Tags: environment, conditional, config, dotenv
---
Use environment variables and conditional loading for portable configurations across different machines.

#### Example

```vim
" Load local environment variables
if filereadable(expand('~/.config/nvim/.env'))
  for line in readfile(expand('~/.config/nvim/.env'))
    let env_var = split(line, '=')
    if len(env_var) >= 2
      execute 'let $' . env_var[0] . '="' . join(env_var[1:], '=') . '"'
    endif
  endfor
endif
```
===
# Title: Modular configuration loading
# Category: Configuration
# Tags: modular, import, require, organization
---
Use Lua's require system with custom import directories for organized, modular configuration management.

#### Example

```vim
-- Structure: ~/.config/nvim/lua/custom/
require('lazy').setup({
  { import = "custom.plugins" },  -- loads plugins from custom/plugins/
  { import = "custom.lsp" },      -- loads LSP configs from custom/lsp/
}, {
  change_detection = { notify = false }
})
```
===
# Title: Help in new tab workflow
# Category: Workflow
# Tags: help, tab, workflow, reference
---
Use custom mapping to open help documentation in new tabs for better reference workflow during coding.

#### Example

```vim
:nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>
" Opens help in new tab, focuses on help content, closes empty buffer
" Provides dedicated space for documentation reference
```
===
# Title: Insert mode line manipulation
# Category: Editing
# Tags: insert, line, manipulation, efficiency
---
Use Alt key combinations to add new lines above/below without leaving insert mode or changing cursor position.

#### Example

```vim
:inoremap <M-o> <Esc>o<Esc>a    " add line below, return to insert
:inoremap <M-O> <Esc>O<Esc>a    " add line above, return to insert
" Maintains flow during writing/coding without mode switches
```
===
# Title: Advanced completion shortcuts
# Category: Completion
# Tags: completion, ctrl-x, advanced, shortcuts
---
Use Ctrl+X completion modes for different types of intelligent completion in insert mode.

#### Example

```vim
" In insert mode:
Ctrl+x Ctrl+p  " word completion with suggestions
Ctrl+x Ctrl+l  " complete entire lines
Ctrl+x Ctrl+k  " dictionary word completion  
Ctrl+x Ctrl+]  " tag-based completion
Ctrl+x Ctrl+f  " filename completion
Ctrl+x Ctrl+o  " omni completion (context-aware)
```
===
# Title: Efficient whitespace cleanup
# Category: Text Manipulation
# Tags: whitespace, cleanup, trailing, efficiency
---
Use F-key mapping for instant trailing whitespace removal with user feedback across entire buffer.

#### Example

```vim
:noremap <F5> :%s/\s\+$//<CR>:echo 'All trailing whitespace removed.'<CR>
" One key press to clean entire file and confirm action
" Works in any mode, provides immediate feedback
```
===
# Title: Builtin completion without plugins
# Category: Completion
# Tags: builtin, completion, native, plugin-free
---
Use Neovim's built-in completion capabilities for intelligent code completion without external plugins.

#### Example

```vim
:set completeopt=menu,menuone,noselect,preview
:inoremap <Tab> <C-n>
:inoremap <S-Tab> <C-p>
" Ctrl+n/Ctrl+p for next/previous completion
" Ctrl+x Ctrl+o for omni completion (language-aware)
```
===
# Title: Command-line window editing
# Category: Command Line
# Tags: command, window, editing, history
---
Use command-line window for advanced command history editing and complex command construction.

#### Example

```vim
q:  " open command history in editable window
q/  " open search history in editable window  
q?  " open search history (backward) in editable window
" Edit commands like regular text, press Enter to execute
" Navigate with vim motions, make complex edits
```
===
# Title: Visual line operations
# Category: Visual
# Tags: visual, line, operations, block
---
Use visual line mode and block mode for efficient multi-line text manipulation and formatting.

#### Example

```vim
V       " select entire lines
Ctrl+v  " visual block mode for column operations
gv      " reselect last visual selection
:'<,'>normal @q  " run macro on visual selection
:'<,'>s/old/new/g  " substitute within selection only
```
===
# Title: Buffer-specific settings
# Category: Configuration
# Tags: buffer, specific, settings, local
---
Use buffer-local settings and autocmds for file-type specific configurations and optimizations.

#### Example

```vim
:autocmd BufEnter *.lua setlocal tabstop=2 shiftwidth=2
:autocmd BufEnter *.py setlocal tabstop=4 shiftwidth=4
:autocmd BufEnter *.md setlocal textwidth=80 spell
" File-specific settings without global impact
```
===
# Title: Quick fold navigation
# Category: Folding
# Tags: fold, navigation, quick, movement
---
Use fold navigation commands for efficient code structure navigation and overview.

#### Example

```vim
zj  " move to next fold
zk  " move to previous fold  
[z  " move to start of current fold
]z  " move to end of current fold
zv  " view cursor line (unfold if needed)
zx  " update folds
```
===
# Title: Register operations mastery
# Category: Registers
# Tags: registers, operations, advanced, clipboard
---
Use register operations for sophisticated copy-paste workflows and text manipulation chains.

#### Example

```vim
"ay5y    " yank 5 lines into register 'a'
"Ay3y    " append 3 lines to register 'a'
"ap      " paste contents of register 'a'
:reg a   " view contents of register 'a'
:let @a='new text'  " set register 'a' programmatically
```
===
# Title: Motion-based editing patterns
# Category: Movement
# Tags: motion, editing, patterns, efficiency
---
Use motion commands combined with operators for efficient text editing patterns and muscle memory.

#### Example

```vim
ci"     " change inside quotes
ca(     " change around parentheses  
di}     " delete inside braces
ya]     " yank around brackets
viw     " visually select inner word
vap     " visually select around paragraph
```
===
# Title: Session workflow optimization
# Category: Session
# Tags: session, workflow, project, management
---
Use session commands for project-based workflow management and context switching.

#### Example

```vim
:mksession! ~/project.vim     " save current session
:source ~/project.vim         " load session
:SSave project_name           " save with plugin session manager
:SLoad project_name           " load named session
" Restore window layouts, open files, cursor positions
```
===
# Title: Tab-based workflow
# Category: Tabs
# Tags: tabs, workflow, organization, navigation
---
Use tabs for logical grouping of related files and context-based editing workflows.

#### Example

```vim
:tabnew file.lua              " open file in new tab
:tabonly                      " close all other tabs
gt / gT                       " navigate between tabs
<C-w>T                        " move current window to new tab
:tabmove 2                    " move tab to position 2
```
===
# Title: Split window mastery
# Category: Windows
# Tags: split, windows, mastery, layout
---
Use advanced window splitting and management for efficient multi-file editing and reference workflows.

#### Example

```vim
:vsplit file.txt              " vertical split
:split +/pattern file.txt     " split and search
<C-w>r                        " rotate windows
<C-w>H                        " move window to left
<C-w>=                        " equalize window sizes
<C-w>_                        " maximize window height
```
===
# Title: Command abbreviations
# Category: Command Line
# Tags: abbreviations, shortcuts, efficiency, typos
---
Use command abbreviations for frequently used commands and common typo corrections.

#### Example

```vim
:cabbrev W w
:cabbrev Wq wq
:cabbrev Q q
:cabbrev vsf vert sfind
:cabbrev ff find **/*
" Corrects common typos and creates shortcuts
```
===
# Title: Insert mode navigation
# Category: Insert
# Tags: insert, navigation, movement, efficiency
---
Use insert mode navigation keys for efficient editing without leaving insert mode frequently.

#### Example

```vim
<C-h>   " backspace (delete left)
<C-w>   " delete word left  
<C-u>   " delete to beginning of line
<C-t>   " indent current line
<C-d>   " unindent current line
<C-o>   " execute one normal mode command
```
===
# Title: Search and replace workflow
# Category: Search
# Tags: search, replace, workflow, confirmation
---
Use interactive search and replace workflow for safe bulk text modifications with preview.

#### Example

```vim
:%s/old/new/gc                " replace with confirmation
:%s/old/new/gn                " count matches without replacing
:set hlsearch                 " highlight matches
:set incsearch                " incremental search
/old<CR>cgnnew<Esc>           " search, change next match
. . .                         " repeat with dot command
```
===
# Title: Mark-based navigation workflow
# Category: Marks
# Tags: marks, navigation, workflow, jumping
---
Use marks for efficient navigation between important locations in large files and projects.

#### Example

```vim
ma      " set mark 'a' at current position
'a      " jump to line of mark 'a'
`a      " jump to exact position of mark 'a'  
:marks  " list all marks
mA      " set global mark 'A' (across files)
'A      " jump to global mark 'A'
```
===