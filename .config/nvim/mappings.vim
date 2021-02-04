" NERDTree toggles on with <ctrl> + <o>
nnoremap <C-o> :NERDTreeToggle<CR>

" set or disable list (uprintable characters)
nnoremap <F12> :set list!<CR>

map <C-K> :pyf /usr/bin/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/vim/addons/syntax/clang-format.py<cr> 
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

