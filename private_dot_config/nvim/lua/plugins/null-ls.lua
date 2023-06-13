local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply logic to use different servers instead of null-ls here
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup({
  sources = {
    -- FORMATING
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.xmlformat,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "graphql",
        "yaml",
      },
    }),
    -- DIAGNOSTICS
    null_ls.builtins.diagnostics.hadolint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    end
  end,
})
