return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        treesitter = true,
        native_lsp = {
          enabled = true,
        },
      },
      custom_highlights = function(colors)
        return {
          Normal = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          EndOfBuffer = { bg = "NONE" },
          StatusLine = { bg = "NONE" },
          StatusLineNC = { bg = "NONE" },
          LineNr = { bg = "NONE" },
          CursorLineNr = { fg = colors.lavender, style = { "bold" } },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
}
