local M = {}

M.plugin = {
	"folke/tokyonight.nvim",
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		M.setup()
	end,
}

M.setup = function()
	local bg_highlight = "#143652"
	local bg_search = "#0A64AC"
	local bg_visual = "#275378"
	local fg = "#CBE0F0"
	local fg_dark = "#B4D0E9"
	local fg_gutter = "#627E97"
	local border = "#547998"

	require("tokyonight").setup({
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		style = "storm",
		on_colors = function(colors)
			colors.bg_highlight = bg_highlight
			colors.bg_search = bg_search
			colors.bg_visual = bg_visual
			colors.border = border
			colors.fg = fg
			colors.fg_dark = fg_dark
			colors.fg_float = fg
			colors.fg_gutter = fg_gutter
			colors.fg_sidebar = fg_dark
		end,
	})
	-- load the colorscheme here
	vim.cmd([[colorscheme tokyonight]])
end

if not pcall(debug.getlocal, 4, 1) then
	M.setup()
end

return M
