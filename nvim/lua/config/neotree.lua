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

-- Global keymap to reveal the current file in Neo-tree with <leader>E
vim.keymap.set('n', '<leader>E', function()
  vim.cmd('Neotree reveal')
end, { desc = 'Reveal current file in Neo-tree' })

-- Auto-quit Neovim if Neo-tree is the last window
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('NeoTreeAutoQuit', { clear = true }),
  nested = true,
  callback = function()
    -- Only one window left, and it's Neo-tree
    if #vim.api.nvim_list_wins() == 1 then
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname:match('neo%-tree') or vim.bo.filetype == 'neo-tree' then
        -- `quit` here exits Neovim, which fails with E37 if another buffer
        -- still has unsaved changes. Don't let that error escape the BufEnter
        -- callback -- just stay in Neo-tree so the user can go save the buffer.
        pcall(vim.cmd, 'quit')
      end
    end
  end,
})
