local lsp = require'lspconfig'

vim.lsp.set_log_level("debug")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable signs
  virtual_text = true,
  -- signs = false,
  }
)

-- npm install -g emmet-ls
require'lspconfig/configs'.emmet_ls = {
  default_config = {
    cmd = {'emmet-ls', '--stdio'},
    filetypes = {'html', 'css'},
    root_dir = require'lspconfig'.util.root_pattern(".git", vim.fn.getcwd()),
  }
}

require'lspconfig'.emmet_ls.setup{
  on_attach = on_attach;
}

lsp.vimls.setup{}
lsp.solargraph.setup{}
lsp.tsserver.setup{}
-- npm install -g vscode-json-languageserver
lsp.jsonls.setup{}
lsp.vuels.setup{
  on_attach = function()
    require("lsp_signature").on_attach()
  end
}
  -- default_config = {
  --   cmd = { 'vls' };
  --   filetypes = {"vue"};
  --   init_options = {
  --     config = {
  --       vetur = {
  --         useWorkspaceDependencies = false;
  --         validation = {
  --           template = true;
  --           style = true;
  --           script = true;
  --         };
  --         completion = {
  --           autoImport = false;
  --           useScaffoldSnippets = false;
  --           tagCasing = "kebab";
  --         };
  --         format = {
  --           defaultFormatter = {
  --             js = "prettier";
  --             ts = "prettier";
  --           };
  --           defaultFormatterOptions = {};
  --           scriptInitialIndent = false;
  --           styleInitialIndent = false;
  --         }
  --       };
  --       css = {};
  --       html = {
  --           suggest = {};
  --       };
  --       javascript = {
  --           format = {};
  --       };
  --       typescript = {
  --           format = {};
  --       };
  --       emmet = {};
  --       stylusSupremacy = {};
  --     };
  --   };
  -- };
  -- settings = {
  --   vetur = {
  --     completion = {
  --       autoImport = true
  --     },
  --     format = {
  --       defaultFormatter =  {
  --         css = "prettier",
  --         html = "prettier",
  --         js = "prettier"
  --       }
  --     },
  --     format = {
  --       enable = true
  --     }
  --   }
  -- }
-- }
lsp.gopls.setup{
  on_attach = function()
    require("lsp_signature").on_attach()
  end
}
-- npm install -g vscode-css-languageserver-bin
lsp.cssls.setup{
}



-- auto put errors to quick fix list
--

local severity_map = { "E", "W", "I", "H" }

local parse_diagnostics = function(diagnostics)
  if not diagnostics then return end
  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local fname = vim.fn.bufname()
    local position = diagnostic.range.start
    local severity = diagnostic.severity
    table.insert(items, {
      filename = fname,
      type = severity_map[severity],
      lnum = position.line + 1,
      col = position.character + 1,
      text = diagnostic.message:gsub("\r", ""):gsub("\n", " ")
    })
  end
  return items
end

-- redefine unwanted callbacks to be an empty function
-- notice that I keep `vim.lsp.util.buf_diagnostics_underline()`
-- vim.lsp.util.buf_diagnostics_signs = function() return end
-- vim.lsp.util.buf_diagnostics_virtual_text = function() return end

update_diagnostics_loclist = function()
  if vim.lsp.diagnostic.get_count(0, [[Error]]) > 0 then
    vim.lsp.diagnostic.set_loclist({open_loclist=false})
  else
    -- vim.cmd [[lclose]]
  end
end

vim.api.nvim_command [[autocmd! User LspDiagnosticsChanged lua update_diagnostics_loclist()]]
