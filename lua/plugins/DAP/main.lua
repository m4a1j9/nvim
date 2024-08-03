-- # DAP

local M = {}

M.plugin = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"nvim-neotest/nvim-nio",
			},
		},
		"nvim-treesitter/nvim-treesitter",
		"theHamsta/nvim-dap-virtual-text",
		"mxsdev/nvim-dap-vscode-js",
	},
	event = "VeryLazy",
	config = function()
		M.setup()
	end,
}

M.setup = function()
	local ok = require("plugins.utils.check_requires").check({
		"dap",
		"dapui",
		"nvim-dap-virtual-text",
	})
	if not ok then
		return
	end

	local dap = require("dap")
	local dapui = require("dapui")
	local dap_ext_vscode = require("dap.ext.vscode")
	local dap_virtual_text = require("nvim-dap-virtual-text")

	-- # Sign
	vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "🟧", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "🟩", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "🈁", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "⬜", texthl = "", linehl = "", numhl = "" })

	-- # DAP Virtual Text
	dap_virtual_text.setup({
		enabled = true,
		enabled_commands = true,
		highlight_changed_variables = true,
		highlight_new_as_changed = false,
		show_stop_reason = true,
		commented = false,
		only_first_definition = true,
		all_references = false,
		filter_references_pattern = "<module",
		virt_text_pos = "eol",
		all_frames = false,
		virt_lines = false,
		virt_text_win_col = nil,
	})

	-- # DAP UI
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		expand_lines = vim.fn.has("nvim-0.7"),
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "right",
			},
			{
				elements = {
					{ id = "repl", size = 0.5 },
					{ id = "console", size = 0.5 },
				},
				size = 10,
				position = "bottom",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "rounded", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil,
		},
	})
	dap.listeners.after.event_initialized["dapui_config"] = function()
		vim.cmd("tabfirst|tabnext")
		dapui.open()
	end
	-- dap.listeners.before.event_terminated["dapui_config"] = function()
	--   dapui.close()
	-- end
	-- dap.listeners.before.event_exited["dapui_config"] = function()
	--   dapui.close()
	-- end

	-- # Keymap
	local opts = {
		noremap = true,
		silent = true,
	}

	vim.keymap.set("n", "<leader>di", dap.toggle_breakpoint, opts)
	vim.keymap.set("n", "<leader>di", dap.toggle_breakpoint, opts)
	vim.keymap.set(
		"n",
		"<leader>dI",
		':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
		opts
	)
	vim.keymap.set(
		"n",
		"<leader>dp",
		':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
		opts
	)
	vim.keymap.set("n", "<leader>ds", ':lua require("dap").continue()<CR>', opts)
	vim.keymap.set("n", "<leader>dl", ':lua require("dap").run_to_cursor()<CR>', opts)
	vim.keymap.set("n", "<leader>dS", ':lua require("dap").disconnect()<CR>', opts)
	vim.keymap.set("n", "<leader>dn", ':lua require("dap").step_over()<CR>', opts)
	vim.keymap.set("n", "<leader>dN", ':lua require("dap").step_into()<CR>', opts)
	vim.keymap.set("n", "<leader>do", ':lua require("dap").step_out()<CR>', opts)

	vim.keymap.set("n", "<leader>dww", ':lua require("dapui").toggle()<CR>', opts)
	vim.keymap.set("n", "<leader>dw[", ':lua require("dapui").toggle(1)<CR>', opts)
	vim.keymap.set("n", "<leader>dw]", ':lua require("dapui").toggle(2)<CR>', opts)

	-- # DAP Config
	require("plugins.DAP.languages.typescript")

	-- ## DAP `launch.json`
	dap_ext_vscode.load_launchjs(nil, {
		["pwa-node"] = {
			"javascript",
			"typescript",
		},
		["node"] = {
			"javascript",
			"typescript",
		},
	})
end

if not pcall(debug.getlocal, 4, 1) then
	M.setup()
end

return M
