local M = {}

M.plugin = {
  'dmmulroy/tsc.nvim',
  config = function ()
    require('tsc').setup({
      flags = {
        watch = true,
      },
    })
  end
}

return M

