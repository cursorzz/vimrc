local usePrettier = function()
  -- --single-quote'
  -- --trailing-comma none'
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {usePrettier},
      vue = {usePrettier},
      css = {usePrettier},
      scss = {usePrettier},
      typescript = {usePrettier},
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.vue,*.lua FormatWrite
augroup END
]],
  true
)
