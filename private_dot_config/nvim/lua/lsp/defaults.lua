local remap = require("me.util").remap

local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(client, bufnr)
  if client.name == "tsserver" or "java" then
    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
  end

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  remap("n", "gD", vim.lsp.buf.declaration, bufopts, "Go to declaration")
  remap("n", "gd", vim.lsp.buf.definition, bufopts, "Go to definition")
  remap("n", "gi", vim.lsp.buf.implementation, bufopts, "Go to implementation")
  remap("n", "ge", vim.diagnostic.open_float, bufopts, "Show error")
  remap("n", "<leader>k", vim.lsp.buf.hover, bufopts, "Hover text")
  remap("n", "<leader>s", vim.lsp.buf.signature_help, bufopts, "Show signature")
  remap("n", "<space>D", vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  remap("n", "<space>rn", vim.lsp.buf.rename, bufopts, "Rename")
  remap("n", "<space>ca", vim.lsp.buf.code_action, bufopts, "Code actions")
  require("which-key").register({
    d = {
      name = "lsp",
    },
  }, { prefix = "<leader>" })
end

return M
