Search forward
# Title: Search forward
# Category: Search
# Tags: search, find, forward
---
Use `/pattern` to search forward for a pattern. Press `n` to go to next match and `N` for previous.

#### Example

```vim
/hello  " search for 'hello'
n       " next match
N       " previous match
```
===

Global search and replace
# Title: Global search and replace
# Category: Search
# Tags: replace, global, substitute
---
Use `:%s/old/new/g` to replace all occurrences of 'old' with 'new' in the entire file.

#### Example

```vim
:%s/foo/bar/g  " replace all 'foo' with 'bar'
```
===

Remove search highlighting
# Title: Remove search highlighting
# Category: Search
# Tags: search, highlight, remove
---
Use `:nohl` to remove search highlighting after performing a search.

#### Example

```vim
:nohl
```
===

Search with confirmation
# Title: Search with confirmation
# Category: Search
# Tags: replace, confirm, interactive
---
Use `:%s/old/new/gc` to replace with confirmation for each match.

#### Example

```vim
:%s/foo/bar/gc  " replace with confirmation
```
===

Search in selection
# Title: Search in selection
# Category: Search
# Tags: replace, selection, range
---
Use `:'<,'>s/old/new/g` to replace only in visual selection.

#### Example

```vim
:'<,'>s/foo/bar/g  " replace in selection
```
===

Case insensitive search
# Title: Case insensitive search
# Category: Search
# Tags: search, case, insensitive
---
Use `/pattern\c` for case insensitive search, or `/pattern\C` for case sensitive search.

#### Example

```vim
/hello\c  " case insensitive
/hello\C  " case sensitive
```
===

Search word boundaries
# Title: Search word boundaries
# Category: Search
# Tags: search, word, boundary
---
Use `\<word\>` to search for whole word only, preventing partial matches.

#### Example

```vim
/\<hello\>  " search for whole word 'hello' only
```
===

Search word under cursor
# Title: Search word under cursor
# Category: Search
# Tags: search, cursor, word
---
Use `*` to search forward for word under cursor and `#` to search backward for word under cursor.

#### Example

```vim
*  " search forward for word under cursor
#  " search backward for word under cursor
```
===

Very magic search mode
# Title: Very magic search mode
# Category: Search
# Tags: search, regex, magic
---
Use `\v` at start of search pattern for "very magic" mode, making regex more intuitive (similar to other languages).

#### Example

```vim
/\v(hello|world)  " search for 'hello' or 'world'
/\vd+             " search for one or more digits
```
===

Search backward
# Title: Search backward
# Category: Search
# Tags: search, backward, reverse
---
Use `?pattern` to search backward for a pattern. Press `n` to go to next match and `N` for previous.

#### Example

```vim
?hello  " search backward for 'hello'
n       " next match (backward)
N       " previous match (forward)
```
===

Recursive file search
# Title: Recursive file search
# Category: Search
# Tags: vimgrep, recursive, files
---
Use `:vimgrep /pattern/ **/*.ext` to search for pattern recursively in files with specific extension.

#### Example

```vim
:vimgrep /pattern/ **/*.lua  " search in all .lua files
```
===

Advanced search and replace with regex
# Title: Advanced search and replace with regex
# Category: Search
# Tags: replace, regex, advanced
---
Use `:%s/\v(foo|bar)/baz/g` to replace either 'foo' or 'bar' with 'baz' using very magic mode.

#### Example

```vim
:%s/\v(foo|bar)/baz/g  " replace foo or bar with baz
```
===

Repeat last search in substitution
# Title: Repeat last search in substitution
# Category: Search
# Tags: substitute, repeat, search
---
Use `:%s//replacement/g` to use the last search pattern in substitution command.

#### Example

```vim
:%s//new_text/g  " replace last searched pattern with new_text
```
===

Open search history
# Title: Open search history
# Category: Search
# Tags: history, search, window
---
Use `q/` to open search history in a searchable window.

#### Example

```vim
q/  " open search history window
```
===
