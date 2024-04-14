local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
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
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      require("core.utils").load_mappings("codeium")
    end,
  },
  {
    "conweller/findr.vim",
    init = function()
      require("core.utils").load_mappings("findr")
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    opts = function(_, opts)
      return require("custom.configs.zenmode")
    end,
    init = function()
      require("core.utils").load_mappings("zenmode")
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    init = function()
      require("dapui").setup()
      require("core.utils").load_mappings("dapui")
    end
  },
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     require("core.utils").load_mappings("copilot")
  --   end,
  -- },
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
        "zls",
        "protolint",
        "pyright",
        "mypy",
        "blackd",
        "ruff",
        "solang",
        "eslint_d",
        "markdown-toc",
        "mdformat",
        "prettierd",
        "lua-language-server",
        "alex",
        "markdownlint",
        "buf",
        "proselint",
        "deno",
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
    event = { "CmdlineEnter" },
    ft = { "go", "gotmpl", "gomod", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_auto_start = 1
  --     vim.g.mkdp_auto_close = 0
  --     vim.g.mkdp_filetypes = { "markdown" }
  --     vim.g.mkdp_browser = "/Applications/Arc.app/Contents/MacOS/Arc"
  --     require("core.utils").load_mappings("mkdp")
  --   end,
  -- },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      require("core.utils").load_mappings("peek")
    end,
  },
  {
    "chentoast/marks.nvim",
    opts = function()
      return require("custom.configs.null-ls")
    end,
    init = function(_, opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "vue",
        "svelte",

        -- system level
        "c",
        "zig",
        "rust",
        "go",

        -- DSL
        "solidity",
      },
    },
  },
}

return plugins
