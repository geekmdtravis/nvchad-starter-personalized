local lspconfig = require "lspconfig"
local base = require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "pyright",
  "eslint",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

lspconfig.pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}

