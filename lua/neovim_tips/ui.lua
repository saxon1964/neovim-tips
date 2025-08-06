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
  local desc_lookup = {}

  for _, tip in ipairs(entries) do
    local line = string.format("%s [%s] (%s)", tip.title, table.concat(tip.tags, ", "), tip.category)
    table.insert(items, line)
    desc_lookup[line] = tip.description
  end

  table.sort(items)

  fzf_lua.fzf_exec(items, {
    prompt = "Neovim Tips> ",
    previewer = "glow",
    preview = function(item)
      local tip_md = desc_lookup[item] or "No description"
      local tmp = vim.fn.tempname() .. ".md"
      local f = io.open(tmp, "w")
      if f then
        f:write(tip_md)
        f:close()
        return string.format("sh -c 'glow -s dark %s; rm -f %s'", tmp, tmp)
      else
        return "echo 'Failed to render preview'"
      end
    end,
  })
end

return M

