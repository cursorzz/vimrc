local lsp = require "lspconfig"
-- local configs = require "lspconfig/configs"
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require "nvim-lsp-installer.servers"
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- vim.lsp.set_log_level("debug")

-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
--   {
--     -- Disable signs
--     virtual_text = false
--     -- signs = false,
--   }
-- )
vim.diagnostic.config(
  {
    virtual_text = false,
    signs = true,
    float = {border = "single"}
  }
)

local on_attach = function(client)
  if client.server_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local function ensure_servers_installed()
  local ensure_servers = {"gopls", "sumneko_lua", "solargraph", "volar", "cssls", "html", "emmet_ls"}
  for _, f in pairs(ensure_servers) do
    local server_available, server = lsp_installer_servers.get_server(f)
    if server_available then
      if not server:is_installed() then
        server:install()
      end
    end
  end
end

-- lsp_installer.on_server_ready(
--   function(server)
--     ensure_servers_installed()
--     local opts = {
--       capabilities = capabilities,
--       on_attach = function(client, bufnr)
--         local no_formattings = {"tsserver", "jsonls", "volar"}
--         for _, f in pairs(no_formattings) do
--           if server.name == f then
--             client.server_capabilities.document_formatting = false
--           end
--         end
--
--         -- if client.server_capabilities.colorProvider then
--         --   require("lsp/colorizer").buf_attach(bufnr, {single_column = false, debounce = 500})
--         -- end
--
--         on_attach(client)
--         require("lsp_signature").on_attach(
--           {
--             hint_enable = false
--           }
--         )
--       end
--     }
--
--     if server.name == "emmet_ls" then
--       opts.settings = {
--         filetypes = {"html", "css", "vue"}
--       }
--     end
--
--     if server.name == "sumneko_lua" then
--       opts.settings = {
--         Lua = {
--           workspace = {
--             maxPreload = 10000, -- Add this if missing or increase it
--             preloadFileSize = 10000, -- Add this if missing or increase it
--             checkThirdParty = false
--           }
--         }
--       }
--     end
--     server:setup(opts)
--   end
-- )
