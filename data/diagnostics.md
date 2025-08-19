# Title: Health diagnostics
# Category: Diagnostics
# Tags: health, check, diagnostics
---
Use `:checkhealth` to run health diagnostics for your Neovim setup.

#### Example

```vim
:checkhealth  " run health diagnostics
```
===
# Title: View messages
# Category: Diagnostics
# Tags: messages, log, history
---
Use `:messages` to view past messages and notifications.

#### Example

```vim
:messages  " view past messages
```
===
# Title: Find mapping source
# Category: Diagnostics
# Tags: mapping, verbose, source
---
Use `:verbose map <key>` to see where a specific mapping was defined.

#### Example

```vim
:verbose map <leader>f  " see where <leader>f was mapped
```
===
# Title: Find option source
# Category: Diagnostics
# Tags: option, verbose, source
---
Use `:verbose set option?` to see where a specific option was last set.

#### Example

```vim
:verbose set number?  " see where 'number' option was set
```
===