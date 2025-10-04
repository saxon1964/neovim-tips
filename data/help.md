# Title: Search help by pattern
# Category: Help
# Tags: help, search, pattern
---
Use `:help pattern` to search help documentation for specific keywords or patterns.

#### Example

```vim
:help pattern  " search help for 'pattern'
```
***
# Title: Master help index
# Category: Help
# Tags: help, index, reference
---
Use `:h index.txt` to access the master help index with all available commands.

#### Example

```vim
:h index.txt  " master help index
```
***
# Title: Ex commands - help and documentation
# Category: Help
# Tags: ex, help, documentation, version, info
---
Use `:version` for version info, `:intro` for intro message, `:messages` for message history, `:checkhealth` for diagnostics.

#### Example

```vim
:version      " show Neovim version and build info
:intro        " show introduction message
:messages     " show message history
:checkhealth  " run health diagnostics
```
***
# Title: Ex commands - help navigation
# Category: Help
# Tags: ex, help, navigation, tag, jump
---
Use `:helpgrep` to search help, `:ptag` for preview, `:pop` to go back, `:tag` to jump to tag.

#### Example

```vim
:helpgrep pattern   " search all help for pattern
:ptag function      " preview tag in preview window
:pop                " go back in tag stack
:tag function       " jump to tag
:tags               " show tag stack
```
***
# Title: Man pages
# Category: Help
# Tags: man, help, documentation
---
Use `:Man` to open a man-page in a read-only mode. You can navigate the page like any other Neovim content. You can jump arround, copy parts of it, search for a word and perform all other standard Neovim operations. Once you have a man-page on the screen, you can generate its content by using stadnard `gO` command in normal mode.

#### Example

```vim
:Man ls   "Opens man-page for linux ls command
gO        "Generates TOC in normal mode for the selected man-page

```
***
