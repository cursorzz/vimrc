require("mason").setup()
local mason_lsp = require("mason-lspconfig")

local function on_attach(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<c-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
  vim.keymap.set("n", "gh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  vim.keymap.set("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
  vim.keymap.set("n", "gm", "<Cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
  vim.keymap.set("n", "gl", "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", bufopts)
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
  vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", bufopts)
  vim.keymap.set("n", "gn", "<Cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
  vim.keymap.set("n", "gs", "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
  vim.keymap.set("n", "gw", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", bufopts)
  vim.keymap.set("n", "[x", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
  vim.keymap.set("n", "]x", "<Cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
  vim.keymap.set("n", "]r", "<Cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  vim.keymap.set("n", "]s", "<Cmd>lua vim.diagnostic.show()<CR>", bufopts)

  vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
      pattern = {
        "*"
      },
      command = [[lua vim.lsp.buf.format()]]
    }
  )
end

mason_lsp.setup({})
mason_lsp.setup_handlers(
  {
    function(server)
      require("lspconfig")[server].setup(
        {
          on_attach = on_attach
        }
      )
    end
  }
)

-- local installed = require('mason-lspconfig').get_installed_servers()
-- vim.pretty_print(installed)
-- for i in pairs(installed) do
--   require("lspconfig")[installed[i]].setup{}
-- end
--