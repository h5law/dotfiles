local plugins = {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "ms-jpq/coq_nvim", branch = "coq" },
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    init = function()
      require "custom.configs.coq"
    end,
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "ms-jpq/chadtree",
    branch = "chad",
    init = function()
      os.execute "python3 -m chadtree deps"
      require("core.utils").load_mappings "tree"
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return require "custom.configs.conform"
    end,
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "custom.configs.lint"
    end,
  },
  {
    "rcarriga/nvim-notify",
    init = function()
      vim.notify = require "notify"
    end,
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
      require("core.utils").load_mappings "codesnap"
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
    init = function()
      require("dressing").setup {
        input = {
          win_options = {
            winhighlight = "NormalFloat:DiagnosticError",
          },
        },
        select = {
          get_config = function()
            return {
              backend = "fzf",
              nui = {
                relative = "cursor",
                max_width = 40,
              },
            }
          end,
        },
      }
    end,
  },
  {
    "conweller/findr.vim",
    init = function()
      require("core.utils").load_mappings "findr"
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      require("core.utils").load_mappings "trouble"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      require("harpoon").setup()
      require("core.utils").load_mappings "harpoon"
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      require("core.utils").load_mappings "fzf"
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
      init = function(opts)
        pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      end,

      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      display_mode = "split",
      show_prompt = true,
      show_model = true,
      no_auto_close = true,
      debug = false,
    },
    init = function()
      require("core.utils").load_mappings "gen"
    end,
  },
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    opts = function()
      return require "custom.configs.ollama"
    end,
    init = function()
      require("core.utils").load_mappings "ollama"
    end,
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    opts = function()
      return require "custom.configs.zenmode"
    end,
    init = function()
      require("core.utils").load_mappings "zenmode"
    end,
  },
  -- {
  --   "folke/neodev.nvim",
  --   opts = {},
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "vim-test/vim-test",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "fredrikaverpil/neotest-golang",
        dependencies = {
          {
            "leoluz/nvim-dap-go",
            opts = {},
          },
        },
        branch = "main",
      },
      "lawrence-laz/neotest-zig",
      "rouge8/neotest-rust",
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      HOME_PATH = os.getenv "HOME" .. "/"
      MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
      local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
      local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb.so"

      local opts = {
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
      require("neotest").setup {
        adapters = {
          require("neotest-golang").setup {
            gp_test_args = {
              "-v",
              "-race",
              "-count=1",
            },
          },
          require("neotest-rust").setup(opts),
          require("neotest").setup {
            adapters = {
              require "neotest-zig" {
                dap = {
                  adapter = "lldb",
                },
              },
            },
          },
          require "neotest-plenary",
          require("neotest-vim-test").setup {
            ignore_file_types = { "rust", "go", "zig", "vim", "lua" },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run { suite = true, strategy = "neovim-sticky" }
        end,
        desc = "Test nearest test",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run { suite = true, strategy = "dap" }
        end,
        desc = "Debug nearest test",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    init = function()
      require("core.utils").load_mappings "dapui"
      local dap = require "dap"
      local dapui = require "dapui"
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
    end,
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
        "golangci-lint",
        "delve",
        "zls",
        "isort",
        "black",
        "mypy",
        "clangd",
        "codelldb",
        "clang-format",
        "solang",
        "solhint",
        "stylua",
        "markdownlint",
        "markdown-toc",
        "mdformat",
        "shellcheck",
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
      return require "custom.configs.gonvim"
    end,
    config = function(_, opts)
      require("go").setup(opts)
      require("core.utils").load_mappings "gonvim"
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
      require("core.utils").load_mappings "dap"
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
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_browser = "/Applications/Arc.app/Contents/MacOS/Arc"
      require("core.utils").load_mappings "mkdp"
    end,
  },
  {
    "chentoast/marks.nvim",
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      multiline_threshold = 5,
      zindex = 5,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
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
        "codelldb",

        -- DSL
        "solidity",
      },
    },
  },
}

return plugins
