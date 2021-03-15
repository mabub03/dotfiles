-- npm install -g vscode-json-languageserver
--require 'lspconfig'.jsonls.setup {}

-- vscode-json-languageserver only provides range formatting. You can map a command that applies range formatting to the entire document:
-- [[
require'lspconfig'.jsonls.setup {
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
