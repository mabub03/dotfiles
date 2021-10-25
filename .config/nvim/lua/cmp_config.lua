local cmp = require'cmp'
local luasnip = require'luasnip'
cmp.setup {
  completion = {
    --autocomplete = true,
    -- set up like nvim-compe's preselect = 'always'
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -- preselect = ,
  --documentation = { },
  --[[sorting = {
    priority_weight = 2.,
    --comparators = { },
  },]]--
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
      " " .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        ultisnips = "[UltiSnips]",
        nvim_lua = "[Lua]",
        cmp_tabnine = "[TabNine]",
        look = "[Look]",
        path = "[Path]",
        spell = "[Spell]",
        calc = "[Calc]",
        emoji = "[Emoji]"
      })[entry.source.name]
      return vim_item
    end
  },
  mapping = {
    -- built in help cmd.mappings are:
    -- cmp.mapping.select_prev_item()
    -- cmp.mapping.select_next_item()
    -- cmp.mapping.scroll_docs(number)
    -- cmp.mapping.complete()
    -- cmp.mapping.close()
    -- cmp.mapping.abort()
    -- cmp.mapping.confirm({ select = bool, behavior = cmp.ConfirmBehavior.{Insert,Replace} })
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  --  { name = 'cmp_tabnine' },
    { name = 'buffer' },
    { name = 'path' },
  },
}

-- load vscode styled snippets (json snippets)
-- this also makes rafamadriz/friendly-snippets plugin snippets show up
require("luasnip/loaders/from_vscode").lazy_load()

-- auto pairs from windwp/nvim-autopairs extension
require('nvim-autopairs.completion.cmp').setup({
  map_cr = true,
  map_complete = true,
  auto_select = true
})

-- coding ai from the tzachar/cmp-tabnine plugin
--local tabnine = require('cmp_tabnine.config')
--tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

-- database completion with kristijanhusak/vim-dadbod-completion plugin
--vim.api.nvim_exec([[
--autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
--]], false)
