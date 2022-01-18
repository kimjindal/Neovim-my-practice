local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "rafamadriz/friendly-snippets",
    },
  }

  -- snippets
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    requires = {
      "jose-elias-alvarez/null-ls.nvim",
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
  } -- improve typescript

  use { "windwp/nvim-autopairs", config = "require('user.autopairs')", after = "nvim-cmp" }
  use { "numToStr/Comment.nvim", config = "require('user.comment')" }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    event = "BufWinEnter",
    config = "require('user.lualine')",
  }
  use { "akinsho/toggleterm.nvim", config = "require('user.toggleterm')" }
  use { "ahmedkhalf/project.nvim", config = "require('user.project')", event = "BufWinEnter" }
  use { "lewis6991/impatient.nvim", config = "require('user.impatient')" }
  use "nathom/filetype.nvim" -- Easily speed up your neovim startup time
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = "require('user.indentline')",
    event = "BufRead",
  }
  use {
    "goolord/alpha-nvim",
    event = "BufRead",
    config = "require('user.alpha')",
  }
  use { "folke/which-key.nvim", config = "require('user.whichkey')", event = "BufWinEnter" }
  use { "blackCauldron7/surround.nvim", config = "require('user.surround')" }

  -- File explorer
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = "NvimTreeToggle",
    config = "require('user.nvim-tree')",
  }
  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufWinEnter",
    config = "require('user.bufferline')",
  }
  use "moll/vim-bbye"

  -- Colorschemes
  use "rose-pine/neovim"
  use { "lunarvim/darkplus.nvim", config = "vim.cmd('colorscheme darkplus')" }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = "require('user.telescope')",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = "require('user.treesitter')",
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = "require('user.gitsigns')",
  }

  -- Flutter
  use {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = "require('user.flutter')",
  }

  use { "andymass/vim-matchup", event = "VimEnter" }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    cmd = "MarkdownPreview",
  }
  use {
    "phaazon/hop.nvim",
    branch = "v1", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
