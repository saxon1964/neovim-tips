# Title: Set system clipboard from Lua
# Category: Clipboard
# Tags: clipboard, lua, register
---
Integrate Vim with macOS clipboard using pbcopy and pbpaste utilities.

```vim
" Vimscript - macOS clipboard integration
vnoremap <C-c> :w !pbcopy<CR><CR>
nnoremap <C-v> :r !pbpaste<CR>

" Use system clipboard by default
set clipboard=unnamed
```

```lua
-- Lua - macOS clipboard integration
vim.keymap.set('v', '<C-c>', ':w !pbcopy<CR><CR>', { desc = 'Copy to macOS clipboard' })
vim.keymap.set('n', '<C-v>', ':r !pbpaste<CR>', { desc = 'Paste from macOS clipboard' })

-- Use system clipboard by default
vim.opt.clipboard = 'unnamed'
```

**Source:** Community contributed
***
# Title: System clipboard: handling yank and delete motions differently
# Category: Clipboard
# Tags: clipboard, copy, paste
---
Integrating system clipboard with Neovim is easy:
All yanked and deleted content will go to the default register and also to system clipboard. That's the most common setup.
But, suppose that you want yank and delete motions to behave slightly differently with respect to system clipboard. For example, you want all yanked text to go to the unnamed register and to system clipboard. But in case of delete motions, you don't want to affect system clipboard, only the default registry (quite popular setup). The setup is fairly easy. Just add the following lines to your `init.lua` configuration file:
Yanked text goes to system register AND clipboard. Deleted text goes to system register only and leaves system clipboard attached.

```lua
vim.o.clipboard="unnamedplus"

-- Don't mention system clipboard,
-- it won't be affected wuthout the `TextYankPost` callback
vim.o.clipboard = ""

-- Copy yanked text to system clipboard.
-- This callback is involed after each yank/delete operation
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- Only trigger on yanks
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      -- "+" stands for system clipboard
      vim.fn.setreg("+", vim.fn.getreg('"'))
      vim.fn.setreg("+", vim.fn.getreg('"', 1)) -- also yank visual selection
    end
  end,
})
```

**Source:** Community contributed
***
# Title: Preserve register when pasting over selection
# Category: Clipboard
# Tags: paste, register, yank, visual, black-hole
---
When pasting over a visual selection, the deleted text normally replaces the unnamed register. Use the black hole register to preserve your yanked content.

```vim
" In vimscript:
xnoremap p "_dP
" This deletes to black hole register (_) then pastes
```

```lua
-- Paste without losing the yanked content
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking", noremap = true })

-- Alternative: use a specific register
vim.keymap.set("x", "<leader>p", '"0p', { desc = "Paste from yank register", noremap = true })
```

**Source:** Community contributed
***
# Title: Copy Entire Buffer to Clipboard
# Category: clipboard
# Tags: registers, copy, clipboard
---
Automatically copy mouse-selected text to system clipboard in Vim/Neovim

```vim
" Method 1 (for X11 and Windows)
:noremap <LeftRelease> "+y<LeftRelease>

" Method 2 (Windows only)
:set guioptions+=a
```

```lua
-- Method 1: Map mouse release to copy
vim.keymap.set('n', '<LeftRelease>', '"+y<LeftRelease>', { noremap = true })

-- Method 2: Enable auto-copy option
vim.o.guioptions = vim.o.guioptions .. 'a'
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_copy_the_mouse_selection)
***
# Title: Disable Auto Copy Clipboard Function
# Category: clipboard
# Tags: configuration, clipboard, settings
---
Use '+' and '*' registers to interact with system clipboard across different platforms

```vim
" Copy entire buffer to system clipboard
gg"+yG

" Paste from system clipboard
"+p

" Set clipboard as default register
set clipboard=unnamed
" For X Window systems
set clipboard=unnamedplus
```

```lua
-- Copy entire buffer to system clipboard
vim.api.nvim_command('normal! gg"+yG')

-- Paste from system clipboard
vim.api.nvim_put(vim.fn.getreg('+'), 'c', true, true)

