local M = {}

local tips = require("neovim_tips.tips")
local fzf_lua = require("fzf-lua")
local builtin = require("fzf-lua.previewer.builtin")

-- Inherit from the "buffer_or_file" previewer
local MarkdownPreviewer = builtin.buffer_or_file:extend()

-- Track instances for cleanup
local instances = {}

function MarkdownPreviewer:new(o, opts, fzf_win)
  MarkdownPreviewer.super.new(self, o, opts, fzf_win)
  setmetatable(self, MarkdownPreviewer)
  -- Initialize instance variable for temp file
  self.tmp_file = nil
  -- Track instance for cleanup
  table.insert(instances, self)
  return self
end

-- Instance method to remove temporary file
function MarkdownPreviewer:remove_tmp_file()
  if self.tmp_file ~= nil then
    local ok, err = pcall(os.remove, self.tmp_file)
    if not ok then
      vim.notify("Failed to remove temporary file " .. self.tmp_file .. ": " .. err, vim.log.levels.ERROR)
    end
    self.tmp_file = nil
  end
end

-- Create temporary file with markdown content
function MarkdownPreviewer:parse_entry(title)
  self:remove_tmp_file()
  self.tmp_file = os.tmpname() .. ".md"
  local file = io.open(self.tmp_file, "w")
  if file then
    local content = tips.get_description(title)
    file:write(content)
    file:close()
  else
    vim.notify("Failed to create temporary file " .. self.tmp_file, vim.log.levels.ERROR)
  end
  return {
    path = self.tmp_file,
    line = 1,
    col = 1,
  }
end

-- Disable line numbering and enable word wrap
function MarkdownPreviewer:gen_winopts()
  local new_winopts = {
    wrap    = true,
    number  = false
  }
  return vim.tbl_extend("force", self.winopts, new_winopts)
end

-- Clean up temp files on vim exit (fallback safety)
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    for _, instance in pairs(instances) do
      if instance.remove_tmp_file then
        instance:remove_tmp_file()
      end
    end
  end
})

-- Show fuzzy finder
function M.show_fzf()
  local titles = tips.get_titles()
  if #titles == 0 then
    vim.notify("No tips available", vim.log.levels.INFO)
    return
  end
  fzf_lua.fzf_exec(titles, {
    previewer = MarkdownPreviewer,
    prompt = "Search Tips> ",
  })
end

return M

