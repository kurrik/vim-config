vim.g.mapleader = " "

-- Neovim/Vim config entry point
-- Loads settings, plugins, and theme based on user preference

local is_nvim = vim.fn.has("nvim") == 1
local is_vim = not is_nvim

-- Theme selection (edit these variables to swap themes or background)
local theme = "gruvbox" -- options: "catppuccin", "gruvbox"
local theme_background = "light" -- options: "dark", "light" (only applies to gruvbox)

-- Shared settings (applies to both Vim and Neovim)
vim.opt.number = true

-- Map <Esc> in terminal mode to exit to normal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.fileformats = {"unix"}
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.spell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.autoread = true
vim.opt.timeoutlen = 400
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.scrolloff = 4

-- Only load plugins if running in Neovim
if is_nvim then
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
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
  })

  -- Theme setup
  if theme == "catppuccin" then
    vim.opt.background = "dark" -- catppuccin is dark only
    vim.cmd.colorscheme("catppuccin")
  elseif theme == "gruvbox" then
    vim.opt.background = theme_background -- set to "dark" or "light"
    vim.cmd.colorscheme("gruvbox")
  end

  -- Plugin configurations
  require("config.lualine")
  require("config.cokeline")
  require("config.neotree")
  require("config.telescope")
  require("config.lsp")
end

-- Vim fallback: no plugin loading, but settings apply
