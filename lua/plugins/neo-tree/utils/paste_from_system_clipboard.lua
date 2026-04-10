return function(state)
  local source_path = vim.trim(vim.fn.getreg("+"))
  if source_path == "" then
    vim.notify("System clipboard is empty", vim.log.levels.WARN)
    return
  end

  if vim.fn.filereadable(source_path) == 0 and vim.fn.isdirectory(source_path) == 0 then
    vim.notify("Clipboard path does not exist: " .. source_path, vim.log.levels.ERROR)
    return
  end

  local node = state.tree:get_node()
  if not node or not node.path then
    return
  end

  local target_dir = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
  local cp_args = vim.fn.isdirectory(source_path) == 1 and { "cp", "-R", source_path, target_dir }
      or { "cp", source_path, target_dir }
  local result = vim.system(cp_args, { text = true }):wait()

  if result.code ~= 0 then
    local err = vim.trim(result.stderr or "")
    vim.notify("Paste failed: " .. (err ~= "" and err or "cp returned non-zero exit code"), vim.log.levels.ERROR)
    return
  end

  require("neo-tree.sources.manager").refresh(state.name)
  vim.notify("Pasted into: " .. target_dir, vim.log.levels.INFO)
end
