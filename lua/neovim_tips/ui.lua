local M = {}

local tips = require("neovim_tips.tips")
local fzf_lua = require("fzf-lua")
local MdPreviewer = require("neovim_tips.previewer")

function M.show_fzf()
  local items = tips.get_items()
  if #items == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  fzf_lua.fzf_exec(items, {
    previewer = MdPreviewer,
    prompt = "Search Tips> ",
  })
end

return M

