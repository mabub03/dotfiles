--[[if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif]]
vim.cmd('filetype plugin indent on')
vim.o.termguicolors = true
-- Unprintable char mapping
vim.cmd('set listchars=tab:>>,trail:.,precedes:<,extends:>,eol:$')
vim.o.backup = false
vim.o.laststatus=2
vim.g.modelines=0
vim.o.mouse="a" -- enable mouse
-- reset the leader from \ to a different key
vim.cmd('let mapleader=";"')
vim.cmd('set shortmess+=c')
-- sets word wrap
vim.wo.wrap = true
vim.bo.textwidth = 80 -- stops can type up to column 80
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.scrolloff = 5 -- keep at least 5 lines above/below
vim.o.sidescrolloff=5 -- keep at least 5 line left/right
-- makes backspace work like any other text editor
vim.o.showmode = false
-- set silent %s/x/y/g
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.encoding = 'utf-8'

