-- Neogit configuration (Magit-style Git interface)

-- Neogit auto-derives its diff colors by reading the *background* of the
-- editor's `DiffAdd`/`DiffDelete` groups. morhetz/gruvbox defines those groups
-- with reverse/inverse video, so Neogit reads the inverted *foreground* (a
-- saturated green/red) and uses it as the diff line background. The added-line
-- text ends up the same color as its background -- an unreadable solid block.
--
-- Fix: hand Neogit an explicit diff palette so it skips the broken derivation.
-- Scoped to gruvbox; catppuccin ships its own Neogit integration.
local opts = {}
if vim.g.colors_name == "gruvbox" then
  if vim.o.background == "dark" then
    opts.highlight = {
      green = "#b8bb26", bg_green = "#b8bb26", line_green = "#3d4220", inline_green = "#98971a",
      red = "#fb4934", bg_red = "#fb4934", line_red = "#4c1e1e", inline_red = "#cc241d",
    }
  else
    opts.highlight = {
      green = "#79740e", bg_green = "#79740e", line_green = "#d5d6a0", inline_green = "#79740e",
      red = "#9d0006", bg_red = "#9d0006", line_red = "#f1c0b3", inline_red = "#9d0006",
    }
  end
end

require('neogit').setup(opts)

-- <leader>g: open the Neogit status buffer
vim.keymap.set('n', '<leader>g', function()
  require('neogit').open()
end, { noremap = true, silent = true, desc = 'Open Neogit' })
