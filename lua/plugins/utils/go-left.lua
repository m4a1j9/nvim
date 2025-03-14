local M = {}

---@param times number Times to repeat Left
---@return string
M.goLeft = function(times)
  return string.rep("<Left>", times)
end

return M
