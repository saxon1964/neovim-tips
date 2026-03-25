# Title: Create scratch buffer
# Category: Buffers
# Tags: buffers, scratch, temporary, unlisted
---
Use `vim.api.nvim_create_buf()` to create scratch buffers for temporary content that won't be saved.

```lua
-- Create scratch buffer (not listed, not a file)
local bufnr = vim.api.nvim_create_buf(false, true)

-- false = not listed in buffer list
-- true = scratch buffer (no swapfile, not saved)

-- Add content to scratch buffer
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "This is a scratch buffer",
  "It won't be saved",
  "Perfect for temporary notes or output"
})

-- Open in current window
vim.api.nvim_win_set_buf(0, bufnr)
```

**Source:** Community contributed
***
# Title: Create listed buffer
# Category: Buffers
# Tags: buffers, listed, create
---
Create a listed buffer that appears in the buffer list and behaves like a regular file buffer.

```lua
-- Create listed, non-scratch buffer
local bufnr = vim.api.nvim_create_buf(true, false)

-- true = listed in buffer list
-- false = not a scratch buffer (will have swapfile, can be saved)

-- Set buffer name
vim.api.nvim_buf_set_name(bufnr, "MyBuffer")

-- Set content
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "This is a regular buffer",
  "You can save it with :w"
})

-- Switch to buffer
vim.api.nvim_set_current_buf(bufnr)
```

**Source:** Community contributed
***
# Title: Set buffer type for special buffers
# Category: Buffers
# Tags: buffers, buftype, special, nofile
---
Use `buftype` option to create special buffer types like help, quickfix, or custom tool buffers.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Different buffer types:
vim.bo[bufnr].buftype = "nofile"    -- Not associated with a file
vim.bo[bufnr].buftype = "nowrite"   -- Cannot be written
vim.bo[bufnr].buftype = "acwrite"   -- Use autocommand for writing
vim.bo[bufnr].buftype = "quickfix"  -- Quickfix buffer
vim.bo[bufnr].buftype = "help"      -- Help buffer
vim.bo[bufnr].buftype = "terminal"  -- Terminal buffer
vim.bo[bufnr].buftype = "prompt"    -- Prompt buffer (like cmdline)

-- Example: Create a read-only tool buffer
vim.bo[bufnr].buftype = "nofile"
vim.bo[bufnr].bufhidden = "wipe"    -- Delete when hidden
vim.bo[bufnr].swapfile = false
vim.bo[bufnr].modifiable = false    -- Read-only
```

**Source:** Community contributed
***
# Title: Control buffer hiding behavior
# Category: Buffers
# Tags: buffers, bufhidden, hide, delete
---
Use `bufhidden` to control what happens when a buffer is hidden from view.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Options for bufhidden:
vim.bo[bufnr].bufhidden = ""        -- Keep (default)
vim.bo[bufnr].bufhidden = "hide"    -- Hide but keep in memory
vim.bo[bufnr].bufhidden = "unload"  -- Unload from memory
vim.bo[bufnr].bufhidden = "delete"  -- Delete buffer
vim.bo[bufnr].bufhidden = "wipe"    -- Wipe buffer completely

-- Example: Auto-cleanup buffer
vim.bo[bufnr].bufhidden = "wipe"
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"Temporary content"})
```

**Source:** Community contributed
***
# Title: Create read-only buffer
# Category: Buffers
# Tags: buffers, readonly, modifiable, locked
---
Create read-only buffers for displaying information that shouldn't be edited.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Set buffer options for read-only
vim.bo[bufnr].modifiable = false
vim.bo[bufnr].readonly = true
vim.bo[bufnr].buftype = "nofile"

-- Add content (need to make modifiable temporarily)
vim.bo[bufnr].modifiable = true
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "=== Read-Only Content ===",
  "This buffer cannot be edited",
})
vim.bo[bufnr].modifiable = false

-- Open in window
vim.api.nvim_win_set_buf(0, bufnr)
```

**Source:** Community contributed
***
# Title: Create floating window with scratch buffer
# Category: Buffers
# Tags: buffers, floating, window, scratch
---
Combine scratch buffers with floating windows for temporary UI elements.

```lua
-- Create scratch buffer
local bufnr = vim.api.nvim_create_buf(false, true)

-- Add content
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  "╔═══════════════════════════╗",
  "║    Floating Scratch       ║",
  "║    Press 'q' to close     ║",
  "╚═══════════════════════════╝",
})

-- Calculate centered position
local width = 30
local height = 4
local win_width = vim.api.nvim_get_option_value("columns", {})
local win_height = vim.api.nvim_get_option_value("lines", {})

local row = math.floor((win_height - height) / 2)
local col = math.floor((win_width - width) / 2)

-- Open floating window
local win_id = vim.api.nvim_open_win(bufnr, true, {
  relative = "editor",
  width = width,
  height = height,
  row = row,
  col = col,
  style = "minimal",
  border = "rounded",
})

-- Set buffer-local keymap to close
vim.api.nvim_buf_set_keymap(bufnr, "n", "q",
  ":close<CR>",
  {nowait = true, noremap = true, silent = true})

-- Auto-wipe buffer when window closes
vim.bo[bufnr].bufhidden = "wipe"
```

**Source:** Community contributed
***
# Title: Buffer-local keymaps
# Category: Buffers
# Tags: buffers, keymaps, buffer-local, mappings
---
Create keymaps that only work in specific buffers.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Buffer-local keymap (modern API)
vim.keymap.set("n", "q", function()
  vim.api.nvim_buf_delete(bufnr, {force = true})
end, {
  buffer = bufnr,
  desc = "Close this buffer"
})

-- Multiple buffer-local keymaps
local keymaps = {
  {"n", "r", ":lua RefreshBuffer()<CR>", "Refresh"},
  {"n", "s", ":lua SaveBuffer()<CR>", "Save"},
  {"n", "<Esc>", ":close<CR>", "Close"},
}

for _, map in ipairs(keymaps) do
  vim.keymap.set(map[1], map[2], map[3], {
    buffer = bufnr,
    desc = map[4],
    silent = true,
    noremap = true,
  })
end
```

**Source:** Community contributed
***
# Title: Buffer-local autocommands
# Category: Buffers
# Tags: buffers, autocommands, buffer-local, events
---
Create autocommands that only trigger for specific buffers.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Buffer-local autocommand
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = bufnr,
  callback = function()
    print("This buffer is about to be written")
    -- Custom pre-save logic
  end,
})

-- Multiple events for one buffer
vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  buffer = bufnr,
  callback = function()
    -- Auto-save or validation logic
    print("Buffer content changed")
  end,
})

-- Cleanup on buffer delete
vim.api.nvim_create_autocmd("BufDelete", {
  buffer = bufnr,
  callback = function()
    print("Buffer deleted, cleaning up...")
    -- Cleanup resources
  end,
})
```

**Source:** Community contributed
***
# Title: Buffer-local variables
# Category: Buffers
# Tags: buffers, variables, buffer-local, metadata
---
Store buffer-specific data using buffer-local variables.

```lua
local bufnr = vim.api.nvim_create_buf(false, true)

-- Set buffer-local variables
vim.b[bufnr].custom_type = "tool_output"
vim.b[bufnr].created_at = os.time()
vim.b[bufnr].metadata = {
  owner = "plugin_name",
  version = "1.0",
}

-- Read buffer-local variables
local function get_buffer_info(buf)
  buf = buf or 0
  return {
    type = vim.b[buf].custom_type,
    created = vim.b[buf].created_at,
    metadata = vim.b[buf].metadata,
  }
