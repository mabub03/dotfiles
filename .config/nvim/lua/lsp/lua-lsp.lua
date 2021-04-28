-- Install by: --
-- git clone https://github.com/sumneko/lua-language-server
-- cd lua-language-server
-- git submodule update --init --recursive

-- cd 3rd/luamake
-- ninja -f ninja/linux.ninja
-- cd ../..
-- ./3rd/luamake/luamake rebuild

-- to run:
-- ./bin/Linux/lua-language-server -E ./main.lua
------------------------------------------------------------------------
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
else
  print("Unsupported system for sumneko")
end

--USER = vim.fn.expand('$USER')

--local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
--local sumneko_binary = sumneko_root_path..'/bin'..system_name..'/lua-language-server'

local sumneko_root_path = '$HOME/.config/nvim/ls/lua-language-server' 
local sumneko_binary = '$HOME/.config/nvim/ls/lua-language-server/bin/Linux/lua-language-server'
--sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
--sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true, 
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
