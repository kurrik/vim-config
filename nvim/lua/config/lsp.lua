-- LSP and mason.nvim configuration
require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

-- Configure language servers
local servers = { 'ts_ls', 'gopls', 'rust_analyzer' }

-- Ensure the servers are installed
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Setup installed servers
for _, server in ipairs(servers) do
  local config = {
    on_attach = function(client, bufnr)
      -- Common on_attach configuration can go here
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }
  
  -- Server specific configurations can be added here
  if server == 'tsserver' then
    config.root_dir = lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')
  end
  
  lspconfig[server].setup(config)
end
