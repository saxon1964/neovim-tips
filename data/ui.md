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
# Title: Highlight groups
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
# Title: Flash yanked text
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
# Title: Beautiful transparent theme with background image
# Category: UI
# Tags: theme, transparency, background, aesthetic, kitty, tokyonight
---
Create a beautiful working environment by combining a transparent Neovim theme with a tinted background image in your terminal emulator.

**Neovim configuration (Tokyonight with transparency):**

```lua
{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 2000,
  opts = { transparent = true }  -- Enable transparency
}
```

**Kitty terminal configuration (~/.config/kitty/kitty.conf):**

```conf
# Background image settings
background_image ~/.config/nvim/kitty/images/wp6.jpg
background_image_layout scaled
background_image_linear 0.3
background_tint 0.7
background_tint_color #990000

# Parameter explanations:
# background_image: Path to your background image file
# background_image_layout: How image is displayed (scaled, tiled, mirrored, clamped, cscaled)
# background_image_linear: Apply linear interpolation for smoother scaling (0.0 to 1.0)
# background_tint: How much to darken the image (0.0 = black, 1.0 = original)
# background_tint_color: Color overlay applied to the image (hex color code)

# Common tint color examples:
# Warm reddish hue:    background_tint_color #331111
# Cool bluish hue:     background_tint_color #111133
# Pure darkening:      background_tint_color #000000
# Greyed-out effect:   background_tint_color #202020
```

This creates a beautiful aesthetic where your code appears over a subtly tinted background image, combining terminal customization with Neovim's transparent theme support.
***
