local tips = require("neovim_tips.tips")
local builtin = require("fzf-lua.previewer.builtin")

-- Inherit from the "buffer_or_file" previewer
local MdPreviewer = builtin.buffer_or_file:extend()

local tmp_file = nil

local function remove_tmp_file()
  if tmp_file ~= nil then
    local fd = io.open(tmp_file, "r")
    if fd then
      fd:close()
      os.remove(tmp_file)
    end
    tmp_file = nil
  end
end

function MdPreviewer:new(o, opts, fzf_win)
  MdPreviewer.super.new(self, o, opts, fzf_win)
  setmetatable(self, MdPreviewer)
  return self
end

-- Create temporary file with markdown content
function MdPreviewer:parse_entry(item)
  remove_tmp_file()
  tmp_file = os.tmpname() .. ".md"
  local file = io.open(tmp_file, "w")
  if file then
    local content = tips.get_description(item)
    file:write(content)
    file:close()
  else
    vim.notify("Failed to create temporary file " .. tmp_file, vim.log.levels.ERROR)
  end
  return {
    path = tmp_file,
    line = 1,
    col = 1,
  }
end

-- Disable line numbering and enable word wrap
function MdPreviewer:gen_winopts()
  local new_winopts = {
    wrap    = true,
    number  = false
  }
  return vim.tbl_extend("force", self.winopts, new_winopts)
end

vim.api.nvim_create_autocmd("VimLeave", {
  callback = remove_tmp_file
})

return MdPreviewer

