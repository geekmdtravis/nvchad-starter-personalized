-- Setup Mason first
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Additional tools to install (formatters, linters, etc.)
local tools = {
  "black",           -- Python formatter
  "isort",           -- Python import formatter
  "prettier",        -- JavaScript/TypeScript formatter
  "stylua",          -- Lua formatter
  "markdownlint",    -- Markdown linter
}

-- Setup automatic tool installation with error handling
local mr = require("mason-registry")

-- Try to refresh the registry
local registry_avail, _ = pcall(function() 
  mr.refresh() 
  return mr.get_all_packages()
end)

if registry_avail then
  for _, tool in ipairs(tools) do
    local ok, pkg = pcall(mr.get_package, tool)
    if ok then
      if not pkg:is_installed() then
        -- Try to install the package
        pkg:install()
      end
    else
      vim.notify("Mason: Package not found: " .. tool, vim.log.levels.WARN)
    end
  end
else
  vim.notify("Mason registry unavailable. Check your internet connection or try again later.", vim.log.levels.ERROR)
end

require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "pyright", "eslint" }
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})
vim.lsp.enable(servers)