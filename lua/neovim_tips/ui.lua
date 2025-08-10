local M = {}

local config = require("neovim_tips.config")
local tips = require("neovim_tips.tips")
local fzf_lua = require("fzf-lua")

local tmp_file = config.options.tmp_file
local md_preview_cmd = config.options.md_preview_cmd

function M.show_fzf()
  local items = tips.get_items()
  vim.notify("Tips class returned " .. #items .. " tips", vim.log.levels.INFO)
  if #items == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  vim.notify("Showing " .. #items .. " tips", vim.log.levels.INFO)
  fzf_lua.fzf_exec(items, {
    fzf_opts = {
      ["--prompt"] = "Neovim Tips> ",
      ["--preview"] = {
        type = "cmd",
        fn = function(selected)
          local item = selected[1]
          local description = tips.get_description(item) or "No description"
          local file = io.open(tmp_file, "w")
          if file then
            file:write(description)
            file:close()
            return string.format(md_preview_cmd, tmp_file)
          else
            return "echo 'Failed to render preview'"
          end
        end
      },
    },
  })
end

return M

