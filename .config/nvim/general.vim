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

