local M = {}

M.find_closest_file = function(match_strings, start_dir, depth)
  depth = depth or 0
  local max_depth = 10
  start_dir = start_dir or vim.fn.expand("%:p:h") or vim.fn.getcwd()

  if depth > max_depth then
    return nil
  end

  for _, match_string in ipairs(match_strings) do
    local command = string.format("fd '%s' '%s' --max-depth 1", match_string, start_dir)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()

    local files = {}
    for line in result:gmatch("[^\r\n]+") do
      table.insert(files, line)
    end

    if #files > 0 then
      return files[1]
    end
  end

  local parent_dir = vim.fn.fnamemodify(start_dir, ":h")
  if parent_dir == start_dir then
    return nil
  else
    return M.find_closest_file(match_strings, parent_dir, depth + 1)
  end
end

return M