end

-- Check if buffer has specific variable
if vim.b[bufnr].custom_type then
  print("This is a special buffer:", vim.b[bufnr].custom_type)
end
```

**Source:** Community contributed
***
# Title: Get buffer by name or number
# Category: Buffers
# Tags: buffers, find, search, lookup
---
Find buffers by name or number programmatically.

```lua
-- Get buffer by name
local function get_buffer_by_name(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match(name) then
      return buf
    end
  end
  return nil
end

-- Get buffer by exact name
local bufnr = vim.fn.bufnr("myfile.txt")
if bufnr ~= -1 then
  print("Found buffer:", bufnr)
end

-- Get all loaded buffers
local function get_loaded_buffers()
  local bufs = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      table.insert(bufs, {
        bufnr = buf,
        name = vim.api.nvim_buf_get_name(buf),
      })
    end
  end
  return bufs
end

-- Usage
local loaded = get_loaded_buffers()
for _, buf in ipairs(loaded) do
  print(buf.bufnr, buf.name)
end
```

**Source:** Community contributed
***
# Title: Create custom buffer picker
# Category: Buffers
# Tags: buffers, picker, selection, ui
---
Build a simple buffer picker using scratch buffer and floating window.

```lua
local function buffer_picker()
  -- Get all buffers
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and
       vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      name = name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "[No Name]"
      table.insert(buffers, {
        bufnr = buf,
        display = string.format("%d: %s", buf, name)
      })
    end
  end

  -- Create picker buffer
  local picker_buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.tbl_map(function(b) return b.display end, buffers)
  vim.api.nvim_buf_set_lines(picker_buf, 0, -1, false, lines)

  -- Open in floating window
  local width = 60
  local height = math.min(#buffers + 2, 20)
  local win = vim.api.nvim_open_win(picker_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = 5,
    col = 10,
    style = "minimal",
    border = "rounded",
    title = " Buffers ",
    title_pos = "center",
  })

  -- Select buffer on Enter
  vim.keymap.set("n", "<CR>", function()
    local line = vim.fn.line(".")
    local selected = buffers[line]
    if selected then
      vim.api.nvim_win_close(win, true)
      vim.api.nvim_set_current_buf(selected.bufnr)
    end
  end, {buffer = picker_buf})

  -- Close on Esc or q
  for _, key in ipairs({"<Esc>", "q"}) do
    vim.keymap.set("n", key, function()
      vim.api.nvim_win_close(win, true)
    end, {buffer = picker_buf})
  end

  vim.bo[picker_buf].bufhidden = "wipe"
end

vim.api.nvim_create_user_command("Buffers", buffer_picker, {})
```

**Source:** Community contributed
***
# Title: Watch buffer for changes
# Category: Buffers
# Tags: buffers, watch, events, attach
---
Use `nvim_buf_attach()` to monitor buffer changes in real-time.

```lua
-- Attach to buffer and watch changes
local function watch_buffer(bufnr)
  bufnr = bufnr or 0

  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function(_, buf, _, first_line, last_line_old, last_line_new)
      print(string.format(
        "Lines changed in buffer %d: %d-%d (was %d lines, now %d)",
        buf, first_line, last_line_new,
        last_line_old - first_line,
        last_line_new - first_line
      ))

      -- React to changes
      -- e.g., auto-format, validate, update UI

      return false  -- don't detach
    end,

    on_changedtick = function(_, buf, tick)
      -- Called on every change (more frequent)
      print("Buffer changed, tick:", tick)
      return false
    end,

    on_detach = function(_, buf)
      print("Detached from buffer", buf)
    end,

    on_reload = function(_, buf)
      print("Buffer reloaded", buf)
      return false
    end,
  })
end

-- Example: Auto-save scratch buffer
local function create_auto_save_buffer()
  local bufnr = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function()
      -- Save to temporary file
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local file = "/tmp/neovim_scratch.txt"
      vim.fn.writefile(lines, file)
      return false
    end,
  })

  return bufnr
end
```

**Source:** Community contributed
***
# Title: Delete buffer safely
# Category: Buffers
# Tags: buffers, delete, close, safe
---
Delete buffers with proper checks and force options.

```lua
-- Safe buffer delete
local function delete_buffer(bufnr, force)
  bufnr = bufnr or 0
  force = force or false

  -- Check if buffer exists
  if not vim.api.nvim_buf_is_valid(bufnr) then
    print("Buffer doesn't exist")
    return false
  end

  -- Check if buffer is modified (unless force)
  if not force and vim.bo[bufnr].modified then
    print("Buffer has unsaved changes. Use force=true to delete anyway")
    return false
  end

  -- Delete buffer
  vim.api.nvim_buf_delete(bufnr, {force = force})
  return true
end

-- Delete all buffers except current
local function delete_other_buffers()
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      delete_buffer(buf, false)
    end
  end
end

-- Delete all hidden/unlisted buffers
local function delete_hidden_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not vim.bo[buf].buflisted and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, {force = true})
    end
  end
end

vim.api.nvim_create_user_command("BufOnly", delete_other_buffers, {})
vim.api.nvim_create_user_command("BufClean", delete_hidden_buffers, {})
```

**Source:** Community contributed
***
# Title: Create terminal buffer programmatically
# Category: Buffers
# Tags: buffers, terminal, shell, interactive
---
Create and manage terminal buffers using the API.

```lua
-- Create terminal buffer
local function create_terminal(cmd)
  cmd = cmd or vim.o.shell

  -- Create buffer for terminal
  local bufnr = vim.api.nvim_create_buf(false, true)

  -- Open terminal in buffer
  local term_id = vim.fn.termopen(cmd, {
    on_exit = function(job_id, exit_code, event)
      print("Terminal exited with code:", exit_code)
      vim.api.nvim_buf_delete(bufnr, {force = true})
    end,
  })

  -- Set buffer options
  vim.bo[bufnr].bufhidden = "hide"

  return bufnr, term_id
end

-- Open terminal in split
local function terminal_split(cmd, vertical)
  local bufnr, term_id = create_terminal(cmd)

  if vertical then
    vim.cmd("vsplit")
  else
    vim.cmd("split")
  end

  vim.api.nvim_win_set_buf(0, bufnr)

  -- Enter insert mode
  vim.cmd("startinsert")

  return bufnr, term_id
end

-- Open terminal in floating window
local function terminal_float(cmd)
  local bufnr, term_id = create_terminal(cmd)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.cmd("startinsert")

  return bufnr, term_id
end

-- Commands
vim.api.nvim_create_user_command("TermFloat", function(opts)
  terminal_float(opts.args ~= "" and opts.args or nil)
end, {nargs = "?"})
```

**Source:** Community contributed
***
# Title: Buffer namespaces for isolated state
# Category: Buffers
# Tags: buffers, namespaces, isolation, extmarks
---
Use namespaces to manage buffer decorations and state in isolation.

```lua
-- Create namespace for your plugin/feature
local ns_id = vim.api.nvim_create_namespace("my_plugin")

-- Namespace provides isolation for:
-- - Extmarks
-- - Virtual text
-- - Highlights
-- - Signs

-- Add decorations in namespace
local function decorate_buffer(bufnr)
  bufnr = bufnr or 0

  -- Clear previous decorations
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  -- Add new decorations
  vim.api.nvim_buf_set_extmark(bufnr, ns_id, 0, 0, {
    virt_text = {{"Plugin Loaded", "Comment"}},
    virt_text_pos = "eol",
  })
end

-- Multiple namespaces don't conflict
local ns_errors = vim.api.nvim_create_namespace("errors")
local ns_hints = vim.api.nvim_create_namespace("hints")

