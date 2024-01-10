-- Enable filetype plugins and indenting
vim.cmd 'filetype plugin indent on'

-- Enable syntax highlighting
vim.cmd 'syntax enable'

-- Set guicursor
vim.cmd [[set guicursor=a:blinkon1]]

-- Set shell
vim.opt.shell = "/bin/zsh"

-- Encoding
vim.opt.fileencoding = "utf-8"

-- Spelling
vim.opt.spelllang = "en_gb"

-- Highlight columns
vim.opt.colorcolumn = "80,90,120"
vim.opt.signcolumn = "auto"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Colours
vim.opt.termguicolors = true

-- Lines
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse
vim.opt.mouse = "a"

-- Indentation
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Codeium
vim.g.codeium_disable_bindings = 1

-- Set global variables for vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0

-- TreeSitter Context
vim.api.nvim_set_hl(0, "TreesitterContextBottom", {underline = true, sp = "Grey"})
