-- Neo-tree configuration
require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
})

-- Global keymap to toggle Neo-tree with <leader>e
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('Neotree toggle')
end, { desc = 'Toggle Neo-tree file browser' })
