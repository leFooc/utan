require('mason').setup()

require('mason-lspconfig').setup {
  ensure_installed = {
    'ts_ls',
    'gopls',
    'jdtls',
    'yamlls',
  }
}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.ts_ls.setup({
  capabilities = capabilities,
})
lspconfig.gopls.setup({})
lspconfig.jdtls.setup({})

lspconfig.yamlls.setup({
  capabilities = capabilities,
  settings = {
    yaml = {
      -- Kubernetes core resources
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/blob/master/v1.29.1-standalone-strict/all.json"] = {
          "deployment.{yml,yaml}",
          "service.{yml,yaml}",
          "statefulset.{yml,yaml}",
          "configmap.{yml,yaml}",
          "secret.{yml,yaml}",
          "ingress.{yml,yaml}",
          "persistentvolumeclaim.{yml,yaml}",
          "job.{yml,yaml}",
          "cronjob.{yml,yaml}",
          "namespace.{yml,yaml}",
          "role.{yml,yaml}",
          "rolebinding.{yml,yaml}",
          "clusterrole.{yml,yaml}",
          "clusterrolebinding.{yml,yaml}",
        },

        -- GitHub actions
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",

        -- Kustomize
        ["https://json.schemastore.org/kustomization.json"] = {
          "kustomization.{yml,yaml}",
          "k8s-*.{yml,yaml}",
          "k8s/*.{yml,yaml}",
        },

        -- Helm
        ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/helm-values.json"] = "values.{yml,yaml}",

        -- Docker Compose
        ["https://json.schemastore.org/docker-compose.json"] = "docker-compose.{yml,yaml}",

        -- Linters/configs
        ["https://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
        ["https://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
        ["https://json.schemastore.org/eslintrc.json"] = ".eslintrc.{yml,yaml}",

        -- Ansible
        ["https://json.schemastore.org/ansible-stable-2.9.json"] = {
          "inventory/*.{yml,yaml}",
          "roles/tasks/*.{yml,yaml}",
          "roles/handlers/*.{yml,yaml}",
          "playbooks/*.{yml,yaml}",
          "playbook.{yml,yaml}",
        },
    },
  },
})

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  }
})


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local opts = { buffer = args.bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
  desc = "TS_add_missing_imports",
  pattern = { "*.ts", ".tsx", ".js" },
  callback = function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.addMissingImports.ts" },
      },
    })
    vim.cmd("write")
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})



