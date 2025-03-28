local M = {}

M.plugin = {
  "kylechui/nvim-surround",
  version = false, -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({})
  end,
}

return M