-- Clear specific namespace
vim.api.nvim_buf_clear_namespace(0, ns_errors, 0, -1)

-- List all extmarks in namespace
local marks = vim.api.nvim_buf_get_extmarks(
  0, ns_id, 0, -1, {details = true}
)
```

**Source:** Community contributed
***
# Title: Build a simple notes buffer system
# Category: Buffers
# Tags: buffers, notes, scratch, practical
---
Create a complete notes system using scratch buffers.

```lua
local M = {}
local notes_buffers = {}

function M.create_note(title)
  title = title or "Note"

  -- Create scratch buffer
  local bufnr = vim.api.nvim_create_buf(true, false)

  -- Set buffer name and options
  local filename = title:gsub("%s+", "_") .. ".md"
  vim.api.nvim_buf_set_name(bufnr, filename)
  vim.bo[bufnr].filetype = "markdown"
  vim.bo[bufnr].buftype = ""

  -- Add header
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
    "# " .. title,
    "",
    "Created: " .. os.date("%Y-%m-%d %H:%M"),
    "",
    "---",
    "",
  })

  -- Track note
  notes_buffers[bufnr] = {
    title = title,
    created = os.time(),
  }

  -- Switch to note
  vim.api.nvim_set_current_buf(bufnr)

  -- Jump to end
  vim.cmd("normal! G")

  return bufnr
end

function M.list_notes()
  local notes = {}
  for bufnr, info in pairs(notes_buffers) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      table.insert(notes, {
        bufnr = bufnr,
        title = info.title,
        lines = vim.api.nvim_buf_line_count(bufnr),
      })
    end
  end
  return notes
end

function M.delete_note(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if notes_buffers[bufnr] then
    vim.api.nvim_buf_delete(bufnr, {force = true})
    notes_buffers[bufnr] = nil
    print("Note deleted")
  end
end

-- Commands
vim.api.nvim_create_user_command("NoteNew", function(opts)
  M.create_note(opts.args)
end, {nargs = "?"})

vim.api.nvim_create_user_command("NoteList", function()
  local notes = M.list_notes()
  for _, note in ipairs(notes) do
    print(string.format("%d: %s (%d lines)",
      note.bufnr, note.title, note.lines))
  end
end, {})

return M
```

**Source:** Community contributed
***
# Title: Close all buffers
# Category: Buffers
# Tags: buffers, close
---


```lua
:%bd

%bd!
```

**Source:** Community contributed
***
# Title: Close all buffers except the current one
# Category: Buffers
# Tags: buffers, close
---


```vim
vim.keymap.set("n", "<leader>X", "<cmd>%bd|e#<cr>", { desc = "Close other", noremap = true, silent = true })
```

```lua
:%bd|e#
```

**Source:** Community contributed
***
# Title: Python Help in Preview Window
# Category: buffer_management
# Tags: python, documentation, preview-window
---
Display Python documentation in Vim's preview window, supporting module and method lookups

```vim
command! -nargs=1 -bar Pyhelp :call ShowPydoc(<f-args>)
function! ShowPydoc(what)
  let path = $TEMP . '/' . a:what . '.pydoc'
  call system(s:pydoc_path . " " . a:what . (&shellredir))
  execute "pedit" fnameescape(path)
endfunction
```

```lua
vim.api.nvim_create_user_command('Pyhelp', function(opts)
  local what = opts.args
  local path = vim.fn.tempname() .. '/' .. what .. '.pydoc'
  vim.fn.system('pydoc ' .. what .. ' > ' .. path)
  vim.cmd.pedit(path)
end, { nargs = 1 })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Access_Python_Help)
***
# Title: Automatically Open All Buffers in Tabs
# Category: buffer_management
# Tags: buffers, tabs, workflow
---
Automatically convert all opened buffers into tabs for easier navigation

```vim
autocmd BufReadPost * tab ball
```

```lua
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    vim.cmd('tab ball')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Add_open-in-tabs_context_menu_for_Windows)
***
# Title: Create a GDB Console Buffer in Vim
# Category: buffer_management
# Tags: debugging, gdb, buffer-management
---
Enhance gdbvim to create a console buffer for capturing and displaying GDB output within Vim

```vim
function! s:GdbFocusBuf(nameref)
  let l:oldnr = bufnr("%")
  let l:win_nu = bufwinnr(a:nameref)
  if l:win_nu > 0
    execute l:win_nu "wincmd w"
  else
    if bufexists(a:nameref)
      execute "sbuffer" a:nameref
    else
      execute "new" a:nameref
    endif
  endif
  return l:oldnr
endfunction
```

```lua
function _G.gdb_focus_buf(nameref)
  local oldnr = vim.fn.bufnr('%')
  local win_nu = vim.fn.bufwinnr(nameref)
  if win_nu > 0 then
    vim.cmd(win_nu .. 'wincmd w')
  else
    if vim.fn.bufexists(nameref) then
      vim.cmd('sbuffer ' .. nameref)
    else
      vim.cmd('new ' .. nameref)
    end
  end
  return oldnr
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Adding_a_console_to_gdbvim)
***
# Title: Customize Buffer Menu Display for Quick Navigation
# Category: buffer_management
# Tags: buffers, menu-customization, navigation
---
Run a command or macro across all open buffers, with options to save or update files automatically

```vim
:bufdo execute "normal! @a" | update

" Restore current buffer after command
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
```

```lua
-- Execute macro across all buffers
vim.cmd('bufdo execute "normal! @a" | update')

-- Lua equivalent of BufDo function
function _G.buf_do(command)
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd('bufdo ' .. command)
  vim.api.nvim_set_current_buf(current_buf)
end

-- Create a user command
vim.api.nvim_create_user_command('Bufdo', function(opts)
  _G.buf_do(opts.args)
end, { nargs = '+' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Argdo)
***
# Title: Automatic Write on Buffer Switch
# Category: buffer_management
# Tags: auto-write, buffer, file-save
---
Automatically save files when switching buffers or performing certain actions

```vim
set autowrite
set autowriteall
```

```lua
vim.opt.autowrite = true
vim.opt.autowriteall = true
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost)
***
# Title: Preserve Window View When Switching Buffers
# Category: buffer_management
# Tags: buffer-navigation, window-view, autocmd
---
Automatically save and restore window view (scroll position) when switching between buffers, preventing unexpected screen repositioning

```vim
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
```

```lua
local function auto_save_win_view()
    if vim.w.SavedBufView == nil then
        vim.w.SavedBufView = {}
    end
    vim.w.SavedBufView[vim.api.nvim_get_current_buf()] = vim.fn.winsaveview()
end

local function auto_restore_win_view()
    local buf = vim.api.nvim_get_current_buf()
    if vim.w.SavedBufView and vim.w.SavedBufView[buf] then
        local v = vim.fn.winsaveview()
        local at_start_of_file = v.lnum == 1 and v.col == 0
        if at_start_of_file and not vim.wo.diff then
            vim.fn.winrestview(vim.w.SavedBufView[buf])
        end
        vim.w.SavedBufView[buf] = nil
    end
end

local augroup = vim.api.nvim_create_augroup('PreserveWindowView', { clear = true })
vim.api.nvim_create_autocmd('BufLeave', {
    group = augroup,
    callback = auto_save_win_view
})
vim.api.nvim_create_autocmd('BufEnter', {
    group = augroup,
    callback = auto_restore_win_view
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers)
***
# Title: Restore Original Buffer After Buffer Operations
# Category: buffer_management
# Tags: buffer-navigation, command-line, custom-functions
---
Create a custom function to run a command across buffers while maintaining the original buffer context

```vim
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
```

```lua
function _G.buf_do(command)
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd('bufdo ' .. command)
  vim.api.nvim_set_current_buf(current_buf)
