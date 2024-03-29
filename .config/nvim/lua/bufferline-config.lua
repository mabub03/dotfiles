require 'bufferline'.setup{
  options = {
    view = "multiwindow", -- or "default",
    numbers = "ordinal", -- or  "ordinal" or "buffer_id",
    -- number style being depreciated use a function in numbers
    --number_style = "superscript", -- or "",
    buffer_close_icon= '',
    modified_icon = '●',
    close_icon = '',
    show_buffer_close_icons = true, --or true,
    show_tab_indicators = true, -- or false,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'slant', -- or "thick" or "thin" or { 'any', 'any' },
    always_show_bufferline = true, -- or false,
    enforce_regular_tabs = true,
    diagnostics = "nvim_lsp", -- or false
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or ""
      return " " .. icon .. count
    end
  }
}
