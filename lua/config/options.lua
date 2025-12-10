-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.termguicolors = false
vim.o.background = "dark"
vim.g.loaded_matchparen = 1
opt.shell = "nu"
opt.shelltemp = false
opt.shellredir = "out+err>%s"
opt.shellcmdflag = "--stdin --no-newline -c"

-- disable all escaping and quoting
opt.shellxescape = ""
opt.shellxquote = ""
opt.shellquote = ""
