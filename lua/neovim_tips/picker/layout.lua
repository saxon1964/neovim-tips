---@class NeovimTipsLayout
---UI layout creation and management for the tips picker
local M = {}

local Popup = require("nui.popup")
local Layout = require("nui.layout")

---@class PickerLayout
---@field layout NuiLayout|nil Main layout container
---@field search_popup NuiPopup|nil Search input popup
---@field titles_popup NuiPopup|nil Tips list popup
---@field preview_popup NuiPopup|nil Preview content popup
---@field footer_popup NuiPopup|nil Footer popup with help message

---Create the three-pane layout with search, titles, and preview popups
---Sets up the main UI structure with proper sizing and borders
---@return PickerLayout layout The created layout components
function M.create_layout()
  local components = {}

  -- Create search popup
  components.search_popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Search Tips (t:tag c:category) ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = true,
      readonly = false,
      buftype = "nofile",
      complete = "",
      completefunc = "",
      omnifunc = "",
      filetype = "neovim-tips-search",
    },
    win_options = {
      wrap = false,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  -- Create titles popup
  components.titles_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Tips ",
        top_align = "center",
      },
    },
    buf_options = {
      modifiable = false,
      readonly = false,
      buftype = "nofile",
    },
    win_options = {
      wrap = false,
      number = false,
      cursorline = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  -- Create preview popup
  components.preview_popup = Popup({
    enter = false,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Preview ",
        top_align = "center",
      },
    },
    buf_options = {
      buftype = "nofile",
      modifiable = false,
      readonly = false,
    },
    win_options = {
      wrap = true,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  -- Create footer popup
  components.footer_popup = Popup({
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
    win_options = {
      wrap = false,
      number = false,
      winhighlight = "FloatBorder:Normal",
    },
  })

  -- Create layout
  components.layout = Layout(
    {
      position = "50%",
      size = {
        width = "90%",
        height = "80%",
      },
    },
    Layout.Box({
      Layout.Box(components.search_popup, { size = "10%" }),
      Layout.Box({
        Layout.Box(components.titles_popup, { size = "40%" }),
        Layout.Box(components.preview_popup, { size = "60%" }),
      }, { dir = "row", size = "80%" }),
      Layout.Box(components.footer_popup, { size = "10%" }),
    }, { dir = "col" })
  )

  return components
end

---Mount the layout and all its components
---@param layout PickerLayout The layout to mount
---@return nil
function M.mount_layout(layout)
  if layout.layout then
    layout.layout:mount()
  end
end

---Unmount the layout and clean up components
---@param layout PickerLayout The layout to unmount
---@return nil
function M.unmount_layout(layout)
  if layout.layout then
    layout.layout:unmount()
  end
end

---Update the titles list display with current filtered results
---Updates the titles popup content and applies highlighting to selected item
---Also updates the border title with current tip counts and active filters
---@param titles_popup NuiPopup The titles popup to update
---@param filtered_titles string[] Currently filtered tip titles
---@param all_titles string[] All available tip titles
---@param selected_index integer Currently selected tip index
---@param active_filters table Active search filters for display
---@return nil
function M.update_titles_display(titles_popup, filtered_titles, all_titles, selected_index, active_filters)
  if not titles_popup then return end

  local lines = {}
  for i, title in ipairs(filtered_titles or {}) do
    local prefix = (i == selected_index) and "> " or "  "
    table.insert(lines, prefix .. title)
  end

  -- Show empty state if no results
  if #lines == 0 then
    lines = { "  No matching tips found" }
  end

  -- Update border title with tip count and active filters
  local total_tips = #(all_titles or {})
  local filtered_count = #(filtered_titles or {})
  local title_text = string.format(" Tips: %d/%d ", filtered_count, total_tips)

  -- Add active filter indicators
  local filters = {}
  if active_filters and active_filters.categories and #active_filters.categories > 0 then
    table.insert(filters, "c:" .. table.concat(active_filters.categories, ","))
  end
  if active_filters and active_filters.tags and #active_filters.tags > 0 then
    table.insert(filters, "t:" .. table.concat(active_filters.tags, ","))
  end
  if #filters > 0 then
    title_text = title_text .. "[" .. table.concat(filters, " ") .. "] "
  end

  titles_popup.border:set_text("top", title_text, "center")

  -- Update content with highlighting
  vim.bo[titles_popup.bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(titles_popup.bufnr, 0, -1, false, lines)
  vim.bo[titles_popup.bufnr].modifiable = false

  -- Highlight selected line
  local ns_id = vim.api.nvim_create_namespace("neovim_tips_picker")
  vim.api.nvim_buf_clear_namespace(titles_popup.bufnr, ns_id, 0, -1)
  if selected_index > 0 and selected_index <= #lines then
    local line_content = lines[selected_index]
    local line_length = #line_content

    -- Highlight entire selected line including all text
    vim.api.nvim_buf_set_extmark(titles_popup.bufnr, ns_id, selected_index - 1, 0, {
      end_col = line_length,
      hl_group = "Visual",
      priority = 100
    })
    -- Highlight the ">" prefix more prominently
    vim.api.nvim_buf_set_extmark(titles_popup.bufnr, ns_id, selected_index - 1, 0, {
      end_col = 2,
      hl_group = "IncSearch",
      priority = 101
    })
  end
end

---Update preview content with markdown rendering
---@param preview_popup NuiPopup The preview popup to update
---@param title string The tip title
---@param content string The tip content
---@param renderer table The markdown renderer
---@return nil
function M.update_preview_content(preview_popup, title, content, renderer)
  if not preview_popup then return end

  -- Update title
  preview_popup.border:set_text("top", " " .. title .. " ", "center")

  -- Update content
  local lines = vim.split(content, "\n")

  vim.bo[preview_popup.bufnr].modifiable = true
  vim.api.nvim_buf_set_lines(preview_popup.bufnr, 0, -1, false, lines)
  vim.bo[preview_popup.bufnr].filetype = "markdown"

  -- Render markdown
  if renderer then
    renderer.render(preview_popup.bufnr)
  end

  vim.bo[preview_popup.bufnr].modifiable = false
end

---Set up the footer popup with help message
---@param footer_popup NuiPopup The footer popup to setup
---@param message string The message to display
---@param renderer table The markdown renderer
---@return nil
function M.setup_footer(footer_popup, message, renderer)
  if not footer_popup then return end

  -- Set the content
  vim.api.nvim_buf_set_lines(footer_popup.bufnr, 0, -1, false, { message })

  -- Set filetype to markdown and enable rendering
  vim.bo[footer_popup.bufnr].filetype = "markdown"
  if renderer then
    renderer.render(footer_popup.bufnr)
  end
end

return M