local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    numbers = "none",
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    -- indicator_icon = "▎",
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = "",
    -- buffer_close_icon = '',
    modified_icon = "●",
    close_icon = "",
    -- close_icon = '',
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  },
  -- highlights = {
  --   fill = {
  --     guifg = { attribute = "fg", highlight = "Pmenu" },
  --     -- guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   background = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   buffer_visible = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   close_button = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   close_button_visible = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   tab_selected = {
  --     guifg = { attribute = "fg", highlight = "tab_selected" },
  --     guibg = { attribute = "bg", highlight = "tab_selected" },
  --   },
  --   tab = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   tab_close = {
  --     -- guifg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
  --     guifg = { attribute = "fg", highlight = "TabLineSel" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },

  --   duplicate_selected = {
  --     guifg = { attribute = "fg", highlight = "TabLineSel" },
  --     guibg = { attribute = "bg", highlight = "TabLineSel" },
  --     gui = "italic",
  --   },
  --   duplicate_visible = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --     gui = "italic",
  --   },
  --   duplicate = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --     gui = "italic",
  --   },
  --   modified = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   modified_selected = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   modified_visible = {
  --     guifg = { attribute = "fg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   separator = {
  --     guifg = { attribute = "bg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   separator_selected = {
  --     guifg = { attribute = "bg", highlight = "Normal" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  --   -- separator_visible = {
  --   --   guifg = {attribute='bg',highlight='TabLine'},
  --   --   guibg = {attribute='bg',highlight='TabLine'}
  --   --   },
  --   indicator_selected = {
  --     guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
  --     guibg = { attribute = "bg", highlight = "Normal" },
  --   },
  -- },
}
