local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "n",
  pumheight = 10,
  showmode = false,
  showtabline = 4,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 120,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  guifont = "monospace:h17",
  path = ".,,,$PWD/**",
  inccommand = "split",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[hi rainbowcol1 guifg=#eee]]
vim.cmd [[set whichwrap+=<,>,[,],h,l]]
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.cmd [[
  augroup file_autoread_trigger
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
  augroup end
]]

vim.g.cursorhold_updatetime = 100 -- set for FixCursorHold.nvim plugin
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets/"
vim.g.ruby_host_prog = "/usr/local/lib/ruby/gems/3.0.0/bin/neovim-ruby-host"
vim.g.python3_host_prog = "/usr/local/bin/python3"
