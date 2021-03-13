if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os =  "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

if g:os == "Linux"
  if exists('g:vscode')
    source $HOME/.config/nvim/general.vim
    source $HOME/.config/nvim/mappings.vim
  else
    source $HOME/.config/nvim/plugins.vim
    source $HOME/.config/nvim/general.vim
    source $HOME/.config/nvim/mappings.vim
    source $HOME/.config/nvim/colorschemes.vim
    "source $HOME/.config/nvim/plugins.d/airline.vim
    source $HOME/.config/nvim/plugins.d/ale.vim
    source $HOME/.config/nvim/plugins.d/nvimtree-config.vim
    source $HOME/.config/nvim/plugins.d/prettier.vim
    luafile $HOME/.config/nvim/lua/init.lua
  endif
endif

if g:os == "Windows"
  if exists('g:vscode')
    source ~/AppData/local/nvim/general.vim
    source ~/AppData/local/nvim/mappings.vim
  else
    source ~/AppData/local/nvim/plugins.vim
    source ~/AppData/local/nvim/general.vim
    source ~/AppData/local/nvim/mappings.vim
    source ~/AppData/local/nvim/colorschemes.vim
  endif
endif
