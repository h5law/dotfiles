local opts = {
  window = {
    width = function()
      if vim.api.nvim_win_get_width(0) > 140 then
        return 140
      else
        return .85 * vim.api.nvim_win_get_width(0)
      end
    end,
  },
}

return opts
