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
***
# Title: Close all buffers
# Category: Buffers
# Tags: buffers, close

To close all buffers use:

```lua
:%bd
```

This will close all read-only and saved buffers but will leave buffers with unsaved changes open. To force buffer closing in all cases, use:

```lua
%bd!
```
***
# Title: Close all buffers except the current one
# Category: Buffers
# Tags: buffers, close

To close all buffers that are read-only or saved except the current one, use:

```lua
:%bd|e#
```

You can also map it to a keyboard shortcut:

```vim
vim.keymap.set("n", "<leader>X", "<cmd>%bd|e#<cr>", { desc = "Close other", noremap = true, silent = true })
```

Instead of `%bd` you can use `%bd!` to force buffer close even if some buffer has unsaved changes. Caution: If your current buffer has unsaved chages, these will be lost (`%bd!` closes all open buffers unconditionaly, `e#` just opens the file attached to the last i.e. current buffer)
***