end

vim.api.nvim_create_user_command('BufDo', function(opts)
  _G.buf_do(opts.args)
end, { nargs = '+' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Bufdo)
***
# Title: Efficient Buffer Navigation
# Category: buffer_management
# Tags: buffers, navigation, jumping
---
Quickly navigate and manage buffers using built-in Vim commands

```vim
:bnext
:bprev
:b <number>
:b <partial_name>
Ctrl-^
Ctrl-O
Ctrl-I
```

```lua
-- Next/Previous Buffer
vim.cmd('bnext')
vim.cmd('bprev')

-- Jump between buffers
vim.keymap.set('n', '<C-^>', '<C-^>', { desc = 'Toggle last buffer' })
vim.keymap.set('n', '<C-o>', '<C-o>', { desc = 'Jump back' })
vim.keymap.set('n', '<C-i>', '<C-i>', { desc = 'Jump forward' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Buffer)
***
# Title: Create Floating Buffer Menu in GVim
# Category: buffer_management
# Tags: buffer-navigation, menu-customization, gui
---
Use :tearoff Buffers to create a floating menu for easy buffer switching in GVim

```vim
" Auto-open buffer menu on startup
autocmd VimEnter * tearoff Buffers

" Limit buffer menu path length
let g:bmenu_max_pathlen=0
```

```lua
-- Neovim equivalent (note: may require different approach)
-- Consider using telescope.nvim or other buffer management plugins
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd('tearoff Buffers')
  end
})

-- Limit buffer menu path length
vim.g.bmenu_max_pathlen = 0
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Buffer_bar_to_list_buffers)
***
# Title: Advanced CSV File Navigation and Manipulation
# Category: buffer_management
# Tags: csv, data-processing, text-manipulation
---
Powerful functions for working with CSV files, including column highlighting, searching within columns, and sorting by specific columns

```vim
" Highlight a specific column in CSV
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^([^,]*,)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
```

```lua
-- Highlight a specific column in CSV
local function csv_highlight(colnr)
  if colnr > 1 then
    local n = colnr - 1
    vim.cmd('match Keyword /^([^,]*,){'..n..'}\\zs[^,]*/')
    vim.cmd('normal! 0'..n..'f,')
  elseif colnr == 1 then
    vim.cmd('match Keyword /^[^,]*/')
    vim.cmd('normal! 0')
  else
    vim.cmd('match')
  end
end

vim.api.nvim_create_user_command('Csv', function(opts)
  csv_highlight(tonumber(opts.args))
end, { nargs = 1 })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/CSV)
***
# Title: Cycle Through Buffers Intelligently
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, advanced-cycling
---
Advanced buffer cycling function that handles help buffers and gaps in buffer numbering, allowing seamless navigation between buffers

```vim
function! SwitchToNextBuffer(incr)
  let help_buffer = (&filetype == 'help')
  let current = bufnr("%")
  let last = bufnr("$")
  let new = current + a:incr
  while 1
    if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer)
      execute ":buffer ".new
      break
    else
      let new = new + a:incr
      if new < 1
        let new = last
      elseif new > last
        let new = 1
      endif
      if new == current
        break
      endif
    endif
  endwhile
endfunction
nnoremap <silent> <C-n> :call SwitchToNextBuffer(1)<CR>
nnoremap <silent> <C-p> :call SwitchToNextBuffer(-1)<CR>
```

```lua
function _G.switch_to_next_buffer(incr)
  local help_buffer = vim.bo.filetype == 'help'
  local current = vim.fn.bufnr('%')
  local last = vim.fn.bufnr('$')
  local new = current + incr
  
  while true do
    if new ~= 0 and vim.fn.bufexists(new) and 
       (vim.fn.getbufvar(new, '&filetype') == 'help') == help_buffer then
      vim.cmd('buffer ' .. new)
      break
    else
      new = new + incr
      if new < 1 then
        new = last
      elseif new > last then
        new = 1
      end
      
      if new == current then
        break
      end
    end
  end
end

vim.keymap.set('n', '<C-n>', function() _G.switch_to_next_buffer(1) end, { silent = true })
vim.keymap.set('n', '<C-p>', function() _G.switch_to_next_buffer(-1) end, { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Cycle_through_buffers_including_hidden_buffers)
***
# Title: Delete Buffer Without Closing Window
# Category: buffer_management
# Tags: buffer, window-layout, workflow
---
Provides a custom command to delete a buffer while preserving the current window layout, avoiding accidental window closures

```vim
" Define custom Bclose command in ~/.vim/plugin/bclose.vim
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>
```

```lua
-- Lua equivalent for buffer management
function _G.bclose(bang, buffer)
  local btarget = vim.fn.bufnr(buffer or '%')
  if btarget < 0 then
    print('No matching buffer')
    return
  end
  
  -- Switch to alternate buffer or previous buffer if possible
  local alt_buf = vim.fn.bufnr('#')
  if alt_buf > 0 and vim.bo.buflisted then
    vim.cmd.buffer(alt_buf)
  else
    vim.cmd.bprevious()
  end
  
  -- Delete original buffer
  vim.cmd(string.format('bdelete%s %d', bang and '!' or '', btarget))
end

-- Set up mapping
vim.keymap.set('n', '<leader>bd', _G.bclose, { desc = 'Close buffer without closing window' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Deleting_a_buffer_without_changing_your_window_layout)
***
# Title: Diff Current Buffer with Saved File
# Category: buffer_management
# Tags: diff, file-comparison, buffer-manipulation
---
Create a side-by-side diff view comparing the current buffer with its saved version, allowing quick review of unsaved changes

```vim
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
```

```lua
function _G.diff_with_saved()
  local filetype = vim.bo.filetype
  vim.cmd('diffthis')
  vim.cmd('vnew')
  vim.cmd('read #')
  vim.cmd('normal! 1Gdd')
  vim.cmd('diffthis')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.readonly = true
  vim.bo.filetype = filetype
end

vim.api.nvim_create_user_command('DiffSaved', _G.diff_with_saved, {})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Diff_current_buffer_and_the_original_file)
***
# Title: Version Control Diff Functions
# Category: buffer_management
# Tags: git, svn, version-control, diff
---
Quick diff functions for comparing current buffer with version control checked-out versions for Git and SVN

```vim
function! s:DiffWithGITCheckedOut()
  let filetype=&ft
  diffthis
  vnew | exe "%!git diff " . fnameescape( expand("#:p") ) . "| patch -p 1 -Rs -o /dev/stdout"
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
  diffthis
endfunction
com! DiffGIT call s:DiffWithGITCheckedOut()
```

