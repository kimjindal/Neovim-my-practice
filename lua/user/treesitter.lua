local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "bash",
    "css",
    "dart",
    "html",
    "javascript",
    "json",
    "lua",
    "perl",
    "php",
    "python",
    "regex",
    "typescript",
    "vim",
  },
  sync_install = true,
  ignore_install = { "" },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
    filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "php" },
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
  },
}

-- fold, folding settings
-- vim.wo.foldlevel = 20
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext =
--   [[substitute(' '.getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
-- vim.wo.foldenable = false
