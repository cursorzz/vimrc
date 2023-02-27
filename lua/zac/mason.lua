local keymap = vim.keymap.set

require("mason").setup()
local mason_lsp = require("mason-lspconfig")

local function on_attach(client, bufnr)
  local bufopts = {noremap = true, silent = true, buffer = bufnr}
  keymap("n", "<c-]>", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
  keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", bufopts)
  -- keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  keymap("n", "<leader>ca", "<Cmd>Lspsaga code_action<CR>", bufopts)
  keymap("n", "gm", "<Cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
  keymap("n", "gl", "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", bufopts)
  -- keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  keymap("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", bufopts)
  keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
  keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", bufopts)
  keymap("n", "gn", "<Cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
  keymap("n", "gs", "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
  keymap("n", "gw", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", bufopts)
  keymap("n", "<C-p>", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
  keymap("n", "<C-n>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
  keymap("n", "]r", "<Cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  keymap("n", "]s", "<Cmd>lua vim.diagnostic.show()<CR>", bufopts)

  -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  -- if client.supports_method("textDocument/formatting") then
  --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --   vim.api.nvim_create_autocmd(
  --     "BufWritePre",
  --     {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format()
  --       end
  --     }
  --   )
  -- end
  --
  -- vim.api.nvim_create_autocmd(
  --   "BufWritePre",
  --   {
  --     pattern = {
  --       "*"
  --     },
  --     command = [[lua vim.lsp.buf.format({async = true})]]
  --   }
  -- )

  require("lsp_signature").on_attach(
    {
      hint_enable = false
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
