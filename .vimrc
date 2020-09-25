" No vi compatibility
set nocompatible

" If vim-plug isn't detected it gets automatically installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =========================================================================== "
"                                   Plugins
" =========================================================================== "
" set the runtime path to include vim-plug and initialize
set rtp+=~/.vim/autoload/plug.vim
call plug#begin('~/.vim/plugged')
" code completion
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Coc Extensions To Install
" coc-html, coc-css, coc-sql, coc-tsserver, coc-xml, coc-python, coc-clangd
" coc-json, coc-emmet, coc-sh
" tree file system explorer
Plug 'scrooloose/nerdtree' "file explorer for vim
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'

" statusline plugins
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'edkolev/promptline.vim'

" colorschemes
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'kaicataldo/material.vim'
Plug 'sainnhe/gruvbox-material'
call plug#end()

" =========================================================================== "
"                               General Settings                              "
" =========================================================================== "
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Unprintable char mapping
set listchars=tab:>>,trail:.,precedes:<,extends:>,eol:$
set nobackup
set laststatus=2

set modelines=0

" sets word wrap
set wrap
set textwidth=80 " stops can type up to column 80

set tabstop=8
set shiftwidth=2
set softtabstop=2
set expandtab

set scrolloff=5 " keep at least 5 lines above/below
set sidescrolloff=5 " keep at least 5 line left/right

" makes backspace work like any other text editor
set backspace=indent,eol,start

set noshowmode
set showcmd

set number

set encoding=utf-8

set viminfo='100,<9999,s100

" =========================================================================== "
"                               Plugin Settings
" =========================================================================== "
"NERDTree config
let NERDTreeShowHidden=1 "Shows Hidden Files

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline_theme = 'material'
" let g:airline_theme = 'gruvbox_material'
" let g:airline_section_c = '%F' "show full filepath instead of just the file

" Airline Tabline
" enable airline tabline
let g:airline#extensions#tabline#enabled = 1
" remove 'X' a the end of the tabline
let g:airline#extensions#tabline#show_close_button = 0
" can put text here like TABS to denote tabs
let g:airline#extensions#tabline#tabs_label = ''
" can put text here like BUFFERS to denote buffers
let g:airline#extensions#tabline#buffers_label = ''
" disable file path in the tab
let g:airline#extensions#tabline#fnamemod = ':t'
" don't show tab numbers on the right
let g:airline#extensions#tabline#show_tab_count = 0
" don't show buffers in the tabline
let g:airline#extensions#tabline#show_buffers = 0
" disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_splits = 0
" disable tab numbers
let g:airline#extensions#tabline#show_tab_nr = 0
" minimum of 2 tabs to display the tabline
let g:airline#extensions#tabline#tab_min_count = 2
" disables the wird orange arrow on the tabline
let g:airline#extensions#tabline#show_tab_type = 0

" Airline Git Branch
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

" Tmux Airline Config
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline.conf"

" Bash Airline Config
let airline#extensions#promptline#enabled = 1
let airline#extensions#promptline#snapshot_file = "~/.shell-prompt.sh"
" =========================================================================== "
"                               Key Mappings
" =========================================================================== "
" NERDTree toggles on with <ctrl> + <o>
nnoremap <C-o> :NERDTreeToggle<CR>

" set or disable list (uprintable characters)
nnoremap <F12> :set list!<CR>

"nnoremap <C-PageUp>:tabnext<CR>
"nnoremap <C-PageDown>:tabprev<CR>
" copy and paste button mappings
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe' "change this path according to your mount point.
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
  augroup END
endif

" =========================================================================== "
"                   Color Scheme & Color Scheme Settings
" =========================================================================== "
" kaicataldo material config
let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'

" gruvbox-material config
let g:gruvbox_material_enable_italic = 1
" let g:gruvbox_material_disable_italic_comment = 1

" set background color to dark
set background=dark
" set colorscheme
" colorscheme gruvbox-material
colorscheme material
