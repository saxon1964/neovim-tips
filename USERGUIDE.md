# Neovim Tips User Guide

> **📖 Quick Access**: You can open this guide anytime with the `:NeovimTipsHelp` command

## User-Defined Tips

You can create your own custom tips by creating a file at `~/.config/nvim/neovim_tips/user_tips.md`.

### User Tip Format

User tips follow the same format as builtin tips:

```markdown
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
```

### Conflict Prevention

To prevent conflicts with builtin tips, user tips are automatically prefixed with `[User] ` by default. This means if you create a tip with the title "Join lines", it will appear as "[User] Join lines" in the interface.

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
  user_tip_prefix = ""     -- No prefix, but conflicts will be warned about
})
```

### Features

- **Automatic prefixing**: User tips are automatically prefixed to avoid conflicts
- **Conflict detection**: Warnings when user tip titles match builtin tips
- **User tag**: All user tips automatically get a "user" tag for filtering
- **Same format**: User tips follow the exact same format as builtin tips

### Tips for Writing User Tips

1. Use descriptive, unique titles
2. Include relevant tags for easy searching
3. Provide clear examples when applicable
4. Test your tips before adding them
5. Consider if your tip might be useful as a contribution to the main collection