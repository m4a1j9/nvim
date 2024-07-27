local function toggle_neo_tree()
  local manager = require("neo-tree.sources.manager")
  local renderer = require("neo-tree.ui.renderer")

  local state = manager.get_state("filesystem")
  local window_exists = renderer.window_exists(state)

  -- TODO
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function ()
      require("neo-tree").setup({
        window = {
          width = 30
        }
      })
    end,
    -- Открыть-закрыть файловый менеджер
    vim.keymap.set('n', '<A-1>', ':Neotree filesystem reveal left toggle=true<CR>', {})

}
