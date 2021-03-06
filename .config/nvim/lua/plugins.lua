-- if doesn't work move $HOME/.local/share/nvim/site/pack/paqs/opt/paq-vim (just cp -r pack or mv pack)
-- packages get installed to $HOME/.local/nvim/site/pack/paqs/start
vim.cmd('packadd paq-nvim')         -- Load package
local paq = require'paq-nvim'.paq  -- Import module and bind `paq` function
paq{'savq/paq-nvim', opt=true}     -- Let Paq manage itself

-- Add your packages
paq 'tpope/vim-fugitive'
paq 'miyakogi/seiya.vim'
-- paq 'sheerun/vim-polyglot'
paq 'mattn/emmet-vim'
paq 'dense-analysis/ale'
paq {'prettier/vim-prettier', run = 'npm install'}
paq 'tweekmonster/startuptime.vim'
-- Plug 'edkolev/tmuxline.vim'
-- Plug 'edkolev/promptline.vim'

-- colorschemes
paq'joshdick/onedark.vim'
paq 'arcticicestudio/nord-vim'
--paq 'kaicataldo/material.vim'
paq 'marko-cerovac/material.nvim'
--paq 'hzchirs/vim-material'
paq 'sainnhe/gruvbox-material'
--paq 'tjdevries/colorbuddy.nvim'
paq 'ayu-theme/ayu-vim'

-- lua neovim only plugins
paq 'kyazdani42/nvim-web-devicons'
paq 'akinsho/nvim-bufferline.lua'
-- paq 'romgrk/barbar.nvim'
paq 'windwp/nvim-autopairs'
--paq {'glepnir/galaxyline.nvim', branch = 'main'}
paq 'nvim-lua/completion-nvim'
paq 'hrsh7th/nvim-compe'
paq 'norcalli/snippets.nvim'
--paq 'norcalli/nvim-colorizer.lua'
paq 'windwp/nvim-ts-autotag'
paq 'kyazdani42/nvim-tree.lua'
-- Neovim official feature plugins
paq {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- update parcers on update
paq 'neovim/nvim-lspconfig'
paq 'nvim-treesitter/playground'
-- Neovim LSP
paq 'onsails/lspkind-nvim'
paq 'glepnir/lspsaga.nvim'
paq 'kabouzeid/nvim-lspinstall'
-- Java lsp install plugin
-- paq 'mfussenegger/nvim-jdtls'
-- Discord Rich Presence
paq 'andweeb/presence.nvim'
paq 'hoob3rt/lualine.nvim'