```lua
function _G.diff_with_git_checkout()
  local filetype = vim.bo.filetype
  vim.cmd('diffthis')
  vim.cmd('vnew')
  vim.cmd('read !git diff ' .. vim.fn.fnameescape(vim.fn.expand('#:p')) .. '| patch -p 1 -Rs -o /dev/stdout')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.readonly = true
  vim.bo.filetype = filetype
  vim.cmd('diffthis')
end

vim.api.nvim_create_user_command('DiffGIT', _G.diff_with_git_checkout, {})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Diff_current_buffer_and_the_original_file)
***
# Title: Flexible Buffer Switching with Function
# Category: buffer_management
# Tags: buffer-navigation, custom-function, fuzzy-matching
---
A simple mapping to quickly list buffers and switch between them using a single key press

```vim
nnoremap <F5> :buffers<CR>:buffer<Space>
```

```lua
vim.keymap.set('n', '<F5>', function()
  vim.cmd('buffers')
  vim.cmd('buffer ')
end, { desc = 'List and switch buffers' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Easier_buffer_switching)
***
# Title: Automatically Switch to Existing Vim Instance
# Category: buffer_management
# Tags: remote-editing, multi-instance, vim-server
---
Automatically detect and switch to an existing Vim instance when opening a file that's already open in another Vim window

```vim
function! AskVims()
  let full_name = escape(expand("<afile>:p"), ' ')
  for i in split(serverlist())
    if i != v:servername
      if remote_expr(i, 'bufexists("' . full_name . '")')
        echo 'found in ' . i
        call remote_foreground(i)
        call remote_expr(i, 'foreground()')
        let v:swapchoice = 'q'
        return
      endif
    endif
  endfor
  echo "not found"
  let v:swapchoice = ''
endfunction
auto SwapExists * call AskVims()
```

```lua
local function ask_vims()
  local full_name = vim.fn.escape(vim.fn.expand('<afile>:p'), ' ')
  local servers = vim.fn.split(vim.fn.serverlist())
  
  for _, server in ipairs(servers) do
    if server ~= vim.v.servername then
      if vim.fn.remote_expr(server, 'bufexists("' .. full_name .. '")') == 1 then
        print('found in ' .. server)
        vim.fn.remote_foreground(server)
        vim.fn.remote_expr(server, 'foreground()')
        vim.v.swapchoice = 'q'
        return
      end
    end
  end
  
  print('not found')
  vim.v.swapchoice = ''
end

vim.api.nvim_create_autocmd('SwapExists', {
  callback = ask_vims
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Edit_file_in_existing_vim_automatically)
***
# Title: Use Temporary Files for SQL Query Results
# Category: buffer_management
# Tags: sql, temporary-files, external-commands
---
Utilize Vim's tempname() function to create and manage temporary files for SQL query results, which are automatically cleaned up

```vim
au FileType sql map <F12> :let fname = tempname()<CR><C-W><C-O>:silent exe "w !isql -SYourServerName -DYourDatabaseName -UYourUserName -PYourPassword > " . fname<CR>:exe "split " . fname<CR>
```

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sql',
  callback = function()
    vim.keymap.set('n', '<F12>', function()
      local fname = vim.fn.tempname()
      vim.cmd('silent w !isql -SYourServerName -DYourDatabaseName -UYourUserName -PYourPassword > ' .. fname)
      vim.cmd('split ' .. fname)
    end, { buffer = true })
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Execute_sybase-sql_queries_and_see_the_result_in_a_split_window)
***
# Title: Quick Buffer Navigation Shortcuts
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, productivity
---
Easily switch between the first nine buffers using Alt+number keys or cycle through buffers with Alt+Left/Right

```vim
" Method 1: Direct buffer access
:map <M-1> :confirm :b1 <CR>
:map <M-2> :confirm :b2 <CR>
:map <M-9> :confirm :b9 <CR>

" Method 2: Cycle through buffers
:nmap <M-Left> :bprev<CR>
:nmap <M-Right> :bnext<CR>
```

```lua
-- Method 1: Direct buffer access
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', function() 
    vim.cmd('confirm buffer ' .. i) 
  end)
end

-- Method 2: Cycle through buffers
vim.keymap.set('n', '<M-Left>', ':bprev<CR>')
vim.keymap.set('n', '<M-Right>', ':bnext<CR>')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Fast_access_to_the_first_nine_buffers)
***
# Title: Fast Buffer Navigation with Ctrl-^
# Category: buffer_management
# Tags: buffer-navigation, key-mapping
---
Quickly switch to buffers by number using Ctrl-^ instead of :b command

```vim
" Use Ctrl-^ with buffer number to switch
" 1<C-^> switches to buffer 1
" <C-^> without number switches to previous buffer
```

```lua
-- Builtin Vim/Neovim behavior, no specific Lua configuration needed
-- Use vim.cmd() if you want to map this programmatically
vim.keymap.set('n', '<C-^>', '<C-^>', { desc = 'Switch to buffer by number' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Fast_buffer_navigation_by_buffer_numbers)
***
# Title: Cycle Through Buffers Efficiently
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, cycle-buffers
---
Provides flexible methods to cycle through buffers, including handling unlisted buffers and maintaining context between different buffer types

```vim
" Simple buffer cycling
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>

" Advanced buffer cycling with unlisted buffers support
function! SwitchToNextBuffer(incr)
  let help_buffer = (&filetype == 'help')
  let current = bufnr("%")
  let last = bufnr("$")
  let new = current + a:incr
  while 1
    if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer)
      execute ":buffer ".new
      break
    else
      let new = new + a:incr
      if new < 1
        let new = last
      elseif new > last
        let new = 1
      endif
      if new == current
        break
      endif
    endif
  endwhile
endfunction
nnoremap <silent> <C-n> :call SwitchToNextBuffer(1)<CR>
nnoremap <silent> <C-p> :call SwitchToNextBuffer(-1)<CR>
```

```lua
-- Simple buffer cycling
vim.keymap.set('n', '<C-n>', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { noremap = true })

-- Advanced buffer cycling with unlisted buffers support
local function switch_to_next_buffer(incr)
  local help_buffer = (vim.bo.filetype == 'help')
  local current = vim.fn.bufnr('%')
  local last = vim.fn.bufnr('$')
  local new = current + incr
  
  while true do
    if new ~= 0 and vim.fn.bufexists(new) and 
       (vim.fn.getbufvar(new, '&filetype') == 'help') == help_buffer then
      vim.cmd('buffer ' .. new)
      break
    else
      new = new + incr
      if new < 1 then
        new = last
      elseif new > last then
        new = 1
      end
      
      if new == current then
        break
      end
    end
  end
end

