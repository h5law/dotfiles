---@type ChadrcConfig

local M = {}

M.ui = {
    theme = 'doomchad',
    nvdash = { load_on_startup = true },
    statusline = {
        theme = "minimal",
        separator_style = "default",
    },
}

M.plugins = 'custom.plugins'

M.mappings = require("custom.mappings")

return M
