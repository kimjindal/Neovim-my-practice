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
return packer.startup {
  function(use)
    -- My plugins here
    use "lewis6991/impatient.nvim"
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/plenary.nvim" -- All the lua functions
    use "nathom/filetype.nvim" -- Easily speed up your neovim startup time
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use { "kyazdani42/nvim-web-devicons", event = "BufRead" }

    -- LSP
    use { "neovim/nvim-lspconfig", config = "require('user.lsp')" }
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "tamago324/nlsp-settings.nvim"
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use { "jose-elias-alvarez/nvim-lsp-ts-utils" }
    use { "tami5/lspsaga.nvim", config = "require('user.lspsaga')" }
    use {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup {}
      end,
      after = "null-ls.nvim",
    }

    -- cmp pluins
    use {
      "hrsh7th/nvim-cmp",
      event = "BufRead",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
      config = "require('user.cmp')",
    }

    -- snippets
    use {
      "hrsh7th/cmp-vsnip",
      after = "nvim-cmp",
      requires = {
        "hrsh7th/vim-vsnip",
        after = "LuaSnip",
      },
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
      },
      run = ":TSUpdate",
      config = "require('user.treesitter')",
    }

    use { "windwp/nvim-autopairs", config = "require('user.autopairs')", after = "nvim-cmp" }
    use { "andymass/vim-matchup", event = "VimEnter" }
    use { "numToStr/Comment.nvim", config = "require('user.comment')" }
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufRead",
      config = "require('user.lualine')",
    }
    use { "blackCauldron7/surround.nvim", config = "require('user.surround')", event = "BufRead" }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = "require('user.nvim-tree')",
    }
    use {
      "akinsho/bufferline.nvim",
      event = "BufWinEnter",
      config = "require('user.bufferline')",
    }
    use "moll/vim-bbye"
    use { "akinsho/toggleterm.nvim", config = "require('user.toggleterm')" }
    use { "ahmedkhalf/project.nvim", config = "require('user.project')", event = "BufRead" }
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = "require('user.indentline')",
      event = "BufRead",
    }

    -- Startify
    use {
      "goolord/alpha-nvim",
      event = "BufWinEnter",
      config = "require('user.alpha')",
    }
    use { "folke/which-key.nvim", config = "require('user.whichkey')", event = "BufRead" }

    -- Colorschemes
    use { "lunarvim/darkplus.nvim", config = "vim.cmd('colorscheme darkplus')" }
    use "projekt0n/github-nvim-theme"
    use "savq/melange"

    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup {
          "css",
          "javascript",
          "html",
          "lua",
        }
      end,
      event = "BufRead",
    }

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = "require('user.telescope')",
    }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = "require('user.gitsigns')",
    }

    -- Flutter
    use {
      "akinsho/flutter-tools.nvim",
      config = "require('user.flutter')",
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
    }

    -- EasyMotion, see :h hop-config
    use {
      "phaazon/hop.nvim",
      branch = "v1",
      config = function()
        require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
      end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/user/packer_compiled.lua",
  },
}
