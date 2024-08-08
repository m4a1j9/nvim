-- Delete unused keymaps --

-- Toggle comment
vim.keymap.del('n', 'gcc')

-- Set new maps --

local opts = {
  noremap = true,
  silent = true,
}

-- Move thorugh windows --

vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { desc = 'Go to the left window' })
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>', { desc = 'Go to the bottom window' })
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>', { desc = 'Go to the top window' })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { desc = 'Go to the right window' })

-- dap --

vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F9>", require("dap").step_over)
vim.keymap.set("n", "<F10>", require("dap").step_into)
vim.keymap.set("n", "<F11>", require("dap").step_out)
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
vim.keymap.set(
  "n",
  "<leader>B",
  function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end,
  {
    noremap = true,
    silent = true,
    desc = "Set condition breakpoint",
  }
)
vim.keymap.set(
  "n",
  "<leader>lm",
  function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end,
  {
    noremap = true,
    silent = true,
    desc = "Set logpoint",
  }
)
-- vim.keymap.set(
--   "n",
--   "<leader>dS",
--   function()
--     require("dap").disconnect()
--   end,
--   opts
-- )
vim.keymap.set("n", "<leader>ui", require("dapui").toggle)

-- bufferline --

local close_buffer = function()
	local bufferline = require("bufferline")
	local buf_number = vim.api.nvim_get_current_buf()

	local is_next_valid = vim.api.nvim_buf_is_valid(buf_number - 1)
	if is_next_valid then
		vim.cmd("bd")
		bufferline.move_to(buf_number - 1)
	end

	local is_prev_valid = vim.api.nvim_buf_is_valid(buf_number + 1)
	if is_prev_valid then
		vim.cmd("bd")
		bufferline.move_to(buf_number + 1)
	end
end

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>w", ':bw<CR>')
vim.keymap.set("n", "<leader>1", ':BufferLineGoToBuffer 1<CR>')
vim.keymap.set("n", "<leader>2", ':BufferLineGoToBuffer 2<CR>')
vim.keymap.set("n", "<leader>3", ':BufferLineGoToBuffer 3<CR>')
vim.keymap.set("n", "<leader>4", ':BufferLineGoToBuffer 4<CR>')
vim.keymap.set("n", "<leader>5", ':BufferLineGoToBuffer 5<CR>')

-- shared keys
vim.keymap.set('n', ';', ':')
vim.keymap.set('i', 'jj', '<ESC>')
