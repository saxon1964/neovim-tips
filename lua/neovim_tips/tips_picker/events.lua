---@class NeovimTipsEvents
---Event handling and autocmds for the tips picker
local M = {}

local event = require("nui.utils.autocmd").event

---@class EventHandlers
---@field on_search_change function Callback when search text changes
---@field on_selection_change function Callback when selected tip changes
---@field on_help_trigger function(trigger_type: string) Callback when help trigger is detected
---@field focus_search function Callback to focus search popup
---@field focus_titles function Callback to focus titles popup
---@field focus_preview function Callback to focus preview popup
---@field move_up function Callback to move selection up
---@field move_down function Callback to move selection down
---@field select_item function Callback to select current item
---@field close_picker function Callback to close the picker

---Set up keyboard mappings for all popups
---@param layout table The layout components (search_popup, titles_popup, preview_popup)
---@param handlers EventHandlers Event handler callbacks
---@return nil
function M.setup_keymaps(layout, handlers)
  local search_popup = layout.search_popup
  local titles_popup = layout.titles_popup
  local preview_popup = layout.preview_popup

  if not search_popup or not titles_popup or not preview_popup then
    return
  end

  -- Search popup keymaps
  search_popup:map("i", "<Esc>", handlers.close_picker, { noremap = true })
  search_popup:map("i", "<C-c>", handlers.close_picker, { noremap = true })
  search_popup:map("i", "<CR>", handlers.select_item, { noremap = true })
  search_popup:map("i", "<Down>", handlers.move_down, { noremap = true })
  search_popup:map("i", "<Up>", handlers.move_up, { noremap = true })
  search_popup:map("i", "<C-j>", handlers.move_down, { noremap = true })
  search_popup:map("i", "<C-k>", handlers.move_up, { noremap = true })
  search_popup:map("i", "<Tab>", handlers.focus_titles, { noremap = true })
  search_popup:map("i", "<C-l>", handlers.focus_preview, { noremap = true })

  search_popup:map("n", "<Esc>", handlers.close_picker, { noremap = true })
  search_popup:map("n", "q", handlers.close_picker, { noremap = true })
  search_popup:map("n", "<CR>", handlers.select_item, { noremap = true })
  search_popup:map("n", "j", handlers.move_down, { noremap = true })
  search_popup:map("n", "k", handlers.move_up, { noremap = true })
  search_popup:map("n", "<Tab>", handlers.focus_titles, { noremap = true })
  search_popup:map("n", "<C-l>", handlers.focus_preview, { noremap = true })

  -- Titles popup keymaps
  titles_popup:map("n", "<Esc>", handlers.close_picker, { noremap = true })
  titles_popup:map("n", "q", handlers.close_picker, { noremap = true })
  titles_popup:map("n", "<CR>", handlers.select_item, { noremap = true })
  titles_popup:map("n", "j", handlers.move_down, { noremap = true })
  titles_popup:map("n", "k", handlers.move_up, { noremap = true })
  titles_popup:map("n", "<Down>", handlers.move_down, { noremap = true })
  titles_popup:map("n", "<Up>", handlers.move_up, { noremap = true })
  titles_popup:map("n", "<S-Tab>", handlers.focus_search, { noremap = true })
  titles_popup:map("n", "<Tab>", handlers.focus_preview, { noremap = true })
  titles_popup:map("n", "<C-h>", handlers.focus_search, { noremap = true })
  titles_popup:map("n", "<C-l>", handlers.focus_preview, { noremap = true })

  -- Preview popup keymaps
  preview_popup:map("n", "<Esc>", handlers.close_picker, { noremap = true })
  preview_popup:map("n", "q", handlers.close_picker, { noremap = true })
  preview_popup:map("n", "<CR>", handlers.select_item, { noremap = true })
  preview_popup:map("n", "<S-Tab>", handlers.focus_titles, { noremap = true })
  preview_popup:map("n", "<Tab>", handlers.focus_search, { noremap = true })
  preview_popup:map("n", "<C-h>", handlers.focus_titles, { noremap = true })
  preview_popup:map("n", "<C-j>", handlers.focus_search, { noremap = true })
end

---Set up autocmds for real-time search and mouse interaction
---@param layout table The layout components
---@param handlers EventHandlers Event handler callbacks
---@return nil
function M.setup_autocmds(layout, handlers)
  local search_popup = layout.search_popup
  local titles_popup = layout.titles_popup

  if not search_popup or not titles_popup then
    return
  end

  -- Debounced search filtering to reduce flicker
  local search_timer = nil
  local function debounced_search_update()
    if search_timer then
      search_timer:stop()
      search_timer = nil
    end
    search_timer = vim.defer_fn(function()
      local lines = vim.api.nvim_buf_get_lines(search_popup.bufnr, 0, 1, false)
      local search_text = lines[1] or ""

      -- Check for help triggers and handle them
      if handlers.on_help_trigger then
        local search_parser = require("neovim_tips.tips_picker.search_parser")
        local trigger_type = search_parser.check_help_triggers(search_text)
        if trigger_type then
          handlers.on_help_trigger(trigger_type, search_text)
          search_timer = nil
          return
        end
      end

      -- Normal search handling
      if handlers.on_search_change then
        handlers.on_search_change(search_text)
      end
      search_timer = nil
    end, 50) -- 50ms debounce
  end

  search_popup:on(event.TextChangedI, debounced_search_update)
  search_popup:on(event.TextChanged, debounced_search_update)

  -- Mouse click support in titles
  titles_popup:on(event.CursorMoved, function()
    if handlers.on_selection_change then
      local cursor = vim.api.nvim_win_get_cursor(titles_popup.winid)
      local new_index = cursor[1]
      handlers.on_selection_change(new_index)
    end
  end)

  -- Exit insert mode when entering titles panel
  titles_popup:on(event.WinEnter, function()
    vim.cmd("stopinsert")
  end)

  -- Auto-enter insert mode when returning to search
  search_popup:on(event.WinEnter, function()
    -- Set filetype first
    vim.bo[search_popup.bufnr].filetype = "neovim-tips-search"

    -- Aggressively disable all completion for this buffer
    vim.bo[search_popup.bufnr].complete = ""
    vim.bo[search_popup.bufnr].completefunc = ""
    vim.bo[search_popup.bufnr].omnifunc = ""

    vim.cmd("startinsert!")
  end)
end

---Clean up any active timers
---@return nil
function M.cleanup_timers()
  -- Timers are handled within the debounced functions
  -- This function is here for future extension if needed
end

return M