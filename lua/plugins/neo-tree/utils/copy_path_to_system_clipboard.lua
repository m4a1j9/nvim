return function(state)
  local node = state.tree:get_node()
  if not node or not node.path then
    return
  end

  vim.fn.setreg("+", node.path)
  vim.notify("Copied to system clipboard: " .. node.path, vim.log.levels.INFO)
end
