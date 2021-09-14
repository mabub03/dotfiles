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
require('compe-config')
require('nvimtree')
vim.cmd('source $HOME/.config/nvim/lua/nvimtree/nvimtree-config.vim')
--require('snippets-config')
require('lua_line')
require('treesitter-config')
require('nv-lspsaga')
require('nv-lspkind')
vim.cmd('source $HOME/.config/nvim/plugins.d/ale.vim')
vim.cmd('source $HOME/.config/nvim/plugins.d/prettier.vim')
require('lsp_config')
require('nv-telescope')
--require('dapui')

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
require('lsp.rust')
-- require('ccls')

-- Dap
require('dbg')

-- Colorscheme Settings
require('discord_rich_presence')
require('colorscheme')
vim.cmd('source $HOME/.config/nvim/transparency.vim')

end
