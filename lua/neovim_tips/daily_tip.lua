local M = {}

local Popup = require("nui.popup")
local tips = require("neovim_tips.tips")
local config = require("neovim_tips.config")

-- Path to store the last shown date
local function get_state_file()
  return vim.fn.stdpath("data") .. "/neovim_tips/persistent.json"
end

-- Read the last shown date
local function read_last_shown()
  local state_file = get_state_file()
  local file = io.open(state_file, "r")
  if not file then
    return nil
  end

  local content = file:read("*all")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if ok and data and data.last_shown then
    return data.last_shown
  end

  return nil
end

-- Write the current date as last shown
local function write_last_shown()
  local state_file = get_state_file()
  local today = os.date("%Y-%m-%d")
  local data = { last_shown = today }

  -- Ensure directory exists
  local dir = vim.fn.fnamemodify(state_file, ":h")
  vim.fn.mkdir(dir, "p")

  local file = io.open(state_file, "w")
  if file then
    file:write(vim.json.encode(data))
    file:close()
  end
end

-- Check if we should show today's tip
local function should_show_today()
  local today = os.date("%Y-%m-%d")
  local last_shown = read_last_shown()
  return last_shown ~= today
end

-- Get a random tip
local function get_random_tip()
  local all_titles = tips.get_titles()
  if #all_titles == 0 then
    return nil
  end

  math.randomseed(os.time())
  local random_index = math.random(1, #all_titles)
  local title = all_titles[random_index]

  return {
    title = title,
    description = tips.get_description(title)
  }
end

-- Create and show the daily tip popup
function M.show_daily_tip()
  local tip = get_random_tip()
  if not tip then
    return
  end

  -- Create popup with centered layout
  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Neovim tips: Did you know? ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = "60%",
      height = "40%",
    },
    buf_options = {
      modifiable = true,
      readonly = false,
      filetype = "markdown",
    },
    win_options = {
      winblend = 0,
      winhighlight = "Normal:Normal,FloatBorder:Normal,Cursor:NONE,CursorLine:NONE",
      cursorline = false,
      cursorcolumn = false,
      number = false,
      relativenumber = false,
      signcolumn = "no",
    },
  })

  -- Mount the popup
  popup:mount()

  -- Prepare content
  local lines = {}

  -- Add tip title as first line
  table.insert(lines, "# " .. tip.title)

  -- Add tip description (skip the first title line from description)
  if tip.description then
    local description_lines = vim.split(tip.description, "\n")
    -- Skip lines until we find the first non-title line
    local start_index = 1
    for i, line in ipairs(description_lines) do
      if not line:match("^##?%s") then -- Skip ## Title lines
        start_index = i
        break
      end
    end

    for i = start_index, #description_lines do
      table.insert(lines, description_lines[i])
    end
  end

  -- Add footer notes
  table.insert(lines, "")
  table.insert(lines, "---")
  table.insert(lines, "")
  table.insert(lines, "Have your favorite tip? Found an error?  ")
  table.insert(lines, "Please report it [here](" .. config.options.github_url .. ")!")
  table.insert(lines, "")
  table.insert(lines, "For daily tip setup refer to [README](" .. config.options.github_url .. ") file.")
  table.insert(lines, "")

  -- Set content while buffer is modifiable
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)

  -- Position cursor at line 2 (empty line) so markdown renders properly
  vim.api.nvim_win_set_cursor(popup.winid, {2, 0})

  -- NOW lock the buffer
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].readonly = true

  -- Enable markdown rendering if available
  if pcall(require, "render-markdown") then
    vim.api.nvim_buf_call(popup.bufnr, function()
      require("render-markdown").enable()
    end)
  end

  -- Set up keymaps to close
  local close_keys = { "q", "<Esc>" }
  for _, key in ipairs(close_keys) do
    popup:map("n", key, function()
      popup:unmount()
    end, { noremap = true, silent = true })
  end

  -- Clean up when popup closes
  popup:on("BufWinLeave", function()
    -- Nothing to restore since we didn't change global settings
  end)

  -- No auto-close - keep open until user dismisses

  -- Mark as shown today
  write_last_shown()
end

-- Main function to check and show daily tip
function M.check_and_show()
  local daily_tip_mode = config.options.daily_tip

  -- 0 = off, 1 = once per day, 2 = every startup
  if daily_tip_mode == 0 then
    return
  end

  local should_show = (daily_tip_mode == 2) or should_show_today()

  if should_show then
    -- Delay to let Neovim finish startup completely
    vim.defer_fn(function()
      M.show_daily_tip()
    end, 1000)
  end
end

return M
