---------------------------------------------------------
-- main function implementation here
---------------------------------------------------------

---@class NvimIndent
local M = {}


local is_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end

M.select_indent = function(around, include_last)
  local start_indent = vim.fn.indent(vim.fn.line('.'))

  if is_blank_line(vim.fn.line('.')) then
    return
  end

  if vim.v.count > 0 then
    start_indent = start_indent - vim.o.shiftwidth * (vim.v.count - 1)
    if start_indent < 0 then
      start_indent = 0
    end
  end

  local prev_line = vim.fn.line('.') - 1
  while prev_line > 0 and (is_blank_line(prev_line) or vim.fn.indent(prev_line) >= start_indent) do
    vim.cmd('-')
    prev_line = vim.fn.line('.') - 1
  end
  if around then
    vim.cmd('-')
  end

  -- remenber the uppermost line's indent, the downmost line's indent should not be less than it
  local uppermost_indent = vim.fn.indent(vim.fn.line('.'))

  vim.cmd('normal! V')

  local next_line = vim.fn.line('.') + 1
  local last_line = vim.fn.line('$')
  while next_line <= last_line and (is_blank_line(next_line) or vim.fn.indent(next_line) >= start_indent) do
    vim.cmd('+')
    next_line = vim.fn.line('.') + 1
  end

  if around and include_last and vim.fn.indent(next_line) >= uppermost_indent then
    vim.cmd('+')
  end

  while not include_last and is_blank_line('.') do
    vim.cmd('-')
  end
end

return M
