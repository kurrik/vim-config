-- LSP and mason.nvim configuration
require('mason').setup()

-- Configure language servers
local servers = { 'ts_ls', 'gopls', 'rust_analyzer' }

-- Ensure the servers are installed
require('mason-lspconfig').setup({
  ensure_installed = servers,
})

-- Server specific configurations can be added here, e.g.
-- vim.lsp.config('ts_ls', { settings = { ... } })
vim.lsp.config('ts_ls', {
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
})

-- Enable servers (default configs come from nvim-lspconfig's lsp/ directory)
vim.lsp.enable(servers)
