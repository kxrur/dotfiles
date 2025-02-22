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
  },
}
