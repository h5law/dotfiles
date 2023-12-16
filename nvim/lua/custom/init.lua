-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set shell
vim.opt.shell = "/bin/zsh"

-- Encoding
vim.opt.fileencoding = "utf-8"

-- Spelling
vim.opt.spelllang = "en_gb"

-- Highlight columns
vim.opt.colorcolumn = "80,90"
vim.opt.signcolumn = "yes"

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
