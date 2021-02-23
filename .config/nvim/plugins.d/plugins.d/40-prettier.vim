Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'css', 'json', 'html']}

let g:prettier#autoformat = 1
let g:prettier#config#html_whitespace_sensitivity = 'css'
let g:prettier#config#use_tabs = 'false'

nnoremap gp :silent %!prettier -stdin-filepath %<CR>
