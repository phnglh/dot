-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local g = vim.g

opt.number = true
opt.softtabstop = 2
opt.tabstop = 4
opt.shiftwidth = 2
opt.expandtab = true
opt.completeopt = { "menuone", "longest", "noselect" }
opt.clipboard = "unnamedplus"
opt.wildmode = { "longest", "list", "full" }
opt.wildmenu = true
opt.sh = "zsh"
opt.cursorline = true
opt.termguicolors = true
opt.list = true
opt.guifont = "JetBrainsMono Nerd Font Mono:h24"
opt.showbreak = "↪ "
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  nbsp = "␣",
  trail = "•",
  extends = "⟩",
  precedes = "⟨",
}

opt.foldmethod = "indent"
opt.foldnestmax = 10
opt.foldenable = false
opt.autoread = true
opt.showtabline = 2

opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.tmp/nvim/undo", nil, nil)
opt.undolevels = 1000
opt.undoreload = 10000
opt.ttimeout = true
opt.ttimeoutlen = 0
opt.inccommand = "nosplit"
opt.mouse = "a"
if g.catppuccin_flavour == nil then
  g.catppuccin_flavour = "frappe"
end

g.mapleader = " "
