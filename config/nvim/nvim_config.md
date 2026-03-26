-- ~/.config/nvim/lua/plugins/example.lua

-- customizations to the statusbar colors
local customgruvbox = require("lualine.themes.gruvbox")
customgruvbox.normal.a.bg = "#ff9800"
customgruvbox.normal.c.bg = "#000000"
customgruvbox.normal.c.fg = "#ffffff"
customgruvbox.insert.c.bg = "#000000"
customgruvbox.insert.c.fg = "#ffffff"
customgruvbox.visual.c.bg = "#000000"
customgruvbox.visual.c.fg = "#ffffff"
customgruvbox.replace.c.bg = "#000000"
customgruvbox.replace.c.fg = "#ffffff"
customgruvbox.command.c.bg = "#000000"
customgruvbox.command.c.fg = "#ffffff"
customgruvbox.inactive.c.bg = "#000000"
customgruvbox.inactive.c.fg = "#ffffff"

return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true, -- important for background of nvim to be transparent for blur
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Make the statusbar (called lualine) use my customgruvbox theme
  {
    "nvim-lualine/lualine.nvim",
    options = { theme = "customgruvbox" },
  },
}
