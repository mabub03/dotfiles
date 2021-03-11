"if !exists("g:os")
"  if has("win64") || has("win32") || has("win16")
"    let g:os =  "Windows"
"  else
"    let g:os = substitute(system('uname'), '\n', '', '')
"  endif
"endif

if g:os == "Windows"
  " If vim-plug isn't detected it gets automatically installed
  " if used scoop then can ~/scoop/apps/neovim/
  if empty(glob('~/AppData/local/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/AppData/local/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  
  " set the runtime path to include vim-plug and initialize
  set rtp+=~/.config/nvim/autoload/plug.vim
  call plug#begin('~/AppData/local/nvim/plugged')
endif

if g:os == "Linux"
  " If vim-plug isn't detected it gets automatically installed
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  
  " set the runtime path to include vim-plug and initialize
  set rtp+=~/.config/nvim/autoload/plug.vim
  call plug#begin('~/.config/nvim/plugged')
endif

if g:os == "Darwin"
  " Mac stuff
endif

" if choose to use make a file for itself and the coc extensions
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" misc
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'anned20/vimsence'
Plug 'ryanoasis/vim-devicons'
Plug 'mattn/emmet-vim'

" colorschemes
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'kaicataldo/material.vim'
Plug 'hzchirs/vim-material'
Plug 'sainnhe/gruvbox-material'
Plug 'ayu-theme/ayu-vim'
" Neovim Feauture Plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " update parcers on update
Plug 'nvim-treesitter/playground'

" Plugins that are neater in their own file
for f in split(glob('~/.config/nvim/plugins.d/*.vim'), '\n')
  exe 'source' f
endfor

"call plug#end()
