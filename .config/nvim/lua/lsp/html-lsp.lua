-- npm install -g vscode-html-languageserver-bin
-- vscode-html-languageserver only provides completions when snippet support is enabled. To enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.

--Enable (broadcasting) snippet capability for completion
--[[
--local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}
]]
require 'lspconfig'.html.setup {}
