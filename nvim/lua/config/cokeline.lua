local colors = require('config.theme').colors

require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  components = {
    {
      text = function(buffer)
        return buffer.is_focused and ' ' or ' '
      end,
      fg = function(buffer)
        return buffer.is_focused and colors.white or colors.darkgray
      end,
      bg = function(buffer)
        return buffer.is_focused and colors.darkgray or colors.gray
      end,
    },
    {
      text = function(buffer)
        local name = buffer.filename
        return ' ' .. name .. ' '
      end,
      style = function(buffer)
        return buffer.is_focused and 'bold' or nil
      end,
      fg = function(buffer)
        return buffer.is_focused and colors.white or colors.darkgray
      end,
      bg = function(buffer)
        return buffer.is_focused and colors.darkgray or colors.gray
      end,
    },
    {
      text = '󰅖',
      on_click = function(_, _, _, _, buffer)
        buffer:delete()
      end,
      fg = function(buffer)
        return buffer.is_focused and colors.white or colors.darkgray
      end,
      bg = function(buffer)
        return buffer.is_focused and colors.darkgray or colors.gray
      end,
    },
    {
      text = ' ',
      bg = function(buffer)
        return buffer.is_focused and colors.darkgray or colors.gray
      end,
    }
  },
})

local map = vim.api.nvim_set_keymap
map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
