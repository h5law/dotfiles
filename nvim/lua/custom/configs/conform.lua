local opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    c = { "clang-format" },
    cpp = { "clang-format" },
    go = { { "goimports-reviser", "gofumpt", "golines" } },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    just = { "just" },
    markdown = { { "markdown-lint", "markdown-toc", "mdformat", "injected" } },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
  notify_on_error = true,
}

return opts
