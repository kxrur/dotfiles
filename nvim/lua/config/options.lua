-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
opt.scrolloff = 15 -- Lines of context
opt.textwidth = 80
opt.numberwidth = 1
opt.spelllang = { "en" }
opt.spell = true
opt.signcolumn = "yes"
opt.sidescrolloff = 4

vim.g.vimtex_view_method = "zathura"

opt.shell = "fish"

-- notify

local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg == banned then
      return
    end
  end
  return require("notify")(msg, ...)
end
