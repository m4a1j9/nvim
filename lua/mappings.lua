-- Delete unused keymaps

-- Toggle comment
vim.keymap.del('n', 'gcc')

-- Set new maps

-- Move thorugh windows
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { desc = 'Go to the left window' })
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>', { desc = 'Go to the bottom window' })
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>', { desc = 'Go to the top window' })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { desc = 'Go to the right window' })


