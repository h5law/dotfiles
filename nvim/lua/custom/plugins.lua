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
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lspconfig" },
    opts = function()
      return require("custom.configs.null-ls")
    end,
    init = function(opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
    init = function()
      require('dressing').setup({
        input = {
          win_options = {
            winhighlight = 'NormalFloat:DiagnosticError'
          }
        },
        select = {
          get_config = function()
            return {
              backend = 'fzf',
              nui = {
                relative = 'cursor',
                max_width = 40,
              }
            }
          end
        }
      })
    end
  },
  {
    "conweller/findr.vim",
    init = function()
      require("core.utils").load_mappings("findr")
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      require("core.utils").load_mappings("trouble")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    requires = {
      'nvim-tree/nvim-web-devicons'
    },
    init = function()
      require("core.utils").load_mappings("fzf")
    end,
  },
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    opts = function()
      return require("custom.configs.ollama")
    end,
    config = function(_, opts)
      require("ollama").setup(opts)
    end,
    init = function()
      require("core.utils").load_mappings("ollama")
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
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    opts = function()
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
        "revive",
        "zls",
        "protolint",
        "pyright",
        "pylint",
        "isort",
        "black",
        "clang-format",
        "cpplint",
        "ruff",
        "solang",
        "solhint",
        "markdown-toc",
        "mdformat",
        "prettierd",
        "lua-language-server",
        "markdownlint",
        "buf",
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
