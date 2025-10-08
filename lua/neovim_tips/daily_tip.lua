---@class NeovimTipsDailyTip
---Daily tip functionality for showing random tips on startup
local M = {}

local Popup = require("nui.popup")
local Layout = require("nui.layout")
local tips = require("neovim_tips.tips")
local config = require("neovim_tips.config")
local renderer = require("neovim_tips.renderer")
local utils = require("neovim_tips.utils")

---@class DailyTipData
---@field last_shown string Date string in YYYY-MM-DD format

---Get the path to the daily tip state file
---@return string path Path to persistent state JSON file
local function get_state_file()
  return vim.fn.stdpath("data") .. "/neovim_tips/persistent.json"
end

---Read the last shown date from persistent storage
---@return string|nil date Last shown date in YYYY-MM-DD format, or nil if not found
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

---Write the current date as last shown to persistent storage
---@return nil
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

---Check if we should show today's tip based on last shown date
---@return boolean should_show True if tip should be shown today
local function should_show_today()
  local today = os.date("%Y-%m-%d")
  local last_shown = read_last_shown()
  return last_shown ~= today
end

---Get a random tip from the available tips
---@return table|nil tip Random tip with title and description, or nil if no tips available
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

---Create and show the daily tip popup
---Displays a centered layout with main tip popup and footer popup below
---@param update_last_shown boolean true, if last shown date should be updated, false otherwise
---@return nil
local function show_daily_tip(update_last_shown)
  local tip = get_random_tip()
  if not tip then
    return
  end

  -- Close any existing plugin windows first to prevent layering issues
  utils.close_plugin_windows()

  -- Create main tip popup
  local main_popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Neovim tips: Did you know? ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      readonly = false,
    },
    win_options = renderer.get_win_options({
      wrap = true,
      number = false,
      winhighlight = "FloatBorder:Normal",
    }),
  })

  -- Create footer popup
  local footer_popup = Popup({
    enter = false,
    focusable = false,
    border = {
      style = "rounded",
      text = {
        top = " Contribute ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = true,
      readonly = false,
    },
    win_options = renderer.get_win_options({
      wrap = false,
      number = false,
      winhighlight = "FloatBorder:Normal",
    }),
  })

  -- Create layout similar to picker
  local layout = Layout(
    {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = "70%",
        height = "50%",
      },
      relative = "editor",
    },
    Layout.Box({
      Layout.Box(main_popup, { size = "80%" }),
      Layout.Box(footer_popup, { size = "20%" }),
    }, { dir = "col" })
  )

  -- Mount the layout
  layout:mount()

  -- Force redraw to ensure proper rendering over other popups
  vim.cmd('redraw')

  -- Prepare main content
  local lines = {}

  -- Add tip description (now includes the title with consistent formatting)
  if tip.description then
    local description_lines = vim.split(tip.description, "\n")
    for _, line in ipairs(description_lines) do
      table.insert(lines, line)
    end
  end

  -- Temporarily make modifiable to update content
  vim.bo[main_popup.bufnr].modifiable = true

  -- Set main content
  vim.api.nvim_buf_set_lines(main_popup.bufnr, 0, -1, false, lines)
  vim.bo[main_popup.bufnr].filetype = "markdown"

  -- Make non-modifiable again to prevent user editing
  vim.bo[main_popup.bufnr].modifiable = false

  -- Render markdown in main popup
  renderer.render(main_popup.bufnr)

  -- Position cursor at line 2 so markdown renders properly
  vim.api.nvim_win_set_cursor(main_popup.winid, { 2, 0 })

  -- Set up footer content
  local footer_lines = {}
  table.insert(footer_lines, config.options.messages.daily_tip.footer1)
  table.insert(footer_lines, config.options.messages.daily_tip.footer2)

  vim.api.nvim_buf_set_lines(footer_popup.bufnr, 0, -1, false, footer_lines)
  vim.bo[footer_popup.bufnr].filetype = "markdown"

  -- Render markdown in footer
  renderer.render(footer_popup.bufnr)

  -- Set up keymaps to close
  local close_keys = { "q", "<Esc>" }
  for _, key in ipairs(close_keys) do
    main_popup:map("n", key, function()
      layout:unmount()
    end, { noremap = true, silent = true })
  end

  -- Auto-close when user enters command mode to prevent hijacking
  main_popup:map("n", ":", function()
    layout:unmount()
    -- Use feedkeys to properly enter command mode
    vim.api.nvim_feedkeys(":", "n", true)
  end, { noremap = true, silent = true })

  -- Auto-close when user tries to leave the window
  main_popup:on("BufLeave", function()
    -- Small delay to prevent immediate closure, but close if user actually switched focus
    vim.defer_fn(function()
      if main_popup.winid and vim.api.nvim_win_is_valid(main_popup.winid) then
        local current_win = vim.api.nvim_get_current_win()
        if current_win ~= main_popup.winid then
          layout:unmount()
        end
      end
    end, 50)
  end)

  -- Mark as shown today conditionally
  if update_last_shown then
    write_last_shown()
  end
end

---Main function to check and show daily tip based on configuration
---Respects the daily_tip configuration option and shows tip according to the mode:
---0=off, 1=once per day, 2=every startup
---@return nil
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
      -- Shows daily tip and updates last display time
      show_daily_tip(true)
    end, 1000)
  end
end

---Function to show daily tip unconditionally
---@return nil
function M.show()
  -- Shows random tip and does not update last display time
  show_daily_tip(false)
end

return M
