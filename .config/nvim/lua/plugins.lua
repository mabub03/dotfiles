local packer = require'packer'
packer.startup(function(use)
  -- Add your packages
  use 'tpope/vim-fugitive'
  use 'miyakogi/seiya.vim'
  use 'mattn/emmet-vim'
  use 'dense-analysis/ale'
  use {'prettier/vim-prettier', run = 'npm install'}
  use 'tweekmonster/startuptime.vim'

  -- colorschemes
  use 'joshdick/onedark.vim'
  use 'arcticicestudio/nord-vim'
  use 'marko-cerovac/material.nvim'
  use 'sainnhe/gruvbox-material'
  use 'ayu-theme/ayu-vim'

  use 'kyazdani42/nvim-web-devicons'
  use 'akinsho/nvim-bufferline.lua'
  use 'windwp/nvim-autopairs'
  use 'nvim-lua/completion-nvim'
  use 'hrsh7th/nvim-compe'
  use 'norcalli/snippets.nvim'
  use 'windwp/nvim-ts-autotag'
  use 'kyazdani42/nvim-tree.lua'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- update parcers on update
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/playground'
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  use 'kabouzeid/nvim-lspinstall'
  -- Java lsp install plugin
  -- paq 'mfussenegger/nvim-jdtls'
  -- Discord Rich Presence
  use 'andweeb/presence.nvim'
  use 'hoob3rt/lualine.nvim'
  -- Dap plugins
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  -- use 'theHamsta/nvim-dap-virtual-text'
  -- Telescope plugin
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-dap.nvim'
  -- Dap languages
  use 'mfussenegger/nvim-dap-python'
end)
