-- Neovim configuration entry point

-- Neovim-specific settings
vim.g.mapleader = " "

-- Load shared settings (Vimscript)
vim.cmd('source ~/workspace/vim-config/shared/basic.vim')

-- Theme selection (edit these variables to swap themes or background)
local theme = "gruvbox" -- options: "catppuccin", "gruvbox"
local theme_background = "light" -- options: "dark", "light" (only applies to gruvbox)

-- :Spterminal - split window and open terminal in bottom split
vim.api.nvim_create_user_command('Spterminal', function()
  vim.cmd('split')
  vim.cmd('wincmd j')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, {})

-- <leader>t: If in terminal buffer, close it; otherwise, open split terminal
local function toggle_spterminal()
  local buftype = vim.api.nvim_get_option_value('buftype', {buf=0})
  if buftype == 'terminal' then
    vim.cmd('bdelete!')
  else
    vim.cmd('Spterminal')
  end
end

vim.keymap.set('n', '<leader>t', toggle_spterminal, { noremap = true, silent = true, desc = 'Toggle Split Terminal' })

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Themes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "morhetz/gruvbox", name = "gruvbox", priority = 1000 },
  -- Plugins
  { "nvim-neo-tree/neo-tree.nvim", dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  },
  { "willothy/nvim-cokeline", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "nvim-telescope/telescope.nvim", dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native C sorter: keeps fuzzy filtering instant even on huge file lists
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    }
  },
  { "NeogitOrg/neogit", dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- picker integration
    }
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
})

-- Enable 24-bit color. Required for catppuccin and for gruvbox to render in
-- true color instead of the degraded 256-color approximation. It also lets
-- Neovim drive the terminal cursor color from the Cursor highlight group (see
-- the cursor fix below), which only works with termguicolors on.
vim.opt.termguicolors = true

-- Theme setup
if theme == "catppuccin" then
  vim.opt.background = "dark" -- catppuccin is dark only
  vim.cmd.colorscheme("catppuccin")
elseif theme == "gruvbox" then
  vim.opt.background = theme_background -- set to "dark" or "light"
  vim.cmd.colorscheme("gruvbox")
end

-- gruvbox's default Cursor is reverse video, which renders as a near-invisible
-- pale block on the light background -- made worse when the terminal itself
-- uses a dark theme (its light cursor bleeds through nvim's light background).
-- Fix in two parts:
--   1. Set the Cursor highlight to an explicit high-contrast color per
--      background (dark block on light bg, light block on dark bg).
--   2. Push that color to the terminal with an OSC 12 escape. Neovim only emits
--      this automatically when the terminfo advertises the capability (many
--      $TERM values, e.g. xterm-256color, do not), so send it explicitly. OSC
--      112 on exit restores the terminal's own cursor so the shell keeps it.
local function gruvbox_cursor_color()
  if vim.o.background == "light" then
    return { block = "#3c3836", glyph = "#fbf1c7" }
  else
    return { block = "#ebdbb2", glyph = "#282828" }
  end
end
local function fix_gruvbox_cursor()
  if vim.g.colors_name ~= "gruvbox" then return end
  local c = gruvbox_cursor_color()
  vim.api.nvim_set_hl(0, "Cursor", { fg = c.glyph, bg = c.block })
  io.write("\027]12;" .. c.block .. "\007")
end
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = fix_gruvbox_cursor })
vim.api.nvim_create_autocmd("VimLeave", { callback = function()
  io.write("\027]112\007")
end })
fix_gruvbox_cursor()

-- Plugin configurations
require("config.lualine")
require("config.cokeline")
require("config.neotree")
require("config.telescope")
require("config.neogit")
require("config.lsp")

