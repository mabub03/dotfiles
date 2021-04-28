local saga = require 'lspsaga'
saga.init_lsp_saga()

-- lsp provider to find the cursor word definition and reference
-- noremap <silent> gh <cmd> lua require'lspsaga.provider'.lsp_finder()<CR>
-- or use command LspSagaFinder
-- noremap <silent> gh :Lspsaga lsp_finder<CR>
