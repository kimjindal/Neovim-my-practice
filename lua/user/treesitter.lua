local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "typescript",
    "javascript",
    "markdown",
    "lua",
    "python",
    "json",
    "html",
    "css",
    "bash",
    "vim",
    "gitignore",
  },
  highlight = { enable = true, disable = { "html", "css" } },
  indent = { enable = true },
  autopairs = { enable = true },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  markid = { enable = true },
  auto_install = true,
}
