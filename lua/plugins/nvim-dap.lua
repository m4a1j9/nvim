-- Дебаггер и интерфейс для него

--[=[
debugging ts project using ts-node
install ts-node on local project or global
```
npm i -D ts-node
```
you can start debug with this commnad and attach or just launch
```
node -r ts-node/register --inspect <ts file>
```

install vscode js debug
```
git clone https://github.com/microsoft/vscode-js-debug ~/.DAP/vscode-js-debug --depth=1
cd ~/.DAP/vscode-js-debug
npm install --legacy-peer-deps
npm run compile
```
--]=]

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap = require("dap")
			local dap_utils = require("dap.utils")
			local dap_ext_vscode = require("dap.ext.vscode")

			-- Set keymaps to control the debugger
			vim.keymap.set("n", "<F5>", require("dap").continue)
			vim.keymap.set("n", "<F9>", require("dap").step_over)
			vim.keymap.set("n", "<F10>", require("dap").step_into)
			vim.keymap.set("n", "<F11>", require("dap").step_out)
			vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
			vim.keymap.set("n", "<leader>B", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end)

			-- Adapter config
			-- Install vscode-js-debug https://github.com/microsoft/vscode-js-debug/releases
			-- extract it via tar xvzf path/to/vscode-js-debug.tar.gz
			-- dap.adapters["pwa-node"] = {
			-- 	type = "server",
			-- 	host = "localhost",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = "node",
			-- 		-- 💀 Make sure to update this path to point to your installation
			-- 		-- TODO Некорректно определяется путь к файлу через ~
			-- 		args = { "../../pr/js-debug/src/dapDebugServer.js", "${port}" },
			-- 	},
			-- }

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

			local exts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			}

			for i, ext in ipairs(exts) do
				dap.configurations[ext] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with ts-node)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "--loader", "ts-node/esm" },
						runtimeExecutable = "node",
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with jest)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
						runtimeExecutable = "node",
						args = { "${file}", "--coverage", "false" },
						rootPath = "${workspaceFolder}",
						sourceMaps = true,
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with vitest)",
						cwd = vim.fn.getcwd(),
						program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
						args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
						autoAttachChildProcesses = true,
						smartStep = true,
						console = "integratedTerminal",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						smartStep = true,
						console = "integratedTerminal",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach Program (pwa-chrome, select port)",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						port = function()
							return vim.fn.input("Select port: ", 9222)
						end,
						webRoot = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach Program (pwa-node, select pid)",
						cwd = vim.fn.getcwd(),
						processId = dap_utils.pick_process,
						skipFiles = { "<node_internals>/**" },
					},
				}
			end

			require("dap-vscode-js").setup({
				node_path = "node",
				debugger_path = os.getenv("HOME") .. "/pr/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup()

			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end

			vim.keymap.set("n", "<leader>ui", require("dapui").toggle)
		end,
	},
}
