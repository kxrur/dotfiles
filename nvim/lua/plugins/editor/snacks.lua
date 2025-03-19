return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    ---@class snacks.terminal.Config
    ---@field win? snacks.win.Config|{}
    ---@field shell? string|string[] The shell to use. Defaults to `vim.o.shell`
    ---@field override? fun(cmd?: string|string[], opts?: snacks.terminal.Opts) Use this to use a different terminal implementation
    terminal = {
      shell = "fish",
      win = {
        position = "float",
      },
    },
    explorer = {
      -- your explorer configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    picker = {
      sources = {
        explorer = {
          -- your explorer picker configuration comes here
          -- or leave it empty to use the default settings
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
          },
        },
      },
    },
  },
}
