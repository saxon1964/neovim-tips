
# Neovim Tips Plugin

A Lua plugin for Neovim that helps you organize and search helpful tips, tricks, and shortcuts via a fuzzy search interface.

## ✨ Features
- Search tips using `fzf-lua`
- Preview rendered descriptions in Markdown using [glow](https://github.com/charmbracelet/glow)
- Support for categories, tags, and rich text
- Add or edit personal tips stored in a configurable file

## 📦 Installation

**Using lazy.nvim**:
```lua
{
  "saxon1964/neovim-tips",
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {
    -- ALL SETTINGS ARE OPTIONAL. DEFAULTS SHOWN BELOW
    -- Location of user defined tips
    user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.txt",
    -- Command used to render markdown file (%s placeholder)
    md_preview_cmd = "CLICOLOR_FORCE=1 COLORTERM=truecolor glow %s",
    -- Temporary file. Deleted on neovim exit
    tmp_file = vim.fn.expand("~/neovim_tips_tmp.md")
  }
},
```

> You’ll also need to install [`glow`](https://github.com/charmbracelet/glow) for Markdown previews.

### 🔧 Installing Glow
You can install `glow` using a package manager:

- macOS (Homebrew):
  ```sh
  brew install glow
  ```
- Arch Linux:
  ```sh
  pacman -S glow
  ```
- Debian/Ubuntu:
  ```sh
  sudo apt install glow
  ```
- Or download from [releases](https://github.com/charmbracelet/glow/releases)

## 🔧 Commands
- `:NeovimTips` — Open searchable list of tips
- `:NeovimTipsEdit` — Edit your personal tips file
- `:NeovimTipsAdd` — Insert a new tip template into your personal file

## 📝 Tip Format
Each tip should follow this format in your tips file:

````markdown
# Title: My Tip Title
# Category: Navigation
# Tags: motion, cursor
---
This is a description of what the tip does.

```vim
normal-mode-command
```
===
````

Description of the tip starts with --- and ends with ===. Description supports markdown syntax and will be rendered accordingly.

## ✅ Example
````markdown
# Title: Save the file
# Category: File
# Tags: write, command
---
Use `:w` to write changes.

```vim
:w
```
===
````

## 📁 Default File Locations
- Built-in tips: `data/builtin_tips.txt`
- User tips: `~/.config/nvim/neovim_tips/user_tips.txt`

## 🔄 Roadmap Ideas
- Category filtering
- Search descriptions
- Multiple tip sources

All pull requests are welcome! Send me your tips and I will add them to built-in collection with proper credits.

## ⚖️ License

- Unlicense. You can find more details in the license file or [here](https://unlicense.org) 

