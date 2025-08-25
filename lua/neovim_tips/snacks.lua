local M = {}

-- Snacks-based picker for Neovim Tips
-- This integrates with folke/snacks.nvim's picker API

local tips = require("neovim_tips.tips")

function M.show()
  -- Lazily require Snacks and validate that the picker module is available
  local ok, Snacks = pcall(require, "snacks")
  if not ok or not Snacks or not Snacks.picker then
    vim.notify(
      "Snacks picker not available. Please install 'folke/snacks.nvim' and enable its picker.",
      vim.log.levels.ERROR
    )
    return
  end

  local titles = tips.get_titles()
  if not titles or #titles == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  -- Build items with inline markdown preview using Snacks' built-in previewer
  local items = {}
  for i, title in ipairs(titles) do
    local content = tips.get_description(title) or ""
    items[i] = {
      text = title,
      preview = {
        text = content,
        ft = "markdown", -- render as markdown
        loc = false,      -- do not show location info
      },
    }
  end

  -- Launch Snacks picker with our items
  Snacks.picker.pick({
    items = items,
    format = "text",
    preview = "preview",
    prompt = "Search Tips> ",
    title = "Neovim Tips",
    confirm = "close", -- close picker on confirm
    focus = "input",
  })
end

return M

