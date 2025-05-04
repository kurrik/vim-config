-- Theme utility for config
local M = {}

-- These match gruvbox light in https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/gruvbox_light.lua
M.colors = {
  darkgray = '#7c6f64',
  gray = '#d5c4a1',
  white = '#f9f5d7',
}

function M.get_lualine_theme()
  local theme = vim.g.colors_name or 'catppuccin'
  if theme == 'gruvbox' then
    return 'gruvbox'
  else
    return 'catppuccin'
  end
end

return M
