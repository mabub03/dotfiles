--[[
dir="${HOME}/.local/share/nvim/site/pack/nvim-lspconfig/opt/nvim-lspconfig/"
mkdir -p "$dir"
cd "$dir"
git clone 'https://github.com/neovim/nvim-lspconfig.git' .
]]
require 'lspconfig'.gopls.setup {}
