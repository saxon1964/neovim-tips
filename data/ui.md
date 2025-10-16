# Title: Custom statusline
# Category: UI
# Tags: statusline, custom, display
---
Use `vim.opt.statusline` to set a custom statusline format.

```vim
:lua vim.opt.statusline = "%f %y %m %= %l:%c"
```
***
# Title: Check highlight groups
# Category: UI
# Tags: highlight, groups, colors
---
Use `:hi` to view all highlight groups and their current settings.

```vim
:hi  " show all highlight groups
```
***
# Title: Highlight goroups
# Category: UI
# Tags: highlight, groups, fun
---
Use the following code to create command `HLList`. 

```vim
command! HLList lua local b=vim.api.nvim_create_buf(false,true) vim.api.nvim_set_current_buf(b) local g=vim.fn.getcompletion("","highlight") vim.api.nvim_buf_set_lines(b,0,-1,false,g) for i,n in ipairs(g) do pcall(vim.api.nvim_buf_add_highlight,b,-1,n,i-1,0,-1) end
```

When run, the command creates a scratch buffer with one line per highlight group, with each line styled with its own group.

***
# Title: Change highlight group on the fly
# Category: UI
# Tags: highlight, groups, fun
---
You can change the highlight group on the fly. For example, the next command changes all comments to red italic:

```vim
:hi Comment guifg=#ffaa00 gui=italic
```
***
# Title: Flesh yanked text
# Category: UI
# Tags: highlight, group, yank, flash
---
Use the following command to flash yanked text using the `IncSearch` highlight for `200` milliseconds.

```vim
:au TextYankPost * lua=vim.highlight.on_yank{higroup='IncSearch',timeout=200}
```
***
# Title: Print treesitter highlight group info
# Category: UI
# Tags: highlight, group, treesitter
---
Use the following command to check the highlight info for the text under the cursor:

```vim
:lua print(vim.treesitter.get_captures_at_cursor()[1] or "NONE")
```
***
