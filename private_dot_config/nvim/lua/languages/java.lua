local api = vim.api
local M = {}

local capabilities = {
  workspace = { configuration = true },
  textDocument = { completion = { completionItem = { snippetSupport = true } } },
}

M.lsp = { capabilities = capabilities, on_attach = on_attach }

M.template = {
  ['1'] = [[
package %s;
public class %s {
}]],
  ['2'] = [[
package %s;
public interface %s {
}]],
}

return M
