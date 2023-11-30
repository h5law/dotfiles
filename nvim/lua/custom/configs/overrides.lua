local M = {}

M.copilot = {
  panel = {
    auto_refresh = false,
    keymap = {
      accept = "<S-CR>",
      jump_prev = "[[",
      jump_next = "]]",
      refresh = "gr",
      open = "<C-CR>",
    },
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "¬", --Option+l
      prev = "“", --Option+[
      next = "‘", --Option+]
      dismiss = "<C-]>",
    },
  },
}

return M
