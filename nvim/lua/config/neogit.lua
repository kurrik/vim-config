-- Neogit configuration (Magit-style Git interface)
require('neogit').setup({})

-- <leader>g: open the Neogit status buffer
vim.keymap.set('n', '<leader>g', function()
  require('neogit').open()
end, { noremap = true, silent = true, desc = 'Open Neogit' })
