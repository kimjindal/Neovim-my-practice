local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local codeactions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier,
    formatting.black.with { extra_args = { "--fast" } },
    formatting.dart_format,
    formatting.stylua,
    formatting.eslint_d,
    diagnostics.flake8,
    diagnostics.eslint_d,
    codeactions.eslint_d,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd [[
        augroup LspFormatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]]
    end
  end,
}
