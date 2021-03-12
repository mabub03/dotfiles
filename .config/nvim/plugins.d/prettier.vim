let g:prettier#autoformat = 1
let g:prettier#config#html_whitespace_sensitivity = 'css'
let g:prettier#config#use_tabs = 'false'
let g:prettier#autoformat_require_pragma = 0
nnoremap gp :silent %!prettier --stdin-filepath %<CR>
