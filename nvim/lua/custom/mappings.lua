local M = {}

-- disable default mappings
M.disabled = {
  -- normal mode
  n = {
    ["<leader>n"] = "", -- toggle line number
    ["<A-i>"] = "",     -- toggle floating term
    ["<A-h>"] = "",     -- toggle horizontal term
    ["<A-v>"] = "",     -- toggle vertical term
    ["<leader>h"] = "", -- new horizontal term
    ["<leader>v"] = "", -- new vertical term
  },

  -- visual mode
  v = {
    ["y"] = "",         -- yank
    ["p"] = "",         -- paste
    ["P"] = "",         -- paste before
    ["<leader>y"] = "", -- copy to clipboard
    ["<leader>p"] = "", -- paste from clipboard
  },

  -- terminal mode
  t = {
    ["<A-i>"] = "", -- toggle floating term
    ["<A-h>"] = "", -- toggle horizontal term
    ["<A-v>"] = "", -- toggle vertical term
  },
}

M.common = {
  -- visual mode
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv", "Move line down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move line up" },
    ["y"] = { '"+y', "Yank To Clipboard" },
    ["p"] = { '"+p', "Paste from Clipboard" },
    ["P"] = { '"+P', "Paste before from Clipboard" },
  },

  -- normal mode
  n = {
    ["<leader>sp"] = { "ggi SPDX-License-Identifier: <ESC>o<ESC>" },
    ["+"] = { "<CMD>vertical resize +5<CR>", "Increase window width" },
    ["_"] = { "<CMD>vertical resize -5<CR>", "Decrease window width" },
    ["="] = { "<CMD>horizontal resize +5<CR>", "Increase window height" },
    ["-"] = { "<CMD>horizontal resize -5<CR>", "Decrease window height" },
  },

  -- console mode
  c = {
    ["W"] = { "w", "Save the current buffer" },
    ["X"] = { "x", "Save and exit the current buffer" },
    ["Q"] = { "q", "Quit" },
  },
}

M.nvterm = {
  -- terminal mode
  t = {
    ["Ê"] = { -- Shift+Option+t
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term (Shift+Option+t)",
    },

    ["Ó"] = { -- Shift+Option+h
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term (Shift+Option+h)",
    },

    ["◊"] = { -- Shift+Option+v
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term (Shift+Option+v)",
    },
  },

  -- normal mode
  n = {
    ["Ê"] = { -- Shift+Option+t
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term (Shift+Option+t)",
    },

    ["Ó"] = { -- Shift+Option+h
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term (Shift+Option+h)",
    },

    ["◊"] = { -- Shift+Option+v
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term (Shift+Option+v)",
    },
  },
}

M.gonvim = {
  plugin = true,
  n = {
    ["<leader>tm"] = {
      "<cmd> GoTestFunc -v <CR>",
      "Test current go function"
    },

    ["<leader>tf"] = {
      "<cmd> GoTestFile -v <CR>",
      "Test current go file"
    },

    ["<leader>tp"] = {
      "<cmd> GoTestPkg <CR>",
      "Test current go package"
    },

    ["<leader>gmt"] = {
      "<cmd> GoModTidy <CR>",
      "Run go mod tidy and restart gopls"
    },

    ["<leader>gst"] = {
      "<cmd> GoAlt! <CR>",
      "Switch to (or create) the go test file for the current file"
    },

    ["<leader>gsj"] = {
      "<cmd> GoAddTags json <CR>",
      "Add json tag to the current struct"
    },

    ["<leader>gc"] = {
      function()
        require("go.comment").gen()
      end
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },

    ["<leader>dus"] = {
      function()
        local widgets = require("dap.ui.widgets");
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    },

    ["<leader>dso"] = {
      "<cmd> DapStepOver <CR>",
      "Debug step over"
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test"
    },

    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test"
    },
  },
}

M.mkdp = {
  plugin = true,
  n = {
    ["<leader>mp"] = {
      "<cmd> MarkdownPreview <CR>",
      "Toggle Markdown Preview"
    },
  },
}

M.peek = {
  plugin = true,
  n = {
    ["<leader>mpo"] = {
      "<cmd> PeekOpen <CR>",
      "Open peek"
    },

    ["<leader>mpc"] = {
      "<cmd> PeekClose <CR>",
      "Close peek"

    },
  },
}

M.codeium = {
  plugin = true,
  i = {
    -- Option + l
    ["¬"] = {
      function()
        return vim.fn["codeium#Accept"]()
      end,
      "Accept completion (Option + l)",
      opts = { expr = true, silent = true },
    },

    -- Option + Shift + ;
    ["<Ú>"] = {
      function()
        return vim.fn["codeium#Complete"]()
      end,
      "Manually trigger suggestions (Option + Shift + ;)",
      opts = { expr = true, silent = true },
    },

    -- Option+;
    ["<…>"] = {
      function()
        return vim.fn["codeium#CycleCompletions"](1)
      end,
      "Next suggestion (Option + ;)",
      opts = { expr = true, silent = true },
    },

    -- Option + ,
    ["<≤>"] = {
      function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end,
      "Previous suggestion (Option + ,)",
      opts = { expr = true, silent = true },
    },

    -- Option+x
    ["<≈>"] = {
      function()
        return vim.fn["codeium#Clear"]()
      end,
      "Clear current suggestion (Option + x)",
      opts = { expr = true, silent = true },
    },
  },
}

M.fzf = {
  plugin = true,
  n = {
    ["<leader>fg"] = {
      "<cmd> FzfLua grep_visual <CR>",
      "Open Fzf Grep"
    },

    ["<leader>fs"] = {
      "<cmd> FzfLua lsp_document_symbols <CR>",
      "Get All Symbols of current file"
    },
  },
}

M.zenmode = {
  plugin = true,
  n = {
    ["<leader>zm"] = {
      "<cmd> ZenMode <CR>",
      "Toggle ZenMode"
    },
  },
}

M.dapui = {
  plugin = true,
  n = {
    ["<leader>duo"] = {
      function()
        require("dapui").open()
      end,
    },
    ["<leader>duc"] = {
      function()
        require("dapui").close()
      end,
    },
  },
}

M.ollama = {
  plugin = true,
  n = {
    ["<leader>ps"] = {
      function()
        require('ollama').prompt()
      end,
      "ollama prompt",
    },
    ["<leader>gc"] = {
      function()
        require('ollama').prompt('Generate_Code')
      end,
      "ollama Generate Code",
    },
  },

  v = {
    ["<leader>ps"] = {
      function()
        require('ollama').prompt()
      end,
      "ollama prompt",
    },
    ["<leader>gc"] = {
      function()
        require('ollama').prompt('Generate_Code')
      end,
      "ollama Generate Code",
    },
  },
}

M.findr = {
  plugin = true,
  n = {
    ["<leader>fd"] = {
      "<cmd> Findr <CR>",
      "Open Findr"
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>ts"] = {
      "<cmd> Trouble <CR>",
      "Toggle Trouble"
    },
  },
}

return M
