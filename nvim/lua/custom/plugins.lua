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
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    opts = function()
      return require("custom.configs.null-ls")
    end,
    init = function(opts)
      require("null-ls").setup(opts)
    end,
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    opts = {
      title = "code snippet",
      save_path = "~/Captures/CodeSnaps/",
      has_line_number = true,
      watermark = "",
      code_font_family = "JetBrainsMono Nerd Font",
      bg_theme = "bamboo",
    },
    config = function(_, opts)
      require("codesnap").setup(opts)
      require("core.utils").load_mappings("codesnap")
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
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      require("harpoon").setup()
      require("core.utils").load_mappings("harpoon")
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    init = function()
      require("core.utils").load_mappings("fzf")
    end,
  },
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "llama3:latest",
      host = "localhost",
      port = "11434",
      quit_map = "q",
      retry_map = "<c-r>",
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,

      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
      display_mode = "split",
      show_prompt = true,
      show_model = true,
      no_auto_close = true,
      debug = false,
    },
    init = function()
      require("core.utils").load_mappings("gen")
    end
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
      require("core.utils").load_mappings("dapui")
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
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
        "delve",
        "zls",
        "protolint",
        "pyright",
        "pylint",
        "isort",
        "black",
        "clangd",
        "codelldb",
        "clang-format",
        "cpplint",
        "ruff",
        "solang",
        "solhint",
        "markdown-toc",
        "mdformat",
        "lua-language-server",
        "shellcheck",
        "buf",
        "deno",
        "actionlint",
      },
    },
  },
  {
    "ray-x/guihua.lua",
    run = "cd lua/fzy && make",
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
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
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
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "/Applications/Orion.app/Contents/MacOS/Orion"
      require("core.utils").load_mappings("mkdp")
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
        "cpp",
        "rust",
        "go",
        "zig",

        -- DSL
        "solidity",
      },
    },
  },
}

return plugins
