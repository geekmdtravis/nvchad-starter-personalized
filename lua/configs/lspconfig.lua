require("mason")
require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local mason_lspconfig = require "mason-lspconfig"

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "pyright",
  "eslint",
}

mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})


for _, server in ipairs(servers) do
  lspconfig[server].setup {}
end

lspconfig.pyright.setup {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}

