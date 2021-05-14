require('zac.nvimux')
require('zac.treesitter')
require('zac.lsp')
require('zac.compe')

require('gitsigns').setup()
require('colorizer').setup()
require'lsp_signature'.on_attach()
require('lualine').setup({
  options = {theme = 'gruvbox'}
})
