local lint = require("lint")

lint.linters_by_ft = {
  go = { { "golangcilint", "revive" } },
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  lua = { "luacheck" },
  markdown = { "markdownlint" },
  python = { "mypy" },
  yaml = { "yamllint" },
  zsh = { "zsh" },
}

vim.api.nvim_create_autocmd({ "TextChanged" }, {
  callback = function()
    lint.try_lint()
  end,
})
