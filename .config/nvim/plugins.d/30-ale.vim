Plug 'dense-analysis/ale'

" To use eslint you need to do the command:
" npm i -g eslint

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_linters_explicit=1
let g:ale_fixers = {
    \ 'javascript': ['prettier', 'eslint'],
    \ 'html': ['prettier'],
    \ 'css': ['prettier'],
    \ 'json': ['prettier'],
    \ 'php' : ['prettier'],
    \ 'xml': ['prettier'],
\}

let g:ale_fix_on_save = 1
