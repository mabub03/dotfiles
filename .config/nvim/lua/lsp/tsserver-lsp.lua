-- npm install -g typescript typescript-language-server
require 'lspconfig'.tsserver.setup {
  --cmd = {"typescript-language-server", "--stdio"}
  --filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"}
  --root_dir = root_patter("package.json", "tsconfig.json", ".git")
}
