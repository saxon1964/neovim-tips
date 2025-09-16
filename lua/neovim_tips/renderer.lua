local M = {}

local renderer = nil
local renderer_name = nil

local ok, renderer_markdown = pcall(require, "render-markdown")

if ok then
  renderer = renderer_markdown
  renderer_name = "render-markdown"
end

---Renders markdown in the given buffer using render-markdown plugin
---@param bufnr integer Buffer number
local function render_markdown(bufnr)
  if renderer ~= nil then
    vim.api.nvim_buf_call(bufnr, function() renderer.enable() end)
  end
end

---Checks if markdown renderer is available
function M.renderer_available()
  return renderer ~= nil
end

---Main entry point: Tries to render markdown for the given buffer
---@parm bufnr integer Buffer number
function M.render(bufnr)
  if M.renderer_available() then
    M.render_buffer(bufnr)
  end
end

---Renders the markdown in the given buffer using one of supported renderers
---@param bufnr integer Buffer number
function M.render_buffer(bufnr)
  if renderer_name == "render-markdown" then
    render_markdown(bufnr)
  end
end

return M
