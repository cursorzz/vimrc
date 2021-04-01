
-- vim.lsp.set_log_level("debug")

local function mapper(mode, key, result)
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local attach_mapping = function ()
  print("lsp attached " .. vim.api.nvim_buf_get_option(0, 'filetype'))
  -- mapper("n", "K", '<cmd>lua vim.lsp.buf.hover()<CR>')
end


local on_attach = function(client)
  print(client)
  -- require'lsp_status'.on_attach(client)
  -- require'diagnostic'.on_attach()
  attach_mapping()
  -- require'completion'.on_attach({
  --     sorter = 'alphabet',
  --     matcher = {'exact', 'fuzzy'}
  --   })
end



-- lsp.sumneko_lua.setup{
--   on_attach=on_attach,
-- --  cmd = { "~/.cache/nvim/nvim_lsp/sumneko_lua/bin/macOS/lua-language-server", "-E", "~/.cache/nvim/nvim_lsp/sumneko_lua/main.lua" }
-- }

require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
-- require'telescope.builtin'.planets{}
--

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    spell = false;
    calc = false;
    nvim_lsp = true;
    nvim_lua = false;
    vsnip = false;
  };

}

require('gitsigns').setup()

require('colorizer').setup()

require('zac.nvimux')
require('zac.lsp')

-- require('nvim-biscuits').setup({})
