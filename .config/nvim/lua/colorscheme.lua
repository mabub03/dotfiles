-- kaicataldo material config
-- vim.cmd('let g:material_terminal_italics = 1')
-- vim.cmd('let g:material_theme_style = "ocean-community"')

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
-- vim.cmd('colorscheme material')

vim.g.material_style = 'deep ocean'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
vim.g.material_disable_background = false
require('material').set()

