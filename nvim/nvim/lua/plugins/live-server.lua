return {
  "barrett-ruth/live-server.nvim",
  build = "npm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = true,
  keys = {
    { "<leader>cp", "<cmd>LiveServerStart<cr>", desc = "Start live server" },
  },
}
