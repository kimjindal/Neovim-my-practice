local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = "ﰂ ", modified = " ", removed = "ﯰ " },
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    local m = string.sub(str, 1, 1)
    if m == "N" then
      return ""
    elseif m == "I" then
      return ""
    elseif m == "V" then
      return ""
    elseif m == "C" then
      return "﬍"
    end
  end,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
}

local filename = {
  "filename",
  file_status = true,
  path = 1,
  shorting_target = 40,
  symbols = {
    modified = "+",
    readonly = "-",
    unnamed = "[No Name]",
  },
}

-- local fileformat = {
--   "fileformat",
--   icons_enabled = false,
--   icon = nil,
-- }

local lspname = {
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      local autostart = client.config.autostart
      if autostart and client.name ~= "emmet_ls" and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icons_enabled = true,
  icon = "",
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local location = {
  "location",
  padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "﬌ " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "darkplus", -- auto
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Outline" }, --  "NvimTree",
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics, filename },
    lualine_c = {},
    lualine_x = { diff, spaces, lspname, filetype },
    lualine_y = { location },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
