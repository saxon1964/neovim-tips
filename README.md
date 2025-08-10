
# Neovim Tips Plugin

A Lua plugin for Neovim that helps you organize and search helpful tips, tricks, and shortcuts via a fuzzy search interface.

## ✨ Features
- Search tips using `fzf-lua`
- Preview rendered descriptions in Markdown format
- Support for categories, tags, and rich text
- Add or edit personal tips stored in a configurable file

## 📦 Installation

**Using lazy.nvim**:
```lua
{
  "saxon1964/neovim-tips",
  dependencies = { "ibhagwan/fzf-lua" },
  opts = {
    -- OPTIONAL: Location of user defined tips (default value shown below)
    user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.txt",
  }
},
```

## 🔧 Commands
- `:NeovimTips` — Open searchable list of tips
- `:NeovimTipsEdit` — Edit your personal tips file
- `:NeovimTipsAdd` — Insert a new tip template into your personal file and start editing

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
- Built-in tips: `<plugin_directory>/data/builtin_tips.txt`
- User tips: `~/.config/nvim/neovim_tips/user_tips.txt`

## 🔄 Roadmap Ideas
- Category filtering
- Search descriptions
- Multiple tip sources

All pull requests are welcome! Send me your tips and I will add them to built-in collection with proper credits.

## ⚖️ License

- Unlicense. You can find more details in the license file or [here](https://unlicense.org) 

