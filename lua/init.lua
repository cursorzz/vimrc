-- require('zac.nvimux')
require('zac.treesitter')
require('zac.lsp')
require('zac.compe')
require('zac.formatter')

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

-- require('base16-colorscheme').setup({
--     base00 = '#16161D', base01 = '#3e4451', base02 = '#2c313c', base03 = '#565c64',
--     base04 = '#6c7891', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
--     base08 = '#e06c75', base09 = '#d19a66', base0A = '#45c07b', base0B = '#98c379',
--     base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
-- })
