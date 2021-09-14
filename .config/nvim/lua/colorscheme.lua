-- ayu config
vim.cmd("let g:ayucolor = 'mirage'") -- mirage & light also available
-- vim.cmd('colorscheme ayu')

-- gruvbox-material config
vim.cmd('let g:gruvbox_material_enable_italic = 1')
vim.cmd('let g:gruvbox_material_disable_italic_comment = 0')
vim.cmd('colorscheme gruvbox-material')

-- set background color to dark
vim.o.background = 'dark'

vim.g.material_style = 'deep ocean'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
vim.g.material_disable_background = false
--require('material').set()
