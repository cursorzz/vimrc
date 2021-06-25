require('zac.nvimux')
require('zac.treesitter')
require('zac.lsp')
require('zac.compe')

require('gitsigns').setup()
require('colorizer').setup()
-- require'lsp_signature'.on_attach()

require('lualine').setup {
 options = {section_separators = '', component_separators = '', theme = 'wombat'};
 sections = {
   lualine_c = {
    {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }
  }
 }
}

require'nvim-treesitter.configs'.setup {
  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart',
    }
  },
}

-- lua auto pair plugin
-- require "pears".setup()

require('zac.nvimux')
require('zac.lsp')

require'lsp_signature'.on_attach()

-- require('lualine').setup{
-- options = {section_separators = '', component_separators = ''}
-- }

