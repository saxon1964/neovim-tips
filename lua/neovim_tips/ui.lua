local M = {}
local tips = require("neovim_tips.tips")

function M.show_fzf()
  local entries = tips.get_all()
  if not entries or #entries == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end

  local fzf_lua = require("fzf-lua")
  local items = {}
  local descriptions = {}
  local tmpName = vim.fn.expand("~/tmp.md")

  for _, tip in ipairs(entries) do
    local line = string.format("%s [%s] (%s)", tip.title, tip.category, table.concat(tip.tags, ","))
    table.insert(items, line)
    descriptions[line] = tip.description
  end

  table.sort(items)
  print(vim.inspect(descriptions))

  fzf_lua.fzf_exec(items, {
    fzf_opts = {
      ["--prompt"] = "Neovim Tips> ",
      ["--preview"] = {
        type = "cmd",
        fn = function(selected)
          local item = selected[1]
          local descrption = descriptions[item] or "No description"
          -- local tmpName = vim.fn.tempname() .. ".md"
          local f = io.open(tmpName, "w")
          if f then
            f:write(descrption)
            f:close()
            return string.format("CLICOLOR_FORCE=1 COLORTERM=truecolor glow %s", tmpName)
          else
            return "echo 'Failed to render preview'"
          end
        end
      },
    },
  })
end

return M

