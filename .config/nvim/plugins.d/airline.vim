let g:airline_powerline_fonts = 1
"let g:airline_theme = 'gruvbox_material'
let g:airline_theme = 'material'
" let g:airline_section_c = '%F' "show full filepath instead of just the file

" Tabline
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

" Tmux Airline Config (tmuxline.vim extension)
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline.conf"

" Bash/Zsh Airline Config (promptline.vim extension)
let airline#extensions#promptline#enabled = 1
let airline#extensions#promptline#snapshot_file = "~/.shell-prompt.sh"

