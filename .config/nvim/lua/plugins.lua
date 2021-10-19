local packer = require'packer'
packer.startup(function(use)
  -- Add your packages
  --use 'tpope/vim-fugitive'
  use 'miyakogi/seiya.vim'
  --use 'mattn/emmet-vim'
  use 'dense-analysis/ale'
  use {'prettier/vim-prettier', run = 'npm install'}
  use 'tweekmonster/startuptime.vim'

  -- colorschemes
  use 'joshdick/onedark.vim'
  use 'arcticicestudio/nord-vim'
  use 'marko-cerovac/material.nvim'
  use 'sainnhe/gruvbox-material'
  use 'ayu-theme/ayu-vim'

  use 'akinsho/nvim-bufferline.lua'

  use {
    'L3MON4D3/LuaSnip',
    requires = 'rafamadriz/friendly-snippets'
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      --"hrsh7th/vim-vsnip",
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      --'kristijanhusak/vim-dadbod-completion',
      --'tpope/vim-dadbod',
      'windwp/nvim-ts-autotag'
    }
  }
  use {
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/playground',
      'windwp/nvim-autopairs'
    },
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  -- Java lsp install plugin
  -- paq 'mfussenegger/nvim-jdtls'
  -- Discord Rich Presence
  use 'andweeb/presence.nvim'
  use 'hoob3rt/lualine.nvim'
  -- Dap plugins
  use {
    'mfussenegger/nvim-dap',
    requires = {
     'theHamsta/nvim-dap-virtual-text',
     'mfussenegger/nvim-dap-python'
    }
  }
  -- Telescope plugin
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'nvim-telescope/telescope-dap.nvim'
    }
  }

  use 'glepnir/dashboard-nvim'
end)