vim.keymap.set('n', '<C-n>', function() switch_to_next_buffer(1) end, { silent = true })
vim.keymap.set('n', '<C-p>', function() switch_to_next_buffer(-1) end, { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Fast_switching_between_buffers)
***
# Title: Handle Modified Buffers Flexibly
# Category: buffer_management
# Tags: buffer-options, file-saving, workflow
---
Multiple strategies for handling modified buffers when switching, including auto-save and hidden buffer modifications

```vim
" Option 1: Auto save buffers
set autowrite

" Option 2: Allow hidden modified buffers
set hidden

" Option 3: Force buffer switch without saving
:bnext!
:bprevious!
```

```lua
-- Option 1: Auto save buffers
vim.opt.autowrite = true

-- Option 2: Allow hidden modified buffers
vim.opt.hidden = true

-- Option 3: Force buffer switch without saving can be done via:
-- :bnext! or :bprevious! in command mode
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Fast_switching_between_buffers)
***
# Title: Filter Buffer Lines by Search Pattern
# Category: buffer_management
# Tags: search, filtering, buffer-manipulation
---
Quickly create a new buffer with lines matching a specific search pattern, allowing easy inspection of matching lines

```vim
function! Gather(pattern)
  if !empty(a:pattern)
    let save_cursor = getpos(".")
    let orig_ft = &ft
    let results = []
    execute "g/" . a:pattern . "/call add(results, getline('.'))"
    call setpos('.', save_cursor)
    if !empty(results)
      new
      setlocal buftype=nofile bufhidden=hide noswapfile
      execute "setlocal filetype=".orig_ft
      call append(1, results)
      1d
    endif
  endif
endfunction

nnoremap <silent> <Leader>f :call Gather(input("Search for: "))<CR>
nnoremap <silent> <Leader>F :call Gather(@/)<CR>
```

```lua
function _G.gather_search_results(pattern)
  if pattern ~= "" then
    local save_cursor = vim.fn.getpos(".")
    local orig_ft = vim.o.filetype
    local results = {}
    
    vim.cmd(string.format("g/%s/call add(results, getline('.'))", pattern))
    
    vim.fn.setpos('.', save_cursor)
    
    if #results > 0 then
      vim.cmd('new')
      vim.bo.buftype = 'nofile'
      vim.bo.bufhidden = 'hide'
      vim.bo.swapfile = false
      vim.bo.filetype = orig_ft
      
      vim.api.nvim_buf_set_lines(0, 0, -1, false, results)
    end
  end
end

vim.keymap.set('n', '<Leader>f', function()
  local pattern = vim.fn.input('Search for: ')
  _G.gather_search_results(pattern)
end, { silent = true })

vim.keymap.set('n', '<Leader>F', function()
  local last_search = vim.fn.getreg('/')
  _G.gather_search_results(last_search)
end, { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Filter_buffer_on_a_search_result)
***
# Title: Enhanced Alternate File Navigation
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, workflow
---
Extends Ctrl-^ to jump to next file when no alternate file exists, improving file switching workflow

```vim
function! MySwitch()
  if expand('#')=="" | silent! next
  else
    exe "normal! \<c-^>"
  endif
endfu
map <C-^> :call MySwitch()<CR>
```

```lua
function _G.enhanced_file_switch()
  if vim.fn.expand('#') == '' then
    vim.cmd.next()
  else
    vim.cmd('normal! ^')
  end
end

vim.keymap.set('n', '<C-^>', _G.enhanced_file_switch, { desc = 'Switch to alternate or next file' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Go_to_alternate_file_or_next_file_if_no_alternate)
***
# Title: Advanced Hex Editing in Vim/Neovim
# Category: buffer_management
# Tags: hex-editing, binary-files, file-manipulation
---
Provides a robust method to toggle hex mode for editing binary files, with automatic conversion and handling of binary file types

```vim
" Toggle hex mode function
function ToggleHex()
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    let b:oldft=&ft
    let b:oldbin=&bin
    setlocal binary
    silent :e
    let &ft="xxd"
    let b:editHex=1
    %!xxd
  else
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    let b:editHex=0
    %!xxd -r
  endif
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" Mapping to toggle hex mode
command -bar Hexmode call ToggleHex()
```

```lua
local function toggle_hex()
  local modified = vim.o.modified
  local readonly = vim.o.readonly
  local modifiable = vim.bo.modifiable

  vim.o.readonly = false
  vim.bo.modifiable = true

  if not vim.b.edit_hex then
    vim.b.old_ft = vim.bo.filetype
    vim.b.old_bin = vim.bo.binary
    vim.bo.binary = true
    vim.cmd('silent edit')
    vim.bo.filetype = 'xxd'
    vim.b.edit_hex = true
    vim.cmd('%!xxd')
  else
    vim.bo.filetype = vim.b.old_ft
    if not vim.b.old_bin then
      vim.bo.binary = false
    end
    vim.b.edit_hex = false
    vim.cmd('%!xxd -r')
  end

  vim.o.modified = modified
  vim.o.readonly = readonly
  vim.bo.modifiable = modifiable
end

-- Create Hexmode command
vim.api.nvim_create_user_command('Hexmode', toggle_hex, {})

-- Optional key mapping
vim.keymap.set('n', '<C-H>', ':Hexmode<CR>', { noremap = true, silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Hex)
***
# Title: Store Grep Results in a Scratch Buffer
# Category: buffer_management
# Tags: search, command-line, buffer
---
Create a custom command to capture and display global search results in a temporary buffer, allowing easy browsing of matched lines

```vim
command! -nargs=? F let @a='' | execute 'redir @a | silent g/<args>/print' | redir END | silent execute 'new | setlocal bt=nofile | put=split(@a, '\n'') | set syntax=vera | 1d'
```

```lua
vim.api.nvim_create_user_command('F', function(opts)
  -- Capture global search results in a scratch buffer
  local pattern = opts.args
  local results = vim.fn.execute('silent g/' .. pattern .. '/print')
  
  -- Create new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  
  -- Insert results
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(results, '\n'))
end, { nargs = '?' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/How_to_store_grep_results_in_a_buffer_in_Vim%3F)
***
# Title: Switch between buffers, with tab support
# Category: buffer_management
# Tags: buffers, buffer-switching, tabs
---
Flexible buffer switching with tab support, allowing easy navigation between buffers across tabs

```vim
set switchbuf=usetab
nnoremap <F8> :sbnext<CR>
nnoremap <S-F8> :sbprevious<CR>
```

```lua
-- Buffer switching with tab support
vim.opt.switchbuf = 'usetab'
vim.keymap.set('n', '<F8>', ':sbnext<CR>', { noremap = true })
vim.keymap.set('n', '<S-F8>', ':sbprevious<CR>', { noremap = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Introduction_to_using_tab_pages)
***
# Title: Toggle All Buffers in Tabs
# Category: buffer_management
# Tags: buffers, tabs, toggle
---
Quickly toggle between showing all buffers in tabs and closing all but the current tab

```vim
let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>
```

```lua
-- Toggle all buffers in tabs
local notabs = false
vim.keymap.set('n', '<F8>', function()
  notabs = not notabs
  if notabs then
    vim.cmd('tabo')  -- Close all other tabs
  else
    vim.cmd('tab ball')  -- Show all buffers in tabs
    vim.cmd('tabn')  -- Go to the next tab
  end
end, { silent = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Introduction_to_using_tab_pages)
***
# Title: Quick Jump to Recent Buffers
# Category: buffer_management
# Tags: buffer-navigation, jump-list, custom-function
---
Provides a custom function to quickly jump to recently visited buffers using a numbered list, with support for direct jumping via count

```vim
function! JumpBuffers()
   let jumptxt = ""
   redir! => jumptxt
   silent jumps
   redir END
   let byName = {}
   let byIndex = []
   for line in reverse(split(jumptxt, '\n'))
      let name = strpart(line, 16)
      let bufno = bufnr(name)
      if len(name) > 0 && bufno >= 0 && !has_key(byName, name)
         let byIndex += [{'name': name, 'bufno': bufno, 'ix': len(byIndex)+1}]
         let byName[name] = len(byIndex)
      endif
   endfor
   if v:count > 0
      if len(byIndex) >= v:count
         echomsg "Count ".v:count." Jumps to ".byIndex[v:count-1].bufno
         execute "buffer ".byIndex[v:count-1].bufno
      endif
      return
   endif
   echohl Special
   echo "No Buffer Name"
   echohl None
   for ent in byIndex
      echo printf("%2d %6d %s", ent.ix, ent.bufno, ent.name)
   endfor
   let ix = input("Type number and <Enter> (empty cancels): ") + 0
   if ix > 0 && ix <= len(byIndex)
      execute "buffer ".byIndex[ix-1].bufno
   endif
endfunc

" Mappings
nmap go :<C-U>call JumpBuffers()<CR>
nmap <C-G><C-O> 2go
nnoremap g<C-O> go
```

```lua
function _G.jump_buffers()
    local jumptxt = vim.fn.execute('jumps')
    local byName = {}
    local byIndex = {}

    for _, line in ipairs(vim.fn.reverse(vim.fn.split(jumptxt, '\n'))) do
        local name = line:sub(17)
        local bufno = vim.fn.bufnr(name)
        if #name > 0 and bufno >= 0 and not byName[name] then
            table.insert(byIndex, {name = name, bufno = bufno, ix = #byIndex + 1})
            byName[name] = #byIndex
        end
    end

    if vim.v.count > 0 then
        if #byIndex >= vim.v.count then
            vim.cmd('buffer ' .. byIndex[vim.v.count].bufno)
            return
        end
    end

    for _, ent in ipairs(byIndex) do
        print(string.format('%2d %6d %s', ent.ix, ent.bufno, ent.name))
    end

    local ix = tonumber(vim.fn.input('Type number and <Enter> (empty cancels): ')) or 0
    if ix > 0 and ix <= #byIndex then
        vim.cmd('buffer ' .. byIndex[ix].bufno)
    end
end

-- Mappings
vim.keymap.set('n', 'go', _G.jump_buffers, { desc = 'Jump to recent buffers' })
vim.keymap.set('n', '<C-G><C-O>', '2go', { remap = true })
vim.keymap.set('n', 'g<C-O>', 'go', { remap = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Jump_to_recent_buffers)
***
# Title: List Buffers Sorted Alphabetically
# Category: buffer_management
# Tags: buffer, sorting, custom-command
---
Create a custom command to list buffers sorted by filename instead of buffer number

```vim
command! -bang Ls redir @" | silent ls<bang> | redir END | echo " " |
\ perl {
\ my $msg=VIM::Eval('@"');
\ my %list=();
\ my $key, $value;
\ while($msg =~ m/(.*?line\s+\d+)/g)
\ {
\ $value = $1;
\ $value =~ m/"([^"]+)"/);
\ $key = $1;
\ ($^O =~ /mswin/i) and $key = lc($key);
\ $list{$key} = $value;
\ }
\ my $msg = '';
\ for $key (sort keys %list)
\ {
\ $msg .= "$list{$key}\n";
\ }
\ VIM::Msg($msg);
\ }
\ <CR>
```

```lua
-- Note: Requires a different approach in Neovim without Perl
-- A pure Lua solution would involve:
function SortBuffersByName()
  local buffers = {}
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.bufexists(buf) == 1 then
      local name = vim.fn.bufname(buf)
      table.insert(buffers, {name = name, bufnr = buf})
    end
  end

  table.sort(buffers, function(a, b) return a.name < b.name end)

  for _, buf in ipairs(buffers) do
    print(vim.fn.bufname(buf.bufnr))
  end
end

-- Create a user command
vim.api.nvim_create_user_command('Ls', SortBuffersByName, {})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/List_buffers_sorted_by_name)
***
# Title: Quick Buffer List with Timed Display
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, productivity
---
Quickly display buffer list with a timed display, useful for managing multiple open buffers

```vim
nnoremap <m-:> :ls|sleep<CR><CR>
```

```lua
vim.keymap.set('n', '<m-:>', function() 
  vim.cmd('ls') 
  vim.fn.sleep(1) 
end, { desc = 'Display buffer list briefly' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Listing_buffers)
***
# Title: Sync Buffer Modifiability with File Readonly State
# Category: buffer_management
# Tags: buffer-management, file-protection, autocmd
---
Automatically make buffers non-modifiable when the underlying file is read-only, preventing accidental edits

```vim
function UpdateModifiable()
  if !exists("b:setmodifiable")
    let b:setmodifiable = 0
  endif
  if &readonly
    if &modifiable
      setlocal nomodifiable
      let b:setmodifiable = 1
    endif
  else
    if b:setmodifiable
      setlocal modifiable
    endif
  endif
endfunction
autocmd BufReadPost * call UpdateModifiable()
```

```lua
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo.readonly then
      vim.bo.modifiable = false
    else
      vim.bo.modifiable = true
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Make_buffer_modifiable_state_match_file_readonly_state)
***
# Title: Smart Buffer Switching with Tabs
# Category: buffer_management
# Tags: buffer-navigation, tab-management, window-management
---
Configure buffer switching to use tabs intelligently, allowing easy navigation between buffers across different tabs

```vim
" Smart buffer switching
set switchbuf=usetab
nnoremap <F8> :sbnext<CR>
nnoremap <S-F8> :sbprevious<CR>
```

```lua
-- Smart buffer switching
vim.opt.switchbuf = 'usetab'
vim.keymap.set('n', '<F8>', ':sbnext<CR>', { noremap = true })
vim.keymap.set('n', '<S-F8>', ':sbprevious<CR>', { noremap = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Move_through_the_buffer_list_without_wrecking_your_window/tab_layout)
***
# Title: Quick Buffer Navigation with Mouse in GVim
# Category: buffer_management
# Tags: mouse-navigation, buffer-switching, mapping
---
Enhance buffer switching in GVim by remapping right mouse click to exit modes and interact with mini buffer explorer

```vim
imap <RightMouse> <Esc>
nmap <RightMouse> i<LeftMouse>
```

```lua
vim.keymap.set('i', '<RightMouse>', '<Esc>', { desc = 'Exit insert mode with right mouse' })
vim.keymap.set('n', '<RightMouse>', 'i<LeftMouse>', { desc = 'Enter insert mode at mouse click' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Moving_between_buffers_using_mouse)
***
# Title: Execute Commands Across Buffers Safely
# Category: buffer_management
# Tags: buffer, search-replace, automation
---
Perform substitution and automatically save each buffer in the argument list

```vim
argdo %s/foo/bar/gc | w
```

```lua
-- Use vim.cmd for executing argdo with chained commands
vim.cmd('argdo s/foo/bar/gc | w')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Multiple_commands_at_once)
***
# Title: Single Window Buffer Navigation
# Category: buffer_management
# Tags: buffer-navigation, key-mapping, workflow
---
Efficiently navigate between buffers in a single window using custom key mappings

```vim
" Navigate between buffers
:nm <A-Up> :bp!<CR>
:nm <A-Down> :bn!<CR>
:nm <C-F4> :bd!<CR>
```

```lua
-- Buffer navigation mappings
vim.keymap.set('n', '<A-Up>', ':bp!<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<A-Down>', ':bn!<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<C-F4>', ':bd!<CR>', { desc = 'Close current buffer' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/One_big_window)
***
# Title: Quick SVN Diff in Vim Buffer
# Category: buffer_management
# Tags: version-control, diff, subversion
---
Open a new buffer with SVN diff output, set syntax highlighting, and make it a temporary buffer

```vim
map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
```

```lua
vim.keymap.set('n', '<F9>', function()
  vim.cmd('new')
  vim.cmd('read !svn diff')
  vim.opt_local.syntax = 'diff'
  vim.opt_local.buftype = 'nofile'
  vim.cmd('normal! gg')
end, { desc = 'Open SVN diff in new buffer' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_SVN_diff_window)
***
# Title: Open Multiple Files in Separate Tabs
# Category: buffer_management
# Tags: tabs, file-opening, workflow
---
Open multiple files, each in its own tab, either via command line or autocmd

```vim
" Open files in tabs from command line
gvim -p *.py

" Automatically open buffers in tabs
:au BufAdd,BufNewFile * nested tab sball
```

```lua
-- Open files in tabs from command line: use vim.fn.argv() and -p flag

-- Lua equivalent for auto-tabbing buffers
vim.api.nvim_create_autocmd({'BufAdd', 'BufNewFile'}, {
  nested = true,
  callback = function()
    vim.cmd('tab sball')
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_a_buffer_in_its_own_tabpage)
***
# Title: Prevent Tab Opening for Help and Explore
# Category: buffer_management
# Tags: tabs, autocmd, buffer-management
---
Conditionally open tabs, avoiding issues with help and file explorer buffers

```vim
au BufNewFile,BufRead * nested
  \ if &buftype != "help" |
  \   tab sball |
  \ endif
```

```lua
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  nested = true,
  callback = function()
    if vim.opt.buftype:get() ~= 'help' then
      vim.cmd('tab sball')
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_a_buffer_in_its_own_tabpage)
***
# Title: Optimize Vim for Large File Performance
# Category: buffer_management
# Tags: performance, file-handling, large-files
---
Automatically disable resource-intensive features for large files to improve loading speed and memory usage

```vim
" Protect large files from overhead
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
  set eventignore+=FileType
  setlocal bufhidden=unload
  setlocal buftype=nowrite
  setlocal undolevels=-1
endfunction
```

```lua
vim.g.LargeFile = 1024 * 1024 * 10

vim.api.nvim_create_augroup('LargeFile', { clear = true })
vim.api.nvim_create_autocmd('BufReadPre', {
  group = 'LargeFile',
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand('<afile>'))
    if file_size > vim.g.LargeFile or file_size == -2 then
      vim.opt.eventignore:append('FileType')
      vim.bo.bufhidden = 'unload'
      vim.bo.buftype = 'nowrite'
      vim.bo.undolevels = -1
    end
  end
})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Open_big_files_and_work_fast)
***
# Title: Efficient Buffer Switching with Tab Support
# Category: buffer_management
# Tags: buffer-navigation, tab-integration, workflow
---
Configure buffer switching to use tabs, allowing seamless navigation between buffers across different tabs

```vim
" Configure buffer switching to use tabs
set switchbuf=usetab
nnoremap <F8> :sbnext<CR>
nnoremap <S-F8> :sbprevious<CR>
```

```lua
-- Configure buffer switching to use tabs
vim.opt.switchbuf = 'usetab'
vim.keymap.set('n', '<F8>', ':sbnext<CR>', { noremap = true })
vim.keymap.set('n', '<S-F8>', ':sbprevious<CR>', { noremap = true })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Quick_tab_navigation_and_opening)
***
# Title: Reload File Without Losing Undo History
# Category: buffer_management
# Tags: buffer, reload, undo-history
---
Create a custom command to reload a file while preserving undo history, which is useful when you want to revert to the file's saved state without losing recent edit context

```vim
command! Reload %d|r|1d
```

```lua
vim.api.nvim_create_user_command('Reload', function()
  -- Delete buffer contents
  vim.api.nvim_command('normal! ggdG')
  -- Reload current file
  vim.cmd('edit!')
end, {})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Reload_file_without_losing_undo_history)
***
# Title: Advanced File Reload with Cursor Position
# Category: buffer_management
# Tags: buffer, reload, cursor-position
---
A more sophisticated file reload function that preserves cursor position and handles file reloading gracefully

```vim
function! ReloadFile(is_force_pos)
  let position = getpos(".")
  %d
  r
  1d
  if a:is_force_pos
    call setpos(".", position)
  endif
endfunc
```

```lua
function _G.reload_file(force_pos)
  local pos = vim.fn.getpos('.')
  vim.api.nvim_command(':%delete')
  vim.cmd('edit!')
  if force_pos then
    vim.fn.setpos('.', pos)
  end
end

vim.api.nvim_create_user_command('Reload', function()
  _G.reload_file(true)
end, {})
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Reload_file_without_losing_undo_history)
***
# Title: Persist Buffer List Between Vim Sessions
# Category: buffer_management
# Tags: buffer, session-management, viminfo
---
Execute a command (like a macro) across all open buffers and optionally save changes

```vim
:bufdo execute "normal! @a" | update
```

```lua
-- Run macro in register 'a' across all buffers and save changes
for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
  vim.api.nvim_set_current_buf(bufnr)
  vim.cmd('normal! @a')
  vim.cmd('update')
end
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers)
***
# Title: Restore Original Buffer After Multi-Buffer Command
# Category: buffer_management
# Tags: buffer-navigation, buffer-restore
---
Create a function to run commands across buffers while preserving the original buffer context

```vim
function! BufDo(command)
  let currBuff=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . currBuff
endfunction
com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
```

```lua
function _G.buf_do(command)
  local original_buf = vim.api.nvim_get_current_buf()
  vim.cmd('bufdo ' .. command)
  vim.api.nvim_set_current_buf(original_buf)
end

vim.api.nvim_create_user_command('Bufdo', function(opts)
  _G.buf_do(opts.args)
end, { nargs = '+' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers)
***
# Title: Replace Buffer List When Switching Projects
# Category: buffer_management
# Tags: session-management, buffer-control, project-switching
---
Quickly replace existing buffer list when switching between project sessions without exiting Vim

```vim
1,999bdelete
:so ~/v/project2.vim
```

```lua
-- Delete all existing buffers before loading new session
vim.cmd('1,' .. vim.fn.bufnr('$') .. 'bdelete')
vim.cmd('source ~/v/project2.vim')
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip552)
***
# Title: Suppress File Change Warnings in Buffer
# Category: buffer_management
# Tags: autocmd, file-handling, buffer-settings
---
Quickly save all modified buffers without closing Vim, or save and exit all buffers in a single command

```vim
:wa  # Write all changed buffers
:xa  # Save all and exit
:wqa # Alternative save and exit command
```

```lua
vim.cmd('wa')  -- Write all changed buffers
vim.cmd('xa')  -- Save all and exit
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip652)
***
# Title: Easy Buffer Switching with Tab Completion
# Category: buffer_management
# Tags: buffer, navigation, tab-completion
---
Use tab completion to quickly switch between buffers with partial name matching

```vim
" Use tab completion for buffer switching
:buffer <Tab>  " Cycle through partial buffer name matches

" Function to select buffer with partial matches
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

command! -nargs=1 Bs :call BufSel("<args>")
```

```lua
-- Function to select buffer with partial matches
local function buf_sel(pattern)
  local bufcount = vim.fn.bufnr('$')
  local nummatches = 0
  local firstmatchingbufnr = 0

  for currbufnr = 1, bufcount do
    if vim.fn.bufexists(currbufnr) == 1 then
      local currbufname = vim.fn.bufname(currbufnr)
      if currbufname:find(pattern) then
        print(string.format('%d: %s', currbufnr, currbufname))
        nummatches = nummatches + 1
        firstmatchingbufnr = currbufnr
      end
    end
  end

  if nummatches == 1 then
    vim.cmd('buffer ' .. firstmatchingbufnr)
  elseif nummatches > 1 then
    local desiredbufnr = vim.fn.input('Enter buffer number: ')
    if #desiredbufnr > 0 then
      vim.cmd('buffer ' .. desiredbufnr)
    end
  else
    print('No matching buffers')
  end
end

-- Create a user command
vim.api.nvim_create_user_command('Bs', function(opts)
  buf_sel(opts.args)
end, { nargs = 1 })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip686)
***
# Title: Quick Buffer List and Selection Mapping
# Category: buffer_management
# Tags: buffer, mapping, navigation
---
Create a quick mapping to list buffers and allow easy selection by number

```vim
" Quick buffer list and selection
:nnoremap <F5> :buffers<CR>:buffer<Space>
```

```lua
-- Quick buffer list and selection
vim.keymap.set('n', '<F5>', function()
  vim.cmd('buffers')
  vim.cmd('buffer ')
end, { desc = 'List and select buffers' })
```

**Source:** [vim.fandom.com](https://vim.fandom.com/wiki/VimTip686)
***
