local lsp = require "lspconfig"
-- local configs = require "lspconfig/configs"
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require "nvim-lsp-installer.servers"
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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

require "lspconfig/configs".emmet_ls = {
  default_config = {
    cmd = {"emmet-ls", "--stdio"},
    filetypes = {"html", "css"},
    root_dir = require "lspconfig".util.root_pattern(".git", vim.fn.getcwd())
  }
}

local on_attach = function(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

local function ensure_servers_installed()
  local ensure_servers = {"gopls", "sumneko_lua", "solargraph", "vuels", "cssls", "html", "emmet_ls"}
  for _, f in pairs(ensure_servers) do
    local server_available, server = lsp_installer_servers.get_server(f)
    if server_available then
      if not server:is_installed() then
        server:install()
      end
    end
  end
end

lsp_installer.on_server_ready(
  function(server)
    ensure_servers_installed()
    local opts = {
      capabilities = capabilities,
      on_attach = function(client)
        -- if server.name == "gopls" then
        --   client.resolved_capabilities.document_formatting = false
        -- end
        local no_formattings = {"tsserver", "jsonls"}
        for _, f in pairs(no_formattings) do
          print(f)
          if server.name == f then
            client.resolved_capabilities.document_formatting = false
          end
        end

        on_attach(client)
        require("lsp_signature").on_attach()
      end
    }

    if server.name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          workspace = {
            maxPreload = 10000, -- Add this if missing or increase it
            preloadFileSize = 10000, -- Add this if missing or increase it
            checkThirdParty = false
          }
        }
      }
    end
    server:setup(opts)
  end
)

-- configs.emmet_ls = {
--   default_config = {
--     cmd = {"emmet-ls", "--stdio"}
--     filetypes = {"html", "css"},
--     root_dir = function()
--       return vim.loop.cwd()
--     end,
--     settings = {}
--   }
-- }

-- lsp.html.setup {
--   capabilities = capabilities,
--   filetypes = {"html", "vue"}
-- }

-- npm install -g emmet-ls
-- require'lspconfig'.emmet_ls.setup{
--   on_attach = on_attach;
-- }
-- if vim.fn.has("mac") == 1 then
--   local sumneko_root_path = "/Users/zaczeng/.config/nvim/binaries/lua-language-server"
--   local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

--   local runtime_path = vim.split(package.path, ";")
--   table.insert(runtime_path, "lua/?.lua")
--   table.insert(runtime_path, "lua/?/init.lua")

--   lsp.sumneko_lua.setup {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--     filetypes = {"lua"},
--     settings = {
--       Lua = {
--         runtime = {
--           -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--           version = "LuaJIT",
--           -- Setup your lua path
--           path = runtime_path
--         },
--         diagnostics = {
--           -- Get the language server to recognize the `vim` global
--           globals = {"vim"}
--         },
--         workspace = {
--           -- Make the server aware of Neovim runtime files
--           library = vim.api.nvim_get_runtime_file("", true)
--         },
--         -- Do not send telemetry data containing a randomized but unique identifier
--         telemetry = {
--           enable = false
--         }
--       }
--     }
--   }
-- end
-- lsp.emmet_ls.setup {}

-- npm i -g vim-language-server
-- lsp.vimls.setup {}
-- lsp.solargraph.setup {}
-- lsp.tsserver.setup {}
-- npm install -g vscode-json-languageserver
-- lsp.jsonls.setup {}
-- lsp.gopls.setup {
--   capabilities = capabilities,
--   on_attach = function(client)
--     -- client.resolved_capabilities.document_formatting = false
--     --   --   capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--     require("lsp_signature").on_attach()
--   end
-- }
-- npm install -g vls
-- lsp.vuels.setup {
--   capabilities = capabilities,
--   on_attach = function(client)
--     require("lsp_signature").on_attach()
--     client.resolved_capabilities.document_formatting = false
--   end
-- }
-- -- npm install -g vscode-css-languageserver-bin
-- lsp.cssls.setup {}

-- auto put errors to quick fix list
--

-- local severity_map = {"E", "W", "I", "H"}

-- local parse_diagnostics = function(diagnostics)
--   if not diagnostics then
--     return
--   end
--   local items = {}
--   for _, diagnostic in ipairs(diagnostics) do
--     local fname = vim.fn.bufname()
--     local position = diagnostic.range.start
--     local severity = diagnostic.severity
--     table.insert(
--       items,
--       {
--         filename = fname,
--         type = severity_map[severity],
--         lnum = position.line + 1,
--         col = position.character + 1,
--         text = diagnostic.message:gsub("\r", ""):gsub("\n", " ")
--       }
--     )
--   end
--   return items
-- end

-- redefine unwanted callbacks to be an empty function
-- notice that I keep `vim.lsp.util.buf_diagnostics_underline()`
-- vim.lsp.util.buf_diagnostics_signs = function() return end
-- vim.lsp.util.buf_diagnostics_virtual_text = function() return end

-- local update_diagnostics_loclist = function()
--   if vim.lsp.diagnostic.get_count(0, [[Error]]) > 0 then
--     vim.lsp.diagnostic.set_loclist({open_loclist = false})
--   else
--     -- vim.cmd [[lclose]]
--   end
-- end

-- vim.api.nvim_command [[autocmd! User LspDiagnosticsChanged lua update_diagnostics_loclist()]]
