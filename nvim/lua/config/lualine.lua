-- lualine.nvim configuration
require('lualine').setup {
  options = {
    theme = require('config.theme').get_lualine_theme(),
    section_separators = '',
    component_separators = '',
    icons_enabled = true
  }
}
