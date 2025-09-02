# Title: Random quote generator:
# Category: Fun
# Tags: fun, file
---
Paste random quote into your buffer with the following command: 

```vim
:lua local q = vim.fn.readfile("quotes.txt"); vim.api.nvim_buf_set_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1], false, { q[math.random(#q)] })
```
***
# Title: Surprise yourself!  
# Category: Fun
# Tags: fun
---
The following command will print `Neovim is great` until you stop it with `Ctrl+C`:

```vim
:!yes "Neovim is great"
```
***
# Title: Show all whitespace, but nicely 
# Category: Fun
# Tags: fun
---
Use the following commands:

```vim
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
```

Highlights trailing spaces in red. Instant “why did I leave that space there?” effect.
***
# Title: Reverse lines in file 
# Category: Fun
# Tags: fun, edit, reverse
---
Moves every line to the top — effectively reversing the buffer. Great for experimenting or trolling your own file.

```vim
:g/^/m0
```
***
# Title: Flip a coin 
# Category: fun
# Tags: fun
---
Quick decision-making inside Neovim. Could help settle coding debates (“Tabs or spaces?”).

```vim
:echo ["Heads","Tails"][rand() % 2]
```
***
# Title: Matrix like effect 
# Category: Fun
# Tags: fun
---
Poor man's matrix screen :)

```vim
:!yes | awk '{print int(rand()*10)}' | pv -qL 100

```
***
# Title: Sort randomly 
# Category: Fun
# Tags: fun, sort
---
Sort lines randomly by using this simple command:

```vim
:sort!
```

Works for small files only.
***
# Title: Shuffle lines
# Category: Fun
# Tags: fun, shuffle, edit
---
Use the following commands to randomly rearrange all lines: 

```vim
:lua local lines=vim.api.nvim_buf_get_lines(0,0,-1,false); for i=#lines,2,-1 do local j=math.random(i); lines[i],lines[j]=lines[j],lines[i]; end; vim.api.nvim_buf_set_lines(0,0,-1,false,lines)
```

Perfect for testing or chaos.
***
