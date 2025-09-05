local M = {}

---Enables markdown rendering for the given buffer number
---@parm bufnr integer Buffer number
function M.enable(bufnr)
  local ok, renderer = pcall(require, "render-markdown")
  if ok then
    vim.api.nvim_buf_call(bufnr, function()
      renderer.enable()
    end)
  else
    vim.notify("Markdown renderer not available", vim.log.levels.ERROR)
  end
end

return M

