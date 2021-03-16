-- kaicataldo material config
vim.cmd('let g:material_terminal_italics = 1')
vim.cmd('let g:material_theme_style = "ocean-community"')

-- ayu config
vim.cmd("let g:ayucolor = 'mirage'") -- mirage & light also available

-- gruvbox-material config
vim.cmd('let g:gruvbox_material_enable_italic = 1')
vim.cmd('let g:gruvbox_material_disable_italic_comment = 1')

-- set background color to dark
vim.o.background = 'dark'
-- set colorscheme
-- colorscheme gruvbox-material
-- colorscheme ayu
vim.cmd('colorscheme material')

-- hi Normal ctermbg=NONE guibg=NONE
-- hi airline_section_c ctermbg=NONE guibg=NONE
-- hi airline_tabfill ctermbg=NONE guibg=NONE
--[[
let t:is_transparent = 0
function! Toggle_transparent()
  if t:is_transparent == 0
    hi Normal ctermbg=NONE guibg=NONE
    hi airline_section_c ctermbg=NONE guibg=NONE
    hi airline_tabfill ctermbg=NONE guibg=NONE
    let t:is_transparent = 1
  else
    set background=dark
    let t:is_transparent = 0
  endif
endfunction
noremap <C-t> : call Toggle_transparent()<CR>
hi Normal ctermbg=NONE guibg=NONE
hi airline_section_c ctermbg=NONE guibg=NONE
hi airline_tabfill ctermbg=NONE guibg=NONE
]]
