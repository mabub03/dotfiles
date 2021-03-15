require 'bufferline'.setup{
  options = {
    view = "multiwindow", -- or "default",
    numbers = "none", -- or  "ordinal" or "buffer_id",
    number_style = "superscript", -- or "",
    mappings = true, -- or false,
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    show_buffer_close_icons = false, --or true,
    show_tab_indicators = true, -- or false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin', -- or "thick" or "thin" or { 'any', 'any' },
    always_show_bufferline = true, -- or false,
    enforce_regular_tabs = false,

    diagnostics = "nvim_lsp", -- or false
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      return " " .. icon .. count
    end
  }
}
