# Title: Virtual editing mode
# Category: Configuration
# Tags: virtualedit, cursor, beyond, eol
---
Use `set virtualedit=all` to allow cursor movement beyond end of lines, useful for block editing and column alignment.

```vim
:set virtualedit=all    " cursor can go anywhere
:set virtualedit=block  " only in visual block mode
:set virtualedit=insert " only in insert mode
```

Or:

```lua
vim.opt.virtualedit = 'all'
vim.opt.virtualedit = 'block'
vim.opt.virtualedit = 'insert'
vim.opt.virtualedit = "block,insert"
```
***
# Title: Wildmenu enhanced completion
# Category: Configuration
# Tags: wildmenu, completion, cmdline, enhanced
---
Use `set wildmenu` with `set wildmode=longest:full,full` for enhanced command-line completion with visual menu.

```vim
:set wildmenu
:set wildmode=longest:full,full
" Now tab completion shows visual menu with options
```

Or:

```lua
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,full"
```
***
# Title: Persistent undo across sessions
# Category: Configuration
# Tags: undofile, persistent, undo, history
---
Use `set undofile` to maintain undo history across vim sessions. Set `undodir` to control where undo files are stored.

```vim
:set undofile
:set undodir=~/.vim/undodir
" Undo history persists even after closing files
```

Or:

```lua
vim.opt.undofile = true
vim.opt.undodir = '~/.vim/undodir
```
***
# Title: Smart case searching
# Category: Configuration
# Tags: ignorecase, smartcase, search, intelligent
---
Use `set ignorecase smartcase` for intelligent case handling - ignore case unless uppercase letters are typed.

```vim
:set ignorecase smartcase
" /hello matches Hello, HELLO, hello
" /Hello only matches Hello, HELLO
```

Or:

```lua
vim.opt.ignorecase = 'smartcase'
```
***
# Title: Show invisible characters
# Category: Configuration
# Tags: listchars, invisible, whitespace, tabs
---
Use `set list listchars=tab:>\  ,eol:$,trail:.,space:.` to visualize invisible characters like tabs, spaces, and line endings.

```vim
:set list
:set listchars=tab:>\ ,eol:$,trail:.,space:.
" Shows tabs as >, line endings as $, trailing spaces as .
```

Or:

```lua
vim.opt.list = true
vim.opt.listchars = 'tab:> ,eol:$,trail:.,space:.'
```
***
# Title: Incremental command preview
# Category: Configuration
# Tags: inccommand, preview, substitute, live
---
Use `set inccommand=split` to preview substitute commands in real-time with a split window showing changes.

```vim
:set inccommand=split
" Now :%s/old/new/g shows live preview in split
:set inccommand=nosplit  " preview inline without split
```

Or:

```lua
vim.opt.inccommand = 'split'
vim.opt.inccommand = 'nosplit'
```
***
# Title: Mouse support in terminal
# Category: Configuration
# Tags: mouse, terminal, scroll, select
---
Use `set mouse=a` to enable full mouse support in terminal Neovim for scrolling, selecting, and window operations.

```vim
:set mouse=a          " enable mouse in all modes
:set mouse=n          " only in normal mode
:set mouse=           " disable mouse completely
```

Or:

```lua
vim.opt.mouse = 'a'
vim.opt.mouse = 'n'
vim.opt.mouse = ''
```
***
# Title: Automatic text wrapping
# Category: Configuration
# Tags: textwidth, wrap, formatoptions, auto
---
Use `set textwidth=80` with appropriate `formatoptions` to automatically wrap text at specified column width.

```vim
:set textwidth=80
:set formatoptions+=t    " auto-wrap text using textwidth
:set formatoptions+=c    " auto-wrap comments
:set formatoptions+=r    " continue comments on new line
```

Or:

```lua
vim.opt.textwidth = 80
vim.opt.formatoptions += t
vim.opt.formatoptions += c
vim.opt.formatoptions += r
```
***
# Title: Show line numbers relatively
# Category: Configuration
# Tags: relativenumber, number, navigation, jumping
---
Use `set relativenumber` with `set number` to show both absolute and relative line numbers for easier navigation.

```vim
:set number relativenumber
" Shows current line number and relative distances
" Useful for commands like 5j, 3k
```

Or:

```lua
vim.opt.number = true
vim.opt.relativenumber = true
```
***
# Title: Spell checking configuration
# Category: Configuration
# Tags: spell, spellfile, spelllang, dictionary
---
Use `set spell spelllang=en_us` to enable spell checking and configure custom word lists with `spellfile`.

```vim
:set spell spelllang=en_us
:set spellfile=~/.config/nvim/spell/en.utf-8.add
" zg adds word under cursor to personal dictionary
" z= shows spelling suggestions
```

Or:

```lua
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spellfile = '~/.config/nvim/spell/en.utf-8.add'
```
***
# Title: Automatic session restoration
# Category: Configuration
# Tags: sessionoptions, session, restore, automatic
---
Use `set sessionoptions` to control what gets saved in sessions, enabling automatic workspace restoration.

