if exists('g:vscode')
  source ~/.config/nvim/vscode/settings.vim

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  " call plug#begin('~/.vim/plugged')
  "   Plug 'tpope/vim-surround'
  " call plug#end()

endif
