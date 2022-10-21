require("mason").setup()
local installed = require('mason-lspconfig').get_installed_servers()
for i in pairs(installed) do 
  require("lspconfig")[installed[i]].setup{}
end
-- require("mason-lspconfig").setup_handlers({
--   []
-- })


-- require('lspconfig')['lua-language-server'].setup{}

