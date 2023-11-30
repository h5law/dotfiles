local overrides = require("custom.configs.overrides")

local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/nvim-lsp-installer",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lspconfig" },
    opts = function()
      return require("custom.configs.null-ls")
    end,
    init = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "gopls",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golines",
        "protolint",
        "pyright",
        "ruff",
        "eslint_d",
        "markdown-toc",
        "mdformat",
        "prettierd",
        "deno",
        "lua-language-server",
        "shellcheck",
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      return require("custom.configs.gonvim")
    end,
    config = function(_, opts)
      require("go").setup(opts)
      require("core.utils").load_mappings("gonvim")
    end,
    event = {"CmdlineEnter"},
    ft = {"go", "gotmpl", "gomod", "gowork"},
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "mfussenegger/nvim-dap",
    init = function ()
      require("core.utils").load_mappings("dap")
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "/Applications/Arc.app/Contents/MacOS/Arc"
      require("core.utils").load_mappings("mkdp")
    end,
    ft = { "markdown" },
  },
}

return plugins
