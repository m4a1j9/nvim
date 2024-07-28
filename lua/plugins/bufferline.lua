-- Отображение вкладок
return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",
        themable = true,
        indicator = {
          style = "underline",
        },
        -- Отображение статуса ошибок в табах
        diagnostics = 'nvim_lsp',
        separator_style = 'slope',
      },
    })

    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
  end,
}
