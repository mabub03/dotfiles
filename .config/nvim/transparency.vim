" Transparancy set with plugin seiya
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
let g:seiya_auto_enable=1
"set termguicolors
"let t:is_transparent = 0
"function! Toggle_transparent()
"    if t:is_transparent == 0
"        hi Normal guibg=NONE ctermbg=NONE
"        let t:is_transparent = 1
"    else
"        set background=dark
"        let t:is_tranparent = 0
"    endif
"endfunction
"nnoremap <C-t> :call Toggle_transparent()<CR>
"hi Normal guibg=NONE ctermbg=NONE

