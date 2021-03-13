" auto download vim-plug if not installed already
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
  
" set the runtime path to include vim-plug and initialize
set rtp+=~/.config/nvim/autoload/plug.vim
call plug#begin('~/.config/nvim/plugged')

" if choose to use make a file for itself and the coc extensions
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" misc
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'anned20/vimsence'
Plug 'ryanoasis/vim-devicons'
Plug 'mattn/emmet-vim'
Plug 'nvim-lua/completion-nvim'
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'hrsh7th/nvim-compe'
"Plug 'norcalli/snippets.nvim'
Plug 'windwp/nvim-ts-autotag'
Plug 'honza/vim-snippets'

" Status Line Plugins
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'
" colorschemes
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'kaicataldo/material.vim'
Plug 'hzchirs/vim-material'
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'

" Neovim Feauture Plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " update parcers on update
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/playground'
call plug#end()