```vim
:set sessionoptions=buffers,curdir,folds,help,tabpages,winsize,winpos
:mksession! ~/mysession.vim    " save session
:source ~/mysession.vim        " restore session
```

Or:

```lua
vim.opt.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos'
-- :mksession! ~/mysession.vim    " save session
-- :source ~/mysession.vim        " restore session
```
***
# Title: Diff options configuration
# Category: Configuration
# Tags: diffopt, diff, comparison, algorithm
---
Use `set diffopt` to configure diff behavior, including algorithm choice and display options for better file comparison.

```vim
:set diffopt=internal,filler,closeoff,hiddenoff,algorithm:patience
" internal: use internal diff engine
" filler: show filler lines
" algorithm:patience: use patience diff algorithm
```

Or:

```lua
vim.opt.diffopt = 'internal,filler,closeoff,hiddenoff,algorithm:patience'
```
***
# Title: Clipboard integration
# Category: Configuration
# Tags: clipboard, unnamed, system, copy
---
Use `set clipboard=unnamedplus` to automatically use system clipboard for yank and paste operations.

```vim
:set clipboard=unnamedplus     " use system clipboard
:set clipboard=unnamed         " use * register (X11 primary)
:set clipboard=unnamed,unnamedplus  " use both
```

Or:

```lua
vim.opt.clipboard = 'unnamedplus'
vim.opt.clipboard = 'unnamed'
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
```
***
# Title: Search highlighting timeout
# Category: Configuration
# Tags: hlsearch, timeout, highlight, search
---
Use `set hlsearch` with timeouts to automatically clear search highlighting after inactivity.

```vim
:set hlsearch
" Add to vimrc to clear highlighting after 5 seconds:
:autocmd CursorHold * set nohlsearch
:autocmd CmdlineEnter /,\? set hlsearch
```

Or:

```lua
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd('CursorHold', {
    pattern = '*',
    command = 'set nohlsearch'
})

vim.api.nvim_create_autocmd('CmdLineEnter', {
    pattern = { '/', '?' },
    command = 'set hlsearch'
})
```
***
# Title: Complete options configuration
# Category: Configuration
# Tags: completeopt, completion, popup, menu
---
Use `set completeopt=menu,menuone,noselect,preview` to configure completion popup behavior and appearance.

```vim
:set completeopt=menu,menuone,noselect,preview
" menu: show popup menu
" menuone: show menu even for single match
" noselect: don't auto-select first item
" preview: show extra info in preview window
```

Or:

```lua
vim.opt.completeopt = 'menu,menuone,noselect,preview'
```
***
# Title: Fold column display
# Category: Configuration
# Tags: foldcolumn, fold, display, gutter
---
Use `set foldcolumn=4` to display fold indicators in a dedicated column, making fold structure visible.

```vim
:set foldcolumn=4     " show fold column with width 4
:set foldcolumn=0     " hide fold column
" Shows +/- indicators for folded code blocks
```

Or:

```lua
vim.opt.foldcolumn = 4
vim.opt.foldcolumn = 0
```
***
# Title: Cursor line and column
# Category: Configuration
# Tags: cursorline, cursorcolumn, highlight, position
---
Use `set cursorline cursorcolumn` to highlight current cursor position with line and column indicators.

```vim
:set cursorline       " highlight current line
:set cursorcolumn     " highlight current column
:set cursorline!      " toggle cursorline
```

Or:

```lua
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
```
***
# Title: Line break at word boundaries
# Category: Configuration
# Tags: linebreak, breakat, word, wrap
---
Use `set linebreak` with `set breakat` to wrap long lines at word boundaries rather than character boundaries.

```vim
:set linebreak
:set breakat=\ \t!@*-+;:,./?   " break at these characters
:set showbreak=>>\              " show symbol at wrapped lines
```

Or:

```lua
vim.opt.linebreak = true
vim.opt.breakeat = ' \t!@*-+;:,./?'
vim.opt.showbreak = '>> '
```
***
# Title: Scroll context lines
# Category: Configuration
# Tags: scrolloff, sidescrolloff, context, buffer
---
Use `set scrolloff=8 sidescrolloff=8` to maintain context lines around cursor when scrolling vertically and horizontally.

```vim
:set scrolloff=8        " keep 8 lines above/below cursor
:set sidescrolloff=8    " keep 8 columns left/right of cursor
:set scrolloff=999      " keep cursor centered (max context)
```

Or:

```lua
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 999
```
***
# Title: Backup and swap file locations
# Category: Configuration
#ags: backupdir, directory, swap, backup
---
Use `set backupdir` and `set directory` to organize backup and swap files in dedicated directories.

```vim
:set backupdir=~/.vim/backup//
:set directory=~/.vim/swap//
:set undodir=~/.vim/undo//
" // at end means use full path for unique filenames
```

Or:

```lua
vim.opt.backupdir = '~/.vim/backup//'
vim.opt.directory = '~/.vim/swap//'
vim.opt.undodir = '~/.vim/undo//'
```
***
