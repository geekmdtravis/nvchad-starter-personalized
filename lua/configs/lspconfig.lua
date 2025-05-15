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

-- Load default LSP configurations
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

-- Setup servers
local servers = { "html", "cssls", "ts_ls", "pyright", "eslint", "jdtls", "lua_ls"}
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Configure pyright with strict settings
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        strictParameterNoneValue = true,
        strictDictionaryInference = true,
        strictListInference = true,
        strictSetInference = true,
      }
    }
  }
})

-- Configure jdtls
lspconfig.jdtls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    java = {
      format = {
        enabled = true,
        settings = {
          -- Using Google's Java style guide from raw.githubusercontent.com
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle"
        }
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    }
  }
})

-- Configure remaining servers with default settings
for _, server in ipairs(servers) do
  if server ~= "pyright" and server ~= "jdtls" then
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
end
