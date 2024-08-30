-- Delete unused keymaps --

-- Toggle comment
vim.keymap.del("n", "gcc")

-- Set new maps --

local opts = {
	noremap = true,
	silent = true,
}

-- Move thorugh windows --

opts.desc = "Go to the left window"
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>", opts)

opts.desc = "Go to the bottom window"
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>", opts)

opts.desc = "Go to the top window"
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>", opts)

opts.desc = "Go to the right window"
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>", opts)

-- dap --

opts.desc = "DAP continue"
vim.keymap.set("n", "<F5>", require("dap").continue, opts)

opts.desc = "DAP step over"
vim.keymap.set("n", "<F9>", require("dap").step_over, opts)

opts.desc = "DAP step into"
vim.keymap.set("n", "<F10>", require("dap").step_into, opts)

opts.desc = "DAP step out"
vim.keymap.set("n", "<F11>", require("dap").step_out, opts)

opts.desc = "DAP toggle breakpoint"
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)

opts.desc = "DAP set condition breakpoint"
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

opts.desc = "DAP set logpoint"
vim.keymap.set("n", "<leader>lm", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
-- vim.keymap.set(
--   "n",
--   "<leader>dS",
--   function()
--     require("dap").disconnect()
--   end,
--   opts
-- )

opts.desc = "DAP toggle ui"
vim.keymap.set("n", "<leader>ui", require("dapui").toggle)

-- bufferline --

local close_buffer = function()
	vim.cmd("bd")
	vim.cmd("bprevious")
end

opts.desc = "Next buffer"
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)

opts.desc = "Prev buffer"
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

opts.desc = "Close buffer"
vim.keymap.set("n", "<leader>wq", close_buffer, opts)

opts.desc = "Go to 1 buffer"
vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)

opts.desc = "Go to 2 buffer"
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)

opts.desc = "Go to 3 buffer"
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)

opts.desc = "Go to 4 buffer"
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)

opts.desc = "Go to 5 buffer"
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)

opts.desc = "Close others buffers"
vim.keymap.set("n", "<leader>ww", ":BufferLineCloseOthers<CR>", opts)

-- shared keys
vim.keymap.set("n", ";", ":")
vim.keymap.set("i", "jj", "<ESC>")

-- Get relative file path

opts.desc = "Get relative file path"
vim.keymap.set(
	"n",
	"cp",
	":let @a = substitute(expand('%:p'), '.*\\/src', 'src', '') .. ':' .. line('.') | call system('xclip -selection clipboard', @a)<CR>",
	opts
)

-- Search highlighted

opts.desc = "Search for highlighted text in current buffer"
vim.keymap.set("v", "/s", 'y/<C-R>"<CR>', opts)

opts.desc = "Search for exact highlighted word"
vim.keymap.set("v", "/w", 'y/\\<<C-R>"\\><CR>', opts)

-- Show off search highlight

opts.desc = "Show off search highlight"
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", opts)

-- Telescope in specific dirrectory

opts.desc = "Search in specific dir"
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", opts)

opts.desc = "Find files in specific dir"
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", opts)

-- Telescope

local builtin = require("telescope.builtin")

opts.desc = "Find files"
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)

opts.desc = "Search"
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)

opts.desc = "Find buffer"
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)

opts.desc = "Find tags"
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

-- Neogit
opts.desc = "Open Neogit"
vim.keymap.set("n", "<leader>no", ":Neogit<CR>", opts)
