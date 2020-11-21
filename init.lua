local lsp = require'nvim_lsp'

local function mapper(mode, key, result)
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end


local attach_mapping = function ()
  print("lsp attached " .. vim.api.nvim_buf_get_option(0, 'filetype'))
  mapper("n", "K", '<cmd>lua vim.lsp.buf.hover()<CR>')
end


local on_attach = function(client)
  -- require'lsp_status'.on_attach(client)
  -- require'diagnostic'.on_attach()
  attach_mapping()
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
  -- require'completion'.on_attach({
  --     sorter = 'alphabet',
  --     matcher = {'exact', 'fuzzy'}
  --   })
end


lsp.vimls.setup{
  on_attach=on_attach
}


lsp.solargraph.setup{on_attach=on_attach}

lsp.tsserver.setup{
  on_attach=require'completion'.on_attach
}
lsp.gopls.setup{
  on_attach=on_attach
}

lsp.sumneko_lua.setup{
  on_attach=on_attach,
--  cmd = { "~/.cache/nvim/nvim_lsp/sumneko_lua/bin/macOS/lua-language-server", "-E", "~/.cache/nvim/nvim_lsp/sumneko_lua/main.lua" }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
-- require'telescope.builtin'.planets{}
