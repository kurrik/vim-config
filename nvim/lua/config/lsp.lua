-- LSP and mason.nvim configuration
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'ts_ls', 'gopls', 'rust_analyzer' },
}

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
}
