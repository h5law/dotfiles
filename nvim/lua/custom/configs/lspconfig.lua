local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local coq = require "coq"
local util = require "lspconfig/util"

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
  coq.lsp_ensure_capabilities {},
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern(".git", "go.mod", "go.work"),
  setting = {
    gopls = {
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      experimentalPostfixCompletions = true,
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
    },
  },
  coq.lsp_ensure_capabilities {},
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  coq.lsp_ensure_capabilities {},
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
  coq.lsp_ensure_capabilities {},
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentFormattingRangeProvider = false
  end,
  coq.lsp_ensure_capabilities {},
}

lspconfig.solang.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "solidity" },
  coq.lsp_ensure_capabilities {},
}

lspconfig.zls = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "zig" },
  root_dir = util.root_pattern("build.zig", ".git"),
  docs = {
    description = [[ ]],
    default_config = {
      root_dir = [[root_pattern("build.zig", ".git")]],
    },
  },
  coq.lsp_ensure_capabilities {},
}
