-- Delete unused keymaps --

-- Toggle comment
vim.keymap.del("n", "gcc")

-- Set new maps --

local opts = {
	noremap = true,
	silent = true,
}

--===== native =====--

-- Move thorugh windows --

opts.desc = "Go to the left window"
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>", opts)

opts.desc = "Go to the bottom window"
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>", opts)

opts.desc = "Go to the top window"
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>", opts)

opts.desc = "Go to the right window"
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>", opts)

-- shared keys --

vim.keymap.set("n", ";", ":")
vim.keymap.set("i", "jj", "<ESC>")

opts.desc = "Get relative file path"
vim.keymap.set(
	"n",
	"cp",
	":let @a = substitute(expand('%:p'), '.*\\/src', 'src', '') .. ':' .. line('.') | call system('xclip -selection clipboard', @a)<CR>",
	opts
)

opts.desc = "Edit macro"
vim.keymap.set("n", "<leader>em", function()
	local register = vim.fn.input("Input the register to edit: ")
	if register == "" then
		return
	end
	-- open a new buffer
	vim.cmd("new")
	-- put a entered register
	vim.cmd("put " .. register)
	-- sen a simple action after that
	vim.api.nvim_feedkeys("A", "n", false)
end, opts)

opts.desc = "Save macro"
vim.keymap.set("n", "<leader>sm", function()
	local register = vim.fn.input("Input the register to save: ")
	if register == "" then
		return
	end
	vim.api.nvim_feedkeys('"' .. register .. "yy", "n", false)
	vim.cmd("bd!")
end, opts)

-- Search highlighted --

opts.desc = "Search for highlighted text in current buffer"
vim.keymap.set("v", "/s", 'y/<C-R>"<CR>', opts)

opts.desc = "Search for exact highlighted word"
vim.keymap.set("v", "/w", 'y/\\<<C-R>"\\><CR>', opts)

opts.desc = "Show off search highlight"
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", opts)

-- mass replace shortcut

vim.keymap.set("v", "/rr", 'y:%s/<C-R>"//g<Left><Left>', { noremap = true, desc = "Mass replace" })
vim.keymap.set("v", "/rc", 'y:%s/<C-R>"//gc<Left><Left><Left>', { noremap = true, desc = "Mass replace with asking" })
vim.keymap.set(
	"v",
	"/ri",
	'y:%s/<C-R>"//gi<Left><Left><Left>',
	{ noremap = true, desc = "Mass replace with case sentetive" }
)
vim.keymap.set(
	"v",
	"/ra",
	'y:%s/<C-R>"//gci<Left><Left><Left><Left>',
	{ noremap = true, desc = "Mass replace with case and asking" }
)
-- g => global search
-- c => Ask for confirmation first
-- i => Case insensitive

--===== native end =====--

--===== plugins =====--

-- DAP --

opts.desc = "DAP continue"
vim.keymap.set("n", "<F5>", require("dap").continue, opts)

opts.desc = "DAP step over"
vim.keymap.set("n", "<F9>", require("dap").step_over, opts)

opts.desc = "DAP step into"
vim.keymap.set("n", "<F10>", require("dap").step_into, opts)

opts.desc = "DAP step out"
vim.keymap.set("n", "<F11>", require("dap").step_out, opts)

opts.desc = "DAP toggle breakpoint"
vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint, opts)

opts.desc = "DAP set condition breakpoint"
vim.keymap.set("n", "<leader>B", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)

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

-- Bufferline --

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

-- Telescope in specific dirrectory --

opts.desc = "Search in specific dir"
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", opts)

opts.desc = "Find files in specific dir"
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", opts)

-- Telescope --

local builtin = require("telescope.builtin")

opts.desc = "Find files"
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)

opts.desc = "Search"
vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)

opts.desc = "Search exact word"
vim.keymap.set("n", "<leader>fw", 'yiw:Telescope live_grep<CR>\\<<C-R>"\\><Left><Left>', opts)

opts.desc = "Find buffer"
vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)

opts.desc = "Find tags"
vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

opts.desc = "Recent files"
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, opts)

opts.desc = "Global search highlighted"
vim.keymap.set("v", "/fh", 'y:Telescope live_grep<CR><C-R>"', opts)

-- Neogit --

opts.desc = "Open Neogit"
vim.keymap.set("n", "<leader>no", ":Neogit<CR>", opts)

-- Flash --

-- Enter is now set for Flash search, but we still need for common Enter key for select something
vim.keymap.set("n", "<A-CR>", "<CR>")

-- Gitsigns --

local gitsigns = require("gitsigns")

opts.desc = "Next hunk"
vim.keymap.set("n", "]c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "]c", bang = true })
	else
		gitsigns.nav_hunk("next")
	end
end)

opts.desc = "Prev hunk"
vim.keymap.set("n", "[c", function()
	if vim.wo.diff then
		vim.cmd.normal({ "[c", bang = true })
	else
		gitsigns.nav_hunk("prev")
	end
end)

opts.desc = "Stage hunk"
vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)

opts.desc = "Reset hunk"
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, opts)

opts.desc = "Stage hunk v"
vim.keymap.set("v", "<leader>hs", function()
	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, opts)

opts.desc = "Reset hunk v"
vim.keymap.set("v", "<leader>hr", function()
	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, opts)

opts.desc = "Stage buffer"
vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts)

opts.desc = "Undo stage hunk"
vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)

opts.desc = "Reset buffer"
vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, opts)

opts.desc = "Preview hunk"
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)

opts.desc = "Blame line"
vim.keymap.set("n", "<leader>hb", function()
	gitsigns.blame_line({ full = true })
end, opts)

opts.desc = "Toggle current line blame"
vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)

opts.desc = "Diffthis"
vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, opts)

opts.desc = "Diffthis ~"
vim.keymap.set("n", "<leader>hD", function()
	gitsigns.diffthis("~")
end, opts)

opts.desc = "toggle deleted"
vim.keymap.set("n", "<leader>td", gitsigns.toggle_deleted, opts)

opts.desc = "select hunk"
vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)

-- Treesitter --

opts.desc = "Neotree reveal"
vim.keymap.set("n", "<A-1>", ":Neotree filesystem reveal left<CR>", opts)

opts.desc = "Neotree toggle"
vim.keymap.set("n", "<A-2>", ":Neotree filesystem toggle left<CR>", opts)

-- TSTools --

opts.desc = "Add missing imports"
vim.keymap.set("n", "<leader>ia", ":TSToolsAddMissingImports<CR>", opts)

opts.desc = "Remove unused imports"
vim.keymap.set("n", "<leader>ir", ":TSToolsRemoveUnusedImports<CR>", opts)
--===== plugins end =====--