-- Set clipboard as default register
vim.opt.clipboard = 'unnamed' -- For Windows
vim.opt.clipboard = 'unnamedplus' -- For X Window systems
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Clipboard)
***
# Title: Swap Between Vim and System Clipboard
# Category: clipboard
# Tags: register-management, clipboard, cross-system
---
Access system clipboard using + and * registers in Vim/Neovim

```vim
"+y  " copy to system clipboard
"+p  " paste from system clipboard
```

```lua
-- Ensure clipboard support is compiled in
vim.opt.clipboard = 'unnamedplus'  -- Use system clipboard

-- Copy and paste using system clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copy,_cut_and_paste)
***
# Title: Cross-Session Clipboard Sharing
# Category: clipboard
# Tags: registers, clipboard, cross-session
---
Copy and paste between multiple Vim/Neovim sessions using a temporary file or register

```vim
let g:session_yank_file="~/.vim_yank"
map <silent> <Leader>y :call Session_yank()<CR>
vmap <silent> <Leader>y y:call Session_yank()<CR>

function Session_yank()
  new
  call setline(1,getregtype())
  put
  silent exec 'wq! ' . g:session_yank_file
  exec 'bdelete ' . g:session_yank_file
endfunction

function Session_paste(command)
  silent exec 'sview ' . g:session_yank_file
  let l:opt=getline(1)
  silent 2,$yank
  call setreg('"', @", l:opt)
  exec 'bdelete ' . g:session_yank_file
  exec 'normal ' . a:command
endfunction
```

```lua
local session_yank_file = vim.fn.expand('~/.vim_yank')

local function session_yank()
  vim.cmd('new')
  vim.fn.setline(1, vim.fn.getregtype())
  vim.cmd('put')
  vim.fn.writefile(vim.fn.getline(1, '$'), session_yank_file)
  vim.cmd('bdelete ' .. session_yank_file)
end

local function session_paste(command)
  vim.cmd('sview ' .. session_yank_file)
  local opt = vim.fn.getline(1)
  vim.cmd('2,$yank')
  vim.fn.setreg('"', vim.fn.getreg('"'), opt)
  vim.cmd('bdelete ' .. session_yank_file)
  vim.cmd('normal ' .. command)
end

-- Add keymaps to use these functions
vim.keymap.set('n', '<Leader>y', session_yank, { desc = 'Yank to session file' })
vim.keymap.set('n', '<Leader>p', function() session_paste('p') end, { desc = 'Paste from session file' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copy_and_paste_between_Vim_instances)
***
# Title: Using System Clipboard Registers
# Category: clipboard
# Tags: registers, clipboard, system-clipboard
---
Use system clipboard registers to copy and paste between Vim instances

```vim
" Copy current line to clipboard
"*yy

" Paste from clipboard
"*p
```

```lua
-- Copy current line to clipboard
vim.fn.setreg('*', vim.fn.getline('.'))

-- Paste from clipboard
vim.cmd('normal "*p')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copy_and_paste_between_Vim_instances)
***
# Title: Copy Filename to Clipboard
# Category: clipboard
# Tags: file-operations, key-mapping, clipboard
---
Quickly copy current file's name or full path to system clipboard using custom key mappings

```vim
" Copy filename mappings
" Short filename
nmap ,cs :let @*=expand("%")<CR>
" Full path
nmap ,cl :let @*=expand("%:p")<CR>
```

```lua
-- Copy filename to clipboard
vim.keymap.set('n', ',cs', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy short filename' })

vim.keymap.set('n', ',cl', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy full file path' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copy_current_file_name_into_windows_clipboard)
***
# Title: Cross-Platform Filename Copying
# Category: clipboard
# Tags: cross-platform, file-operations, clipboard
---
Platform-specific clipboard handling for Windows and Unix-like systems, including conversion of path separators

```vim
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif
```

```lua
if vim.fn.has('win32') == 1 then
  vim.keymap.set('n', ',cs', function()
    local filename = vim.fn.expand('%'):gsub('/', '\\')
    vim.fn.setreg('*', filename)
  end)
  vim.keymap.set('n', ',cl', function()
    local filepath = vim.fn.expand('%:p'):gsub('/', '\\')
    vim.fn.setreg('*', filepath)
  end)
else
  vim.keymap.set('n', ',cs', function()
    vim.fn.setreg('*', vim.fn.expand('%'))
  end)
  vim.keymap.set('n', ',cl', function()
    vim.fn.setreg('*', vim.fn.expand('%:p'))
  end)
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copy_filename_to_clipboard)
***
# Title: Copy to Windows Clipboard in Cygwin Vim
# Category: clipboard
# Tags: cross-platform, system-clipboard, utilities
---
Function to paste text from Windows clipboard into Vim using /dev/clipboard device

```vim
function! Getclip()
  let reg_save = @@
  let @@ = join(readfile('/dev/clipboard'), "\n")
  setlocal paste
  exe 'normal p'
  setlocal nopaste
  let @@ = reg_save
endfunction

nnoremap <silent> <leader>p :call Getclip()<CR>
```

```lua
function Getclip()
  local reg_save = vim.fn.getreg('@')
  local clipboard_content = table.concat(vim.fn.readfile('/dev/clipboard'), '\n')
  
  vim.o.paste = true
  vim.fn.setreg('@', clipboard_content)
  vim.cmd('normal! p')
  vim.o.paste = false
  
  vim.fn.setreg('@', reg_save)
end

vim.keymap.set('n', '<leader>p', Getclip)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Copying_to_the_Windows_clipboard_from_Cygwin_vim)
***
# Title: Easy Windows Clipboard Interaction
# Category: clipboard
# Tags: clipboard, register, cross-platform
---
Simplify clipboard operations between Vim and Windows applications by automatically syncing the unnamed register with the system clipboard

```vim
set clipboard=unnamed
```

```lua
vim.opt.clipboard = 'unnamed'
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Easy_pasting_to_Windows_applications)
***
# Title: Automatic Visual Selection Clipboard Copy
# Category: clipboard
# Tags: clipboard, visual-mode, gui
---
Automatically copy visual selections to clipboard, allowing easy pasting in other applications

```vim
set go+=a
```

```lua
vim.opt.guioptions:append('a')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Easy_pasting_to_Windows_applications)
***
# Title: Quick External Paste Buffer Editing
# Category: clipboard
# Tags: paste-buffer, external-editing, clipboard
---
Quickly open a Vim buffer containing the current clipboard contents for editing, automatically updating the clipboard on save

```vim
function vxp()
  # Edit paste contents
  gvim -c 'normal ggdG"*p' c:/aaa/xp
endfunction

# In vimrc
autocmd bufWritePost c:/aaa/xp normal ggVG"*y
```

```lua
function _G.edit_paste_buffer()
  -- Open a new buffer with clipboard contents
  vim.cmd('gvim -c "normal! ggdG\"*p" c:/aaa/xp')
end

-- Automatically copy buffer contents back to clipboard on save
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'c:/aaa/xp',
  callback = function()
    vim.cmd('normal! ggVG"*y')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/External_paste_buffer)
***
# Title: Use xclip for Efficient Linux Clipboard Operations
# Category: clipboard
# Tags: linux, clipboard, external-tool
---
On X11, easily copy and paste between Vim and system clipboard using xclip, which is particularly useful for handling large amounts of text

```vim
" Mapping to copy entire buffer to clipboard
:map <F7> :w !xclip<CR><CR>
" Mapping to copy visual selection to clipboard
:vmap <F7> "*y
" Mapping to paste from clipboard
:map <S-F7> :r!xclip -o<CR>
```

```lua
-- Copy entire buffer to clipboard
vim.keymap.set('n', '<F7>', ':w !xclip<CR>', { desc = 'Copy buffer to clipboard' })
-- Copy visual selection to clipboard
vim.keymap.set('v', '<F7>', '"*y', { desc = 'Copy selection to clipboard' })
-- Paste from clipboard
vim.keymap.set('n', '<S-F7>', ':r!xclip -o<CR>', { desc = 'Paste from clipboard' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip)
***
# Title: Cross-Platform System Clipboard Integration
# Category: clipboard
# Tags: clipboard, cross-platform, system-copy
---
Enable seamless clipboard sharing between Vim and macOS system clipboard

```vim
set clipboard=unnamed
```

```lua
vim.opt.clipboard = 'unnamed'
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing)
***
# Title: Quick Clipboard Copy/Paste Mappings
# Category: clipboard
# Tags: mapping, clipboard, productivity
---
Create custom keymaps for easy copying and pasting using pbcopy/pbpaste

```vim
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>
```

```lua
vim.keymap.set({'n', 'i'}, '<F1>', function()
  vim.o.paste = true
  vim.cmd('r !pbpaste')
  vim.o.paste = false
end)

vim.keymap.set('n', '<F2>', ':.w !pbcopy<CR>', { silent = true })
vim.keymap.set('v', '<F2>', ':w !pbcopy<CR>', { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing)
***
# Title: Middle-Click Paste Handling
# Category: clipboard
# Tags: paste, clipboard, mouse
---
Improve middle-click paste behavior across different Vim modes, with special handling for insert and visual modes

```vim
"Middle-click paste handling
nnoremap <MiddleMouse> i<MiddleMouse>
vnoremap <MiddleMouse> s<MiddleMouse>
```

```lua
-- Improved middle-click paste handling
vim.keymap.set('n', '<MiddleMouse>', 'i<MiddleMouse>', { noremap = true })
vim.keymap.set('v', '<MiddleMouse>', 's<MiddleMouse>', { noremap = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Mighty_Mouse)
***
# Title: Paste Clipboard Contents in New Vim Window
# Category: clipboard
# Tags: clipboard, paste, register
---
Quickly open a new Vim buffer with clipboard contents using built-in register

```vim
:new
"*p
```

```lua
-- Open new buffer and paste from clipboard register
vim.cmd('new')
vim.cmd('normal "*p')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Paste_from_the_clipboard_into_a_new_vim)
***
# Title: Clipboard Access in Cygwin Vim
# Category: clipboard
# Tags: cross-platform, windows, clipboard
---
Convenient mappings for copying, cutting, and pasting using system clipboard across different modes

```vim
" Copy to clipboard register
vmap <C-c> "*y

" Select all text
nmap <C-a> ggVG

" Normal copy/paste mappings
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
imap <C-v> <Esc>pi
```

```lua
-- Copy to system clipboard in visual mode
vim.keymap.set('v', '<C-c>', '"*y', { desc = 'Copy to system clipboard' })

-- Select entire buffer
vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all text' })

-- Paste from system clipboard in insert mode
vim.keymap.set('i', '<C-v>', '<Esc>pi', { desc = 'Paste from system clipboard' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Quick_yank_and_paste)
***
# Title: Quick Cross-Window Copy and Paste
# Category: clipboard
# Tags: key-mapping, clipboard, visual-mode
---
One-key solution for copying and pasting between windows using clipboard register

```vim
" Copy current word or selection to clipboard
nnoremap <F4> "+yiw
vnoremap <F4> "+y

" Replace with clipboard contents
nnoremap <F5> viw"+p
vnoremap <F5> "+p
```

```lua
-- Copy current word or selection to clipboard
vim.keymap.set('n', '<F4>', '"+yiw', { desc = 'Copy word to clipboard' })
vim.keymap.set('v', '<F4>', '"+y', { desc = 'Copy selection to clipboard' })

-- Replace with clipboard contents
vim.keymap.set('n', '<F5>', 'viw"+p', { desc = 'Replace word with clipboard' })
vim.keymap.set('v', '<F5>', '"+p', { desc = 'Replace selection with clipboard' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip497)
***
# Title: Transfer Text Between Vim Sessions Using Clipboard
# Category: clipboard
# Tags: registers, cross-session, clipboard
---
Easily copy text between different Vim/Neovim sessions using the '+' register, which interfaces with the system clipboard

```vim
" Yank two lines to clipboard register
"+2yy

" Paste from clipboard register in normal mode
"+p

" Paste from clipboard register in insert mode
<Ctrl-R>+
```

```lua
-- Yank two lines to clipboard register
vim.cmd('normal! "+2yy')

-- Paste from clipboard register in normal mode
vim.cmd('normal! "+p')

-- In insert mode, use vim.api to insert clipboard contents
vim.api.nvim_put(vim.fn.getreg('+'), 'c', true, true)
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip71)
***
