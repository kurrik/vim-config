-- Theme utility for config
local M = {}

function M.get_lualine_theme()
  local theme = vim.g.colors_name or 'catppuccin'
  if theme == 'gruvbox' then
    return 'gruvbox'
  else
    return 'catppuccin'
  end
end

return M
