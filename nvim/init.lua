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

-- <leader>m: open the browser markdown preview (markdown-preview.nvim). The
-- command triggers the plugin's lazy load, so the binding works on first use.
-- Always opens (never toggles): MarkdownPreviewToggle tracks open/closed state
-- in a buffer-local flag that goes stale whenever the preview closes outside
-- the toggle (browser tab closed, auto-close, server exit), which made the
-- first press a silent no-op "stop". With mkdp_combine_preview set below, an
-- already-open preview tab is reused instead of spawning a duplicate.
vim.keymap.set('n', '<leader>m', '<cmd>MarkdownPreview<cr>', { noremap = true, silent = true, desc = 'Open Markdown Preview' })

-- <leader>y: copy the current file's path (relative to cwd) to the clipboard
vim.keymap.set('n', '<leader>y', function()
  local path = vim.fn.expand('%:.')
  if path == '' then
    vim.notify('No file name', vim.log.levels.WARN)
    return
  end
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path)
end, { noremap = true, silent = true, desc = 'Copy Relative File Path' })

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
  -- Live markdown preview in the browser. The build step downloads the
  -- prebuilt preview server, so no Node/yarn toolchain is required. We force
  -- the plugin to load first: lazy.nvim runs `build` before the plugin's
  -- autoload files are sourced, so mkdp#util#install would otherwise raise
  -- E117 (unknown function).
  { "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    init = function()
      -- Reuse a single browser tab: when a preview page is already connected,
      -- the server retargets it (change_bufnr) instead of opening a new tab,
      -- and entering another markdown buffer refreshes that same tab. Keep the
      -- tab alive across buffer switches so there is a tab to reuse. These
      -- globals are read when the plugin file is sourced, so they must be set
      -- here (init runs at startup) rather than after the lazy load.
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_auto_close = 0
    end,
    build = function()
      vim.cmd("Lazy load markdown-preview.nvim")
      vim.fn["mkdp#util#install"]()
    end,
  },
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

