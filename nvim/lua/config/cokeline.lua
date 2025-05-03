-- nvim-cokeline minimal, working configuration
require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  components = {
    {
      text = function(buffer) return ' ' .. buffer.index end,
    },
    {
      text = function(buffer) return ' ' .. buffer.filename .. ' ' end,
    },
    {
      text = '󰅖',
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end
    },
    {
      text = ' ',
    }
  },
})

local map = vim.api.nvim_set_keymap
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
