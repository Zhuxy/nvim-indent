---------------------------------------------------------
-- main function implementation here
---------------------------------------------------------

---@class NvimIndent
local M = {}


local is_blank_line = function(line) return string.match(vim.fn.getline(line), '^%s*$') end

local function select_lines(select_top, select_bottom)
    -- move cursor to select_top
    vim.api.nvim_win_set_cursor(0, {select_top, 1})
    -- enter virual mode
    vim.cmd('normal! V')
    -- feed '+' (select_bottom - select_top) times
    for _ = 1, select_bottom - select_top do
      vim.cmd('+')
    end
end

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

M.select_under_title = function(include_title)
  -- find nearest markdown title (line begin with some '#'s)
  local start_line = vim.fn.line('.')

  -- get the heading '#'s of this line, maybe many 
  local regex = '^(#+)%s+.*$'
  local line_str = vim.fn.getline(start_line)
  local heading = string.match(line_str, regex)

  local select_top
  local select_bottom

  if not heading then
    -- look upperwards
    local prev_line = start_line - 1
    while prev_line > 0 do
      line_str = vim.fn.getline(prev_line)
      heading = string.match(line_str, regex)
      if heading then
        if include_title then
          select_top = prev_line
        else
          select_top = prev_line + 1
        end
        break
      end
      prev_line = prev_line - 1
    end

    if not heading then
      return
    end

    -- then look downwards
    local next_line = start_line + 1
    local last_line = vim.fn.line('$')
    local next_heading
    while next_line <= last_line do
      line_str = vim.fn.getline(next_line)
      next_heading = string.match(line_str, regex)
      if next_heading and (heading == next_heading or #heading > #next_heading) then
        select_bottom = next_line - 1
        break
      end
      next_line = next_line + 1
    end

    if not next_heading then
      select_bottom = last_line
    end

    while is_blank_line(select_bottom) do
      select_bottom = select_bottom - 1
    end

    select_lines(select_top, select_bottom)
  end


end

return M
