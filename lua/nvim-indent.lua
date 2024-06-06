---------------------------------------------------------
-- plugin's interface
---------------------------------------------------------

-- load main module file
local module = require("nvim-indent.module")

---@class Config
---@field indent_object_char string which char used after select INDENT operator to form a text-object
---@field title_object_char string which char used after select under TITLE operator to form a text-object
---@field include_last boolean whether to include the last line when "around" some indented lines
local config = {
  indent_object_char = 'i',
  title_object_char = 't',
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
    vim.api.nvim_set_keymap(mode, 'i' .. M.config.indent_object_char, ':<c-u>lua require("nvim-indent").select_indent(false, false)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'a' .. M.config.indent_object_char, ':<c-u>lua require("nvim-indent").select_indent(true, false)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'i' .. string.upper(M.config.indent_object_char), ':<c-u>lua require("nvim-indent").select_indent(false, true)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'a' .. string.upper(M.config.indent_object_char), ':<c-u>lua require("nvim-indent").select_indent(true, true)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'i' .. M.config.title_object_char, ':<c-u>lua require("nvim-indent").select_under_title(false)<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap(mode, 'a' .. M.config.title_object_char, ':<c-u>lua require("nvim-indent").select_under_title(true)<cr>', { noremap = true, silent = true })
  end
end

-- this function can be called by require("nvim-indent")
M.select_indent = function(around, include_last)
  return module.select_indent(around, include_last)
end

M.select_under_title = function(include_title)
  return module.select_under_title(include_title)
end

return M
