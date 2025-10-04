require('conform').setup({
  formatters_by_ft = {
    javascript = {'prettierd'},
    typescript = {'prettierd'},
    typescriptreact = {'prettierd'},
    javascriptreact = {'prettierd'},
    css = {'prettierd'},
    scss = {'prettierd'},
    html = {'prettierd'},
    json = {'prettierd'},
    lua = {'stylua'},
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  }
})

