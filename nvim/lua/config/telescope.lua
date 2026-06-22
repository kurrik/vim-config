-- Telescope configuration
local telescope = require('telescope')

telescope.setup{
  defaults = {
    -- Exclude heavy/uninteresting dirs from results (defense-in-depth: fd/rg
    -- already honor .gitignore, but this covers repos that commit these).
    file_ignore_patterns = { "node_modules", "%.git/" },
  },
  pickers = {
    find_files = {
      -- Prefer fd: fast and respects .gitignore (avoids enumerating
      -- node_modules etc.). Falls back to telescope's default if fd is absent.
      find_command = vim.fn.executable('fd') == 1
        and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
        or nil,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

-- Load the native C sorter so filtering stays instant on large lists.
pcall(telescope.load_extension, 'fzf')

-- Keymap for VSCode-like quick file open
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Find Files (Telescope)' })
