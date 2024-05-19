local null_ls = require("null-ls")

local sources = {
  null_ls.builtins.diagnostics.actionlint,
  null_ls.builtins.diagnostics.buf,
  null_ls.builtins.diagnostics.checkmake,
  null_ls.builtins.diagnostics.cmake_lint,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.cpplint,
  null_ls.builtins.diagnostics.protolint,
  null_ls.builtins.diagnostics.revive,
  null_ls.builtins.diagnostics.ruff,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.todo_comments,
  null_ls.builtins.diagnostics.vacuum,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.zsh,

  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.buf,
  null_ls.builtins.formatting.cbfmt,
  null_ls.builtins.formatting.clang_format,
  null_ls.builtins.formatting.cmake_format,
  null_ls.builtins.formatting.forge_fmt,
  null_ls.builtins.formatting.goimports_reviser,
  null_ls.builtins.formatting.golines.with({
    extra_args = {
      "--max-len=120",
      "--base-formatter=gofumpt",
      "--tab-width=4",
      "--ignore-generated",
    },
  }),
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.lua_format,
  null_ls.builtins.formatting.markdown_toc,
  null_ls.builtins.formatting.mdformat,
  null_ls.builtins.formatting.protolint,
  null_ls.builtins.formatting.ruff,
  null_ls.builtins.formatting.shfmt,
}

-- local gotest = require("go.null_ls").gotest()
-- local gotest_codeaction = require("go.null_ls").gotest_action()
-- local golangci_lint = require("go.null_ls").golangci_lint()
-- table.insert(sources, gotest)
-- table.insert(sources, gotest_codeaction)
-- table.insert(sources, golangci_lint)

local organise_imports = function(bufnr, isPreflight)
  local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(bufnr))
  params.context = { only = { "source.organizeImports" } }

  if isPreflight then
    vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function() end)
    return
  end

  local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(bufnr))
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

local formatgroup = vim.api.nvim_create_augroup("LspFormatting", {})
local actiongroup = vim.api.nvim_create_augroup("LspCodeAction", {})

local function ignore_files(names)
  for name in pairs(names) do
    if vim.fn.expand("%:t") == name then
      return {}
    end
  end
end

ignore_files({ "gen.nvim" })

local opts = {
  debug = false,
  sources = sources,
  debounce = 1000,
  default_timeout = 5000,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = formatgroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatgroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            debug = false,
            async = true,
            filter = function()
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
    local clients = vim.lsp.get_active_clients()
    if next(clients) ~= nil then
      for _, cli in pairs(clients) do
        if cli.supports_method("textDocument/codeAction") then
          vim.api.nvim_clear_autocmds({ group = actiongroup, buffer = bufnr })
          -- HACK: Perform a preflight async request to the LSP, to prevent
          -- blocking when saving a buffer for the first time.
          organise_imports(bufnr, true)

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("LspOrganiseImports." .. bufnr, {}),
            callback = function()
              organise_imports(bufnr, false)
            end,
          })
        end
      end
    end
  end,
}

return opts
