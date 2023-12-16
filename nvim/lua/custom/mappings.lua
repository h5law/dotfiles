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
    ["<leader>y"] = { '"+y', "Copy to clipboard" },
    ["<leader>p"] = { '"+p', "Paste from clipboard" },
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

return M
