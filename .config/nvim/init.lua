if vim.g.vscode then
  vim.cmd('source ~/.config/nvim/lua/vscode/init.vim')
else   
-- Settings
require('settings')
vim.cmd('source $HOME/.config/nvim/mappings.vim')

-- Plugins
require('plugins')
require('autopairs-config')
require('devicons-config')
require('bufferline-config')
require('colorizer-config')
require('compe-config')
--require('deep_ocean')
--require('deep_ocean2')
-- require('evilline')
--require('lsp_config')
require('nvimtree')
vim.cmd('source $HOME/.config/nvim/lua/nvimtree/nvimtree-config.vim')
--require('snippets-config')
require('spaceline')
--require('statusline-config')
--require('statusline')
require('treesitter-config')
require('nv-lspsaga')
require('nv-lspkind')
--vim.cmd('source $HOME/.config/nvim/colorschemes.vim')
vim.cmd('source $HOME/.config/nvim/plugins.d/ale.vim')
vim.cmd('source $HOME/.config/nvim/plugins.d/prettier.vim')

-- LSP 
require('lsp')
require('lsp.tsserver-lsp')
require('lsp.html-lsp')
require('lsp.php-lsp')
require('lsp.css-lsp') 
require('lsp.json-lsp')
require('lsp.bash-lsp')
require('lsp.python-lsp')
require('lsp.lua-lsp')


-- Colorscheme Settings
require('colorscheme')

end
