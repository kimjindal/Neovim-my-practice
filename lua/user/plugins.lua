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
    -- Dependency plugins here
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "nathom/filetype.nvim"
    use "lewis6991/impatient.nvim"
    use "ggandor/lightspeed.nvim"
    use { "nvim-lua/popup.nvim", event = "BufRead" }
    use { "kyazdani42/nvim-web-devicons", event = "BufRead" }

    -- LSP
    use { "neovim/nvim-lspconfig", config = "require('user.lsp')" }
    use "williamboman/nvim-lsp-installer"
    use "tamago324/nlsp-settings.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

    -- cmp & snippet pluins
    use {
      "hrsh7th/nvim-cmp",
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

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
        "p00f/nvim-ts-rainbow",
      },
      run = ":TSUpdate",
      config = "require('user.treesitter')",
    }
    use { "windwp/nvim-autopairs", config = "require('user.autopairs')", after = "nvim-cmp" }
    use { "andymass/vim-matchup", event = "BufRead" }
    use { "numToStr/Comment.nvim", config = "require('user.comment')", event = "BufRead" }
    -- use { "ur4ltz/surround.nvim", config = "require('user.surround')", event = "BufRead" }
    use {
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup {
          -- Configuration here, or leave empty to use defaults
        }
      end,
    }
    use { "mustache/vim-mustache-handlebars", event = "BufRead" }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      event = "BufRead",
      config = "require('user.nvim-tree')",
    }
    use {
      "akinsho/bufferline.nvim",
      tag = "v2.*",
      event = "BufWinEnter",
      config = "require('user.bufferline')",
    }
    use { "kazhala/close-buffers.nvim", event = "BufRead" }
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = "require('user.indentline')",
      event = "BufWinEnter",
    }

    -- Startify
    use {
      "goolord/alpha-nvim",
      event = "BufWinEnter",
      config = "require('user.alpha')",
    }
    use { "folke/which-key.nvim", config = "require('user.whichkey')", event = "BufRead" }

    -- Colorschemes
    use { "Yazeed1s/minimal.nvim" }
    use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufRead",
      config = "require('user.lualine')",
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup {
          css = { css = true },
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
    use { "akinsho/toggleterm.nvim", config = "require('user.toggleterm')", event = "BufRead" }
    use { "ahmedkhalf/project.nvim", config = "require('user.project')", event = "BufRead" }
    use { "benfowler/telescope-luasnip.nvim", module = "telescope._extensions.luasnip" }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      config = "require('user.gitsigns')",
      event = "BufRead",
    }

    -- Folding
    use {
      "anuvyklack/pretty-fold.nvim",
      config = function()
        require("pretty-fold").setup()
      end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  -- Lazyloading packer_compiled file path for impatient.nvim
  config = {
    compile_path = vim.fn.stdpath "config" .. "/lua/user/packer_compiled.lua",
  },
}
