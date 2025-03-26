-- Отображение вкладок
local M = {}

M.plugin = {
	"akinsho/bufferline.nvim",
	version = false,
	dependencies = "nvim-tree/nvim-web-devicons",

	config = function()
    M.setup()
  end,
}

M.setup = function()
  require("bufferline").setup({
    options = {
      mode = "buffers",
      themable = true,
      indicator = {
        style = "underline",
      },
      -- Отображение статуса ошибок в табах
      diagnostics = "nvim_lsp",
      separator_style = { "", "" },
    },
  })
end


return M
