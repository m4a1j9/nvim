local M = {}

local find_closest_file = require("plugins.utils.find-file").find_closest_file -- Load your find function

local tsconfig_path = find_closest_file({ "tsconfig.app.json", "tsconfig.json" }) -- Find the closest config

if tsconfig_path then
	print(tsconfig_path)
	M.plugin = {
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup({
				-- flags = {
				--   watch = true,
				--   project = tsconfig_path,
				-- },
        flags = "--build --watch",
			})
		end,
	}
else
	M.plugin = {}
end

return M
