local lsp = require'lspconfig'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable signs
  virtual_text = true,
  -- signs = false,
  }
)

lsp.vimls.setup{}
lsp.solargraph.setup{}
lsp.tsserver.setup{}
-- npm install -g vscode-json-languageserver
lsp.jsonls.setup{}
lsp.vuels.setup{}
lsp.gopls.setup{}
-- npm install -g vscode-css-languageserver-bin
lsp.cssls.setup{}
