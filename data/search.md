# Title: Global search and replace
# Category: Search
# Tags: replace, global, substitute
---
Use `:%s/old/new/g` to replace all occurrences of 'old' with 'new' in the entire file.

```vim
:%s/foo/bar/g  " replace all 'foo' with 'bar'
```
***
# Title: Remove search highlighting
# Category: Search
# Tags: search, highlight, remove
---
Use `:nohl` to remove search highlighting after performing a search.

```vim
:nohl
```
***
# Title: Search in selection
# Category: Search
# Tags: replace, selection, range
---
Use `:'<,'>s/old/new/g` to replace only in visual selection.

```vim
:'<,'>s/foo/bar/g  " replace in selection
```
***
# Title: Case insensitive search
# Category: Search
# Tags: search, case, insensitive
---
Use `/pattern\c` for case insensitive search, or `/pattern\C` for case sensitive search.

```vim
/hello\c  " case insensitive
/hello\C  " case sensitive
```
***
# Title: Very magic search mode
# Category: Search
# Tags: search, regex, magic
---
Use `\v` at start of search pattern for "very magic" mode, making regex more intuitive (similar to other languages).

```vim
/\v(hello|world)  " search for 'hello' or 'world'
/\vd+             " search for one or more digits
```
***
# Title: Search backward
# Category: Search
# Tags: search, backward, reverse
---
Use `?pattern` to search backward for a pattern. Press `n` to go to next match and `N` for previous.

```vim
?hello  " search backward for 'hello'
n       " next match (backward)
N       " previous match (forward)
```
***
# Title: Recursive file search
# Category: Search
# Tags: vimgrep, recursive, files
---
Use `:vimgrep /pattern/ **/*.ext` to search for pattern recursively in files with specific extension.

```vim
:vimgrep /pattern/ **/*.lua  " search in all .lua files
```
***
# Title: Advanced search and replace with regex
# Category: Search
# Tags: replace, regex, advanced
---
Use `:%s/\v(foo|bar)/baz/g` to replace either 'foo' or 'bar' with 'baz' using very magic mode.

```vim
:%s/\v(foo|bar)/baz/g  " replace foo or bar with baz
```
***
# Title: Repeat last search in substitution
# Category: Search
# Tags: substitute, repeat, search
---
Use `:%s//replacement/g` to use the last search pattern in substitution command.

```vim
:%s//new_text/g  " replace last searched pattern with new_text
```
***
# Title: Delete lines containing pattern
# Category: Search
# Tags: delete, pattern, global, lines
---
Use `:g/pattern/d` to delete all lines containing a pattern, or `:g!/pattern/d` to delete lines NOT containing pattern.

```vim
:g/pattern/d        " delete all lines containing 'pattern'
:g/^\s*$/d          " delete empty or whitespace-only lines
:g!/error/d         " delete lines NOT containing 'error'
:g!/error\|warn/d   " delete lines NOT containing 'error' or 'warn'
```
***
# Title: Global command with pattern
# Category: Search
# Tags: global, command, execute, pattern
---
Use `:g/pattern/command` to execute a command on all lines matching pattern.

```vim
:g/TODO/d        " delete all lines containing TODO
:g/function/p    " print all lines containing 'function'
:g/error/s/old/new/g " replace 'old' with 'new' on lines with 'error'
```
***
# Title: Search word boundaries with very magic
# Category: Search
# Tags: search, regex, word, boundary, magic
---
Use `\v` for very magic mode to make regex more intuitive, or `\<word\>` for exact word boundaries.

```vim
/\v(hello|world)  " search for 'hello' or 'world' (very magic)
/\<function\>     " search for exact word 'function'
/\vd+             " search for one or more digits
```
***
# Title: Search and execute command
# Category: Search
# Tags: search, execute, global, command
---
Use `:g/pattern/command` to execute command on all lines matching pattern.

```vim
:g/TODO/d        " delete all lines containing TODO
:g/^$/d          " delete all empty lines
:g/pattern/p     " print all lines matching pattern
```
***
# Title: Negative search (inverse)
# Category: Search
# Tags: search, negative, inverse, exclude
---
Use `:v/pattern/command` or `:g!/pattern/command` to execute command on lines NOT matching pattern.

```vim
:v/pattern/d     " delete lines NOT containing pattern
:g!/TODO/p       " print lines NOT containing TODO
```
***
# Title: Multi-line search pattern
# Category: Search
# Tags: search, multiline, pattern, regex
---
Use `\_s` for whitespace including newlines, `\_.*` to match across lines in search patterns.

```vim
/function\_s*name    " function followed by whitespace/newlines
/start\_.*end        " match start to end across lines
```
***
# Title: Search with offset
# Category: Search
# Tags: search, offset, cursor, position
---
Use `/pattern/+n` to position cursor n lines after match, or `/pattern/-n` for n lines before.

```vim
/function/+2     " position cursor 2 lines after 'function'
/end/-1          " position cursor 1 line before 'end'
```
***
# Title: Replace only within visual selection
# Category: Search
# Tags: replace, visual, selection, visual-pattern
---
Use `\%V` in search pattern to restrict replacement to only the visual selection area.

```vim
" After making visual selection:
:'<,'>s/\%Vold/new/g   " replace only within selection
" \%V ensures replacement only happens in selected text
```
***
# Title: Perform change on lines returned by vimgrep regex search
# Category: Search
# Tags: replace, regex, search, vimgrep, cdo
---
Suppose that you have a set of .html documents and you want to find all <a> tags that have some attribute in it, for example: `text-red`. You want to replace that attribute with `text-blue`. Do the following:

```vim
:vimgrep /<a [^>]*text-red[^>]*>/gj **/*.html
```

This will create a quickfix list made of lines that match the regular expression and open the file with the first matching line highlighted. After that you can execute the substitution:

```vim
:cdo s/text-red/text-blue/gc
```

Thanks to `c` flag you'll have a cnahce to approve every change. Note that `cfdo` would perform changes on matched FILES, while `cdo` works on matched lines. Also in substitution command use `s/`, not `%s/` because the first one is executed on the current line and the second one would process the whole doucment.
***
