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
				diagnostics = "nvim_lsp",
				separator_style = "slope",
			},
		})

		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "<leader>w", close_buffer)
	end,
}
