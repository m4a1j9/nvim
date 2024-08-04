--[=[
!DEPRECATED!
install vscode chrome debug
```
git clone https://github.com/Microsoft/vscode-chrome-debug ~/.DAP/vscode-chrome-debug
cd ~/.DAP/vscode-chrome-debug
npm install
npm run build
```
run chrome with argument `--remote-debugging-port=9222`
```
chrome --remote-debugging-port=9222
```

!DEPRECATED!
install vscode node debug2
```
git clone https://github.com/microsoft/vscode-node-debug2.git ~/.DAP/vscode-node-debug2
cd ~/.DAP/vscode-node-debug2
npm install
NODE_OPTIONS=--no-experimental-fetch npm run build
```
and run any node using flag `--inspect` or `--inspect-brk`, you can also debug deno using the same flag

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

local ok = require("plugins.utils.check_requires").check({
  "dap",
  "dap-vscode-js",
})
if not ok then
  return
end

local dap = require("dap")
local dap_utils = require("dap.utils")
local dap_vscode_js = require("dap-vscode-js")

-- !DEPRECATED!
-- dap.adapters.chrome = {
--   type = "executable",
--   command = "node",
--   args = { os.getenv("HOME") .. "/.DAP/vscode-chrome-debug/out/src/chromeDebug.js" },
-- }

-- !DEPRECATED!
-- dap.adapters.node2 = {
--   type = "executable",
--   command = "node",
--   args = { os.getenv("HOME") .. "/.DAP/vscode-node-debug2/out/src/nodeDebug.js" },
-- }

dap_vscode_js.setup({
  node_path = "node",
  debugger_path = os.getenv("HOME") .. "/pr/vscode-js-debug",
  adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
})

local exts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  -- using pwa-chrome
}

for i, ext in ipairs(exts) do
  dap.configurations[ext] = {
    {
      -- yandex-browser-stable --remote-debugging-port=9222
      type = 'pwa-chrome',
      name = 'Attach to Chrome (9222)',
      request = 'attach',
      port = 9222,
      webRoot = "${workspaceFolder}/src",
      -- sourceMaps = true,
      -- protocol = 'inspector',
      -- resolveSourceMapLocations = {
      --   "${workspaceFolder}/**",
      --   "!**/node_modules/**" },
      -- -- path to src in vite based projects (and most other projects as well)
      -- cwd = "${workspaceFolder}/src",
      -- -- we don't want to debug code inside node_modules, so skip it!
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
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
  }
end
