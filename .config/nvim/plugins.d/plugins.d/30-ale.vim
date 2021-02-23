Plug 'w0rp/ale'

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_fixers = {
    \ 'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1