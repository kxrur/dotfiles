return {
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    opts = {
      glow = true,
      theme = "delta", -- fluoromachine, retrowave, delta
    },
  },
  {
    "LunarVim/horizon.nvim",
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  { "catppuccin/nvim", name = "catppuccin" },
  { "olimorris/onedarkpro.nvim" },
  { "savq/melange-nvim" },
  {
    "ribru17/bamboo.nvim",
    opts = {
      style = "vulgaris",
    },
    -- FIXME: changing color doesn't work
    colors = {
      normal_bg = "#a2b382",
      green = "#00ffaa", -- redefine an existing color
    },
    highlights = {
      ["@Normal"] = { bg = "$normal_bg" },
      ["@keyword"] = { fg = "$green" },
    },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "bamboo",
    },
  },
}
