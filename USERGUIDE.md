# Neovim Tips User Guide

> **📖 Quick Access**: You can open this guide anytime with the `:NeovimTipsHelp` command

## User-Defined Tips

The author of this plugin has done his best to provide a significant number of built-in Neovim commands, tips and tricks. But Neovim is an endless source of inspiration to many and, I believe, to you as well.

It is possible to mix your own tips with the built-in collection. Use `:NeovimTipsAdd` to add your own tip to the collection or `:NeovimTipsEdit` to edit the file with your custom tips. If the file for your custom tips does not exist, it will be created automatically. The location of the file can be adjusted (see "Configuration Options"). 

### User Tip Format

User tips follow the same format as builtin tips:

````
# Title: Your custom tip title
# Category: Your Category 
# Tags: tag1, tag2, tag3
---
Your tip description goes here.

#### Example

```vim
:YourCommand  " your example
```
===
````

Anything between `---` and `===` is considered to be a tip description in markdown text format and will be rendered accordingly.

### Conflict Prevention

To prevent conflicts with builtin tips, user tips are automatically prefixed with `[User] ` by default. Do **NOT** add the prefix yourself. This means if you create a tip with the title `Join lines`, it will appear as `[User] Join lines` in the interface and will not interfere with the built-in tip with the title `Join lines`.

### Configuration Options

You can customize the user tip behavior in your Neovim configuration:

```lua
require('neovim_tips').setup({
  user_tip_prefix = "★ ",           -- Use star instead of [User]
  warn_on_conflicts = true,         -- Show warnings for title conflicts
  user_file = "~/my_vim_tips.md"    -- Custom location for user tips
})
``` 

Available configuration options:

- `user_tip_prefix`: String prefix added to user tip titles (default: `"[User] "`)
- `warn_on_conflicts`: Show warnings when user tips have conflicting titles (default: `true`)
- `user_file`: Path to user tips file (default: `~/.config/nvim/neovim_tips/user_tips.md`)

### Examples

#### Custom prefix
```lua
require('neovim_tips').setup({
  user_tip_prefix = "🔧 "  -- User tips will show as "🔧 Your tip title"
})
```

#### No prefix (not recommended)
```lua
require('neovim_tips').setup({
  user_tip_prefix = ""     -- No prefix, but conflicts with built-in tips will be warned about
})
```

### Features

- **Automatic prefixing**: User tips are automatically prefixed to avoid conflicts
- **Conflict detection**: Warnings when user tip titles match builtin tips
- **User tag**: All user tips automatically get a "user" tag for filtering
- **Same format**: User tips follow the exact same format as builtin tips

### Tips for Writing User Tips

- Use descriptive, unique titles
- Include relevant tags for easy searching
- Provide clear examples when applicable
- Test your tips before adding them
- Consider if your tip might be useful as a contribution to the main collection

