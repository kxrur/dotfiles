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
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
