-- Telescope configuration
local telescope = require('telescope')
telescope.setup{}

-- Keymap for VSCode-like quick file open
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Find Files (Telescope)' })
