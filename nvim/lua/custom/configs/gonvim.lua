local opts = {
  go="go",
  goimports="gopls",
  gofmt = "gofumpt",
  tag_transform = "snakecase",
  tag_options = "json=omitempty",
  comment_placeholder = "" ,  -- comment placeholder e.g. 󰟓       
  icons = {breakpoint = "🧘", currentpos = "🏃"},
  lsp_cfg = false,
  lsp_keymaps = false;
  lsp_document_formatting = false,
  lsp_codelens = false,
  diagnostic = false,
  lsp_inlay_hints = {
    enable = false,
  },
  dap_debug = true,
  dap_debug_keymap = true,
  run_in_floaterm = true,
}

return opts
