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
}
lsp.gopls.setup{}
-- npm install -g vscode-css-languageserver-bin
lsp.cssls.setup{
}
