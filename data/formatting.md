# Title: Format with Treesitter
# Category: Formatting
# Tags: treesitter, format, syntax
---
Use `=ap` to format syntax-aware regions using Treesitter (when available).

```vim
=ap  " format around paragraph with Treesitter
```
***
# Title: Automatic paragraph formatting
# Category: Formatting
# Tags: paragraph, textwidth, reflow
---
Automatically format paragraphs to specified width using textwidth and format commands.

```vim
:set textwidth=60      " set line width to 60 characters
:set fo=aw2tq          " format options for auto-formatting
gqip                   " reformat inner paragraph
```
***
# Title: Comment lines by filetype
# Category: Formatting
# Tags: comment, filetype, toggle
---
Automatically comment/uncomment lines based on current file type.

```vim
function CommentIt()
  if &filetype == "vim"
    vmap +# :s/^/"/<CR>
    vmap -# :s/^"//<CR>
  elseif &filetype == "python"
    vmap +# :s/^/#/<CR>
    vmap -# :s/^#//<CR>
  endif
endfunction
autocmd BufEnter * call CommentIt()
```
***
# Title: Automatic text width formatting
# Category: Formatting
# Tags: text, width, format, autowrap, textwidth
---
Use `:set textwidth=80` to automatically wrap lines at 80 characters while typing.

```vim
:set textwidth=80   " wrap at 80 characters
:set textwidth=0    " disable automatic wrapping
:set formatoptions+=t  " enable automatic text wrapping
gqap                " manually format current paragraph to textwidth
```
***
# Title: Poor men's JSON formatter
# Category: Formatting
# Tags: text, format, json
---
A poor men's json formatter using `vim.json.decode` + `vim.json.encode`:

```lua
function _G.json_formatter()
	-- from $VIMRUNTIME/lua/vim/lsp.lua
	if vim.list_contains({ 'i', 'R', 'ic', 'ix' }, vim.fn.mode()) then
		return 1
	end
	local indent = vim.bo.expandtab and '\t' or string.rep(' ', vim.o.tabstop)

	local lines = vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.count, true)
	local deco = vim.json.decode(table.concat(lines, '\n'))
	local enco = vim.json.encode(deco, { indent = indent })
	local split = vim.split(enco, '\n')
	vim.api.nvim_buf_set_lines(0, vim.v.lnum - 1, vim.v.count, true, split)

	return 0
end

vim.bo.formatexpr = 'v:lua.json_formatter()'
```

You can put it in `ftplugin/json.lua`. Only works for the whole file, e.g. with `gggqG`

[Credits: yochem](https://github.com/neovim/neovim/discussions/35683)
***
