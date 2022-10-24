if vim.g.vscode then
  vim.cmd "source /Users/apple/.config/nvim/vscode/init.vim"
else
  require "user.impatient"
  require "user.packer_compiled"
  require "user.options"
  require "user.keymaps"
  require "user.plugins"
  require "user.colorscheme"
  require "user.autocommands"
  require "user.snippets"
end
