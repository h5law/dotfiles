local M = {}

-- disable default mappings
M.disabled = {
  -- normal mode
  n = {
    ["<leader>n"] = "", -- toggle line number
    ["<A-i>"] = "", -- toggle floating term
    ["<A-h>"] = "", -- toggle horizontal term
    ["<A-v>"] = "", -- toggle vertical term
    ["<leader>h"] = "", -- new horizontal term
    ["<leader>v"] = "", -- new vertical term
  },

  -- visual mode
  v = {
    ["y"] = "", -- yank
    ["p"] = "", -- paste
    ["P"] = "", -- paste before
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
    ["<leader>cx"] = { "<CMD>close<CR>", "Close current window" },
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
      "Test current go function",
    },

    ["<leader>tf"] = {
      "<cmd> GoTestFile -v <CR>",
      "Test current go file",
    },

    ["<leader>tp"] = {
      "<cmd> GoTestPkg <CR>",
      "Test current go package",
    },

    ["<leader>gmt"] = {
      "<cmd> GoModTidy <CR>",
      "Run go mod tidy and restart gopls",
    },

    ["<leader>gst"] = {
      "<cmd> GoAlt! <CR>",
      "Switch to (or create) the go test file for the current file",
    },

    ["<leader>gsj"] = {
      "<cmd> GoAddTags json <CR>",
      "Add json tag to the current struct",
    },

    ["<leader>ie"] = {
      "<cmd> GoIfErr <CR>",
      "Creae an if err == nil statement",
    },

    ["<leader>gc"] = {
      function()
        require("go.comment").gen()
      end,
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },

    ["<leader>dso"] = {
      "<cmd> DapStepOver <CR>",
      "Debug step over",
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

M.mkdp = {
  plugin = true,
  n = {
    ["<leader>mp"] = {
      "<cmd> MarkdownPreviewToggle <CR>",
      "Toggle markdown preview",
    },
  },
}

M.fzf = {
  plugin = true,
  n = {
    ["<leader>fg"] = {
      "<cmd> FzfLua grep_visual <CR>",
      "Open Fzf Grep",
    },

    ["<leader>fs"] = {
      "<cmd> FzfLua lsp_document_symbols <CR>",
      "Get All Symbols of current file",
    },

    ["<leader>gs"] = {
      "<cmd> FzfLua git_status <CR>",
      "Show and interactive git status window side by side with diff",
    },
  },
}

M.zenmode = {
  plugin = true,
  n = {
    ["<leader>zm"] = {
      "<cmd> ZenMode <CR>",
      "Toggle ZenMode",
    },
  },
}

M.gen = {
  plugin = true,
  n = {
    ["π"] = {
      "<cmd> Gen Chat<CR>",
      "Launch Gen AI Chat (Option + p)",
    },
  },
}

M.ollama = {
  plugin = true,
  n = {
    ["<leader>ps"] = {
      function()
        require("ollama").prompt()
      end,
      "ollama prompt",
    },
  },

  v = {
    ["<leader>ps"] = {
      function()
        require("ollama").prompt()
      end,
      "ollama prompt",
    },
  },
}

M.findr = {
  plugin = true,
  n = {
    ["<leader>fd"] = {
      "<cmd> Findr <CR>",
      "Open Findr",
    },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>ts"] = {
      "<cmd> Trouble <CR>",
      "Toggle Trouble",
    },
  },
}

M.harpoon = {
  plugin = true,
  n = {
    ["<leader>a"] = {
      function()
        require("harpoon"):list():add()
      end,
      "Add file to harpoon",
    },

    -- Option + f
    ["ƒ"] = {
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
      end,
      "Toggle harpoon menu (Option + f)",
    },

    -- Option + Shift + P
    ["∏"] = {
      function()
        require("harpoon"):list():prev()
      end,
      "Navigate previous harpoon list item (Option + Shift + P)",
    },

    -- Option + Shift + N
    ["ˆ"] = {
      function()
        require("harpoon"):list():next()
      end,
      "Navigate next harpoon list item (Option + Shift + N)",
    },
  },
}

M.codesnap = {
  plugin = true,
  v = {
    ["<leader>cb"] = {
      "<cmd> CodeSnap <CR>",
      "Copy selected code snapshot into clipboard",
    },

    ["<leader>cs"] = {
      "<cmd> CodeSnapSave <CR>",
      "Save selected code snapshot in ~/Pictures/CodeSnippets/",
    },
  },
}

M.conform = {
  plugin = true,
  v = {
    ["<leader>vf"] = {
      function()
        require("conform").format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        }
      end,
      "Format visual block",
    },
  },
}

M.tree = {
  plugin = true,
  n = {
    ["<C-n>"] = {
      "<cmd>CHADopen<CR>",
      "Toggle CHADtree File Viewer",
    },
  },
}

return M
