---------------------------------------------------------
-- plugin's interface
---------------------------------------------------------

-- load main module file
local module = require("nvim-indent.module")

---@class Config
---@field text_object_char string which char used after operator to form a text-object
---@field include_last boolean whether to include the last line when "around" some indented lines
local config = {
  text_object_char = 'i',
  include_last = true,
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})

  for _,mode in ipairs({ 'x', 'o' }) do
    vim.api.nvim_set_keymap(mode, 'i' .. M.config.text_object_char, ':<c-u>lua require("nvim-indent").select_indent(false, false)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'a' .. M.config.text_object_char, ':<c-u>lua require("nvim-indent").select_indent(true, false)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'i' .. string.upper(M.config.text_object_char), ':<c-u>lua require("nvim-indent").select_indent(false, true)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'a' .. string.upper(M.config.text_object_char), ':<c-u>lua require("nvim-indent").select_indent(true, true)<cr>', { noremap = true, silent = true })
  end
end

-- this function can be called by require("nvim-indent")
M.select_indent = function(around, include_last)
  return module.select_indent(around, include_last)
end

return M
