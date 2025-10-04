require('lint').linters_by_ft = {
  javascript = {'eslint'},
  typescript = {'eslint'},
  typescriptreact = {'eslint'},
  javascriptreact = {'eslint'},
  css = {'stylelint'},
  scss = {'stylelint'},
  html = {'htmlhint'},
  json = {'jsonlint'},
  lua = {'luacheck'}
}

vim.api.nvim_create_autocmd({"BufWritePre", "BufWritePost"}, {
  callback = function()
    require("lint").try_lint()
  end,
})

