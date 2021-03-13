require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- debounced time for highlighting nodes in teh playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
    },
    autotag = {
        enable = true,
    }
}

