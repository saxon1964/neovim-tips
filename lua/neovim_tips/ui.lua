local M = {}

local tips = require("neovim_tips.tips")
local fzf_lua = require("fzf-lua")
local MdPreviewer = require("neovim_tips.previewer")

function M.show_fzf()
  local titles = tips.get_titles()
  if #titles == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  fzf_lua.fzf_exec(titles, {
    previewer = MdPreviewer,
    prompt = "Search Tips> ",
  })
end

return M

