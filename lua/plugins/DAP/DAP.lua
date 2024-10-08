local M = {}

M.plugin = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    -- build debugger from source
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
    },
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    M.setup()
  end
}

M.setup = function()
  -- # Sign
	vim.fn.sign_define("DapBreakpoint", { text = "b", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "B", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "lp", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped", { text = "S", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "", linehl = "", numhl = "" })

  require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    -- adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
  })

  require("nvim-dap-virtual-text").setup()
  -- Information for setting up configurations:  https://code.visualstudio.com/docs/nodejs/browser-debugging

  for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
    require("dap").configurations[language] = {
      -- attach to a node process that has been started with
      -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
      -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
      {
        -- use nvim-dap-vscode-js's pwa-node debug adapter
        type = "pwa-node",
        -- attach to an already running node process with --inspect flag
        -- default port: 9222
        request = "attach",
        -- allows us to pick the process using a picker
        processId = require 'dap.utils'.pick_process,
        -- name of the debug action you have to select for this config
        name = "Attach debugger to existing `node --inspect` process",
        -- for compiled languages like TypeScript or Svelte.js
        sourceMaps = true,
        -- resolve source maps in nested locations while ignoring node_modules
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**" },
        -- path to src in vite based projects (and most other projects as well)
        cwd = "${workspaceFolder}/src",
        -- we don't want to debug code inside node_modules, so skip it!
        skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
      },
      {
        -- yandex-browser-stable --remote-debugging-port=9222
        type = 'pwa-chrome',
        name = 'Attach to Chrome (9222)',
        request = 'attach',
        port = 9222,
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}/src",
        sourceMaps = true,
        protocol = 'inspector',
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**" },
        -- -- path to src in vite based projects (and most other projects as well)
        cwd = "${workspaceFolder}/src",
        -- -- we don't want to debug code inside node_modules, so skip it!
        skipFiles = { "${workspaceFolder}/node_modules/**/*" },
      },
      {
        type = "pwa-chrome",
        name = "Launch Yandex to debug client",
        request = "launch",
        port = 9222,
        url = "http://localhost:3000",
        sourceMaps = true,
        protocol = "inspector",
        webRoot = "${workspaceFolder}/src",
        -- skip files from vite's hmr
        skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
        runtimeExecutable = "/usr/bin/yandex-browser-stable",
      },
      -- only if language is javascript, offer this debug action
      language == "javascript" and {
        -- use nvim-dap-vscode-js's pwa-node debug adapter
        type = "pwa-node",
        -- launch a new process to attach the debugger to
        request = "launch",
        -- name of the debug action you have to select for this config
        name = "Launch file in new node process",
        -- launch current file
        program = "${file}",
        cwd = "${workspaceFolder}",
      } or nil,
    }
  end

  require("dapui").setup()

  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
  end
  dap.listeners.before.event_terminated["dapui_config"] = dapui.close
  dap.listeners.before.event_exited["dapui_config"] = dapui.close
end

return M
