-- Клонирование пакета, если он не найден
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
  require("plugins.DAP.DAP").plugin,
  require("plugins.theme").plugin,
  require("plugins.auto-session").plugin,
  require("plugins.bufferline").plugin,
  require("plugins.colorizer").plugin,
  require("plugins.dashboard").plugin,
  require("plugins.lazydev").plugin,
  require("plugins.lualine").plugin,
  require("plugins.neo-tree").plugin,
  require("plugins.nmiv-cmp").plugin,
  require("plugins.none-ls").plugin,
  require("plugins.telescope").plugin,
  require("plugins.treesitter").plugin,
  require("plugins.which-key").plugin,
  require("plugins.lsp.mason").plugin,
  require("plugins.lsp.lspconfig").plugin,
  require("plugins.lsp.file-operations").plugin,
  require("plugins.lsp.typescript-tools").plugin,
  require("plugins.lsp.tsc").plugin,
  require("plugins.git.neogit").plugin,
  require("plugins.git.gitsigns").plugin,
  require("plugins.vim-indentwise").plugin,
  require("plugins.vim-visual-multi").plugin,
  require("plugins.flash").plugin,
  require("plugins.nvim-surround").plugin,
  require("plugins.avante").plugin,
  require("plugins.nvim-spectre").plugin,

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})
