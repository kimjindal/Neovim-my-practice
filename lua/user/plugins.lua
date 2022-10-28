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
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup {
  function(use)
    -- Dependency plugins here
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "lewis6991/impatient.nvim"
    use "ggandor/lightspeed.nvim"
    use "szw/vim-maximizer"

    -- Surround selections
    use { "kylechui/nvim-surround", tag = "*", config = "require('user.surround')" }

    -- Commenting with gc
    use { "numToStr/Comment.nvim", config = "require('user.comment')" }
    use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08" }

    -- Vscode like icons
    use { "kyazdani42/nvim-web-devicons", event = "BufRead" }

    -- Statusline
    use { "nvim-lualine/lualine.nvim", config = "require('user.lualine')", event = "BufRead" }

    -- Telescope
    use { "nvim-telescope/telescope.nvim", cmd = "Telescope", config = "require('user.telescope')" }
    use { "benfowler/telescope-luasnip.nvim", module = "telescope._extensions.luasnip" }
    use { "ahmedkhalf/project.nvim", config = "require('user.project')", event = "BufRead" }

    -- cmp autocompletion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "saadparwaiz1/cmp_luasnip"

    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- LSP managing & installing lsp servers, linters & formatters
    use { "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12" }
    use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
    use { "RRethy/vim-illuminate", commit = "a2e8476af3f3e993bb0d6477438aad3096512e42" }

    -- LSP configuring lsp servers
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "onsails/lspkind.nvim" -- vscode like icons for autocompletion
    -- use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis

    -- Formatting & linting
    use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" }
    -- use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- Treesitter
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = "require('user.treesitter')" }
    use { "windwp/nvim-autopairs", config = "require('user.autopairs')", after = "nvim-cmp" }
    use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }
    use { "David-Kunz/markid", after = "nvim-treesitter" } -- same_name identifiers with the same color

    -- File explorer
    use { "kyazdani42/nvim-tree.lua", config = "require('user.nvim-tree')", event = "BufRead" }
    use { "akinsho/toggleterm.nvim", config = "require('user.toggleterm')", event = "BufRead" }
    use { "akinsho/bufferline.nvim", tag = "v2.*", event = "BufWinEnter", config = "require('user.bufferline')" }
    use { "kazhala/close-buffers.nvim", event = "BufRead" }
    use { "lukas-reineke/indent-blankline.nvim", config = "require('user.indentline')", event = "BufWinEnter" }

    -- Startify
    use { "goolord/alpha-nvim", event = "BufWinEnter", config = "require('user.alpha')" }
    use { "folke/which-key.nvim", config = "require('user.whichkey')", event = "BufRead" }

    -- Colorschemes
    use { "Yazeed1s/minimal.nvim" }
    use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

    -- Git
    use { "lewis6991/gitsigns.nvim", config = "require('user.gitsigns')", event = "BufRead" }

    -- Folding
    use { "anuvyklack/pretty-fold.nvim", config = "require('user.pretty-fold')" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require("packer").sync()
    end
  end,
  -- Lazyloading packer_compiled file path for impatient.nvim
  -- config = {
  --   compile_path = vim.fn.stdpath "config" .. "/lua/user/packer_compiled.lua",
  -- },
}
