local opts = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    go = { "gofumpt", "goimports-reviser" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    just = { "just" },
    markdown = { "markdown-lint", "markdown-toc", "mdformat", "injected" },
  },
  formatters = {
    ["golines"] = {
      preapend_args = { "-m", "120" },
    },
    ["goimports-reviser"] = {
      preapend_args = { "-rm-unused", "-project-name 'github.com/polymerdao/polymerase'" },
    },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
  notify_on_error = true,
}

return opts
