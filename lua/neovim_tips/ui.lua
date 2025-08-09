local M = {}

local config = require("neovim_tips.config")
local tips = require("neovim_tips.tips")
local fzf_lua = require("fzf-lua")

local tmp_file = config.options.tmp_file
local preview_cmd = config.options.md_preview_cmd

function M.show_fzf()
  local entries = tips.get_all()
  if not entries or #entries == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  local items = {}
  local descriptions = {}

  for _, tip in ipairs(entries) do
    local line = string.format("%s [%s] (%s)", tip.title, tip.category, table.concat(tip.tags, ","))
    table.insert(items, line)
    descriptions[line] = tip.description
  end

  table.sort(items)

  fzf_lua.fzf_exec(items, {
    fzf_opts = {
      ["--prompt"] = "Neovim Tips> ",
      ["--preview"] = {
        type = "cmd",
        fn = function(selected)
          local item = selected[1]
          local descrption = descriptions[item] or "No description"
          local f = io.open(tmp_file, "w")
          if f then
            f:write(descrption)
            f:close()
            return string.format(preview_cmd, tmp_file)
          else
            return "echo 'Failed to render preview'"
          end
        end
      },
    },
  })
end

return M

