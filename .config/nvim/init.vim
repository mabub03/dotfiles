"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath=&runtimepath
"source ~/.vimrc

if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os =  "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

if g:os == "Linux"
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/general.vim
  source $HOME/.config/nvim/mappings.vim
  source $HOME/.config/nvim/colorschemes.vim
endif

if g:os == "Windows"
  source ~/AppData/local/nvim/plugins.vim
  source ~/AppData/local/nvim/general.vim
  source ~/AppData/local/nvim/mappings.vim
  source ~/AppData/local/nvim/colorschemes.vim
endif

" for functions add a functions.vim file
" for autocommands add a autocmd.vim file
" source $HOME/.config/nvim/after/ftplugin   " for ftplugins (filetype plugins)
