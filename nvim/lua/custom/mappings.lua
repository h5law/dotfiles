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
    ["<A-i>"] = "",     -- toggle floating term
    ["<A-h>"] = "",     -- toggle horizontal term
    ["<A-v>"] = "",     -- toggle vertical term
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

  -- console mode
  c = {
    ["W"] = {"w", "Save the current buffer"},
    ["X"] = {"x", "Save and exit the current buffer"},
    ["Q"] = {"q", "Quit"},
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

    ["<leader>po"] = {
      "<cmd> GoPkgOutline <CR>",
      "Show outline of current go package"
    },

    ["<leader>gmt"] = {
      "<cmd> GoModTidy <CR>",
      "Run go mod tidy and restart gopls"
    },

    ["<leader>gst"] = {
      "<cmd> GoAlt! <CR>",
      "Switch to (or create) the go test file for the current file"
    },

    ["<leader>ggr"] = {
      "<cmd> GoGenReturn <CR>",
      "Generate return values for the current function"
    },

    ["<leader>gsj"] = {
      "<cmd> GoAddTags json <CR>",
      "Add json tag to the current struct"
    },

    ["<leader>gc"] = {
      function ()
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
      function ()
        local widgets = require("dap.ui.widgets");
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debuggin sidebar"
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
      function ()
        require("dap-go").debug_test()
      end,
      "Debug go test"
    },

    ["<leader>dgl"] = {
      function ()
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

M.vimtex = {
  plugin = true,
  n = {
    ["<leader>toc"] = {
      "<cmd> VimtexTocOpen <CR>",
      "Open table of contents"
    },

    ["<leader>tlg"] = {
      "<cmd> VimtexLog <CR>",
      "Show a message log"
    },

    ["<leader>tle"] = {
      "<cmd> VimtexErrors <CR>",
      "Show any errors or warnings"
    },

    ["<leader>tsc"] = {
      "<cmd> VimtexStop <CR>",
      "Stop compilation for the current project"
    },

    ["<leader>tsa"] = {
      "<cmd> VimtexStopAll <CR>",
      "Stop compilation for all open projects"
    },

    ["<leader>tcf"] = {
      "<cmd> VimtexClean <CR>",
      "Clean all auxiliary files"
    },

    ["<leader>tv"] = {
      "<cmd> VimtexView <CR>",
      "View the pdf of the current project"
    }
  }
}

return M
