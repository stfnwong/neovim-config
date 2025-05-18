-- Taken directly from bootstrapping section of 
-- https://github.com/wbthomason/packer.nvim#bootstrapping

-- Since packer seems to be dead now I will switch this to use `lazy`
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- return require("packer").startup(function(use)
--   use "wbthomason/packer.nvim"
--   -- My plugins here
--   -- use "foo1/bar1.nvim"
--   -- use "foo2/bar2.nvim"
-- 
--   -- Automatically set up your configuration after cloning packer.nvim
--   -- Put this at the end after all plugins
--   if packer_bootstrap then
--     require("packer").sync()
--   end
-- end)


-- Reload nvim whenever this file is saved (implies always online) by calling PackerSync on write
-- Note also that we assume the name of this file is plugin-setup.lua
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugin-setup.lua source <afile> | PackerSync
--  augroup end
--]])
--
--
--local status, packer = pcall(require, "packer")
--if not status then
--    return
--end
--

-- configure the plugins 
return require("packer").startup(function(use)
    -- Add list of plugins here 
    -- use "wbthomason/packer.nvim"       -- let packer manage itself
	-- many plugins use these lua functions 
	use "nvim-lua/plenary.nvim"

    -- LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"

	-- Colors
    use "bluz71/vim-nightfly-guicolors"
	use "sheerun/vim-polyglot"
	use "morhetz/gruvbox"
	use "rakr/vim-one"
	use "Lokaltog/vim-distinguished"
	use "nanotech/jellybeans.vim"
	use "folke/tokyonight.nvim"
	use "bfrg/vim-cuda-syntax"
	use "rebelot/kanagawa.nvim"
    use "NLKNguyen/papercolor-theme"
    use "romainl/Apprentice"

	-- FZF
	-- Note that we need some extra steps as per https://github.com/junegunn/fzf.vim/issues/1388#issuecomment-1462691362
	--use {
	--	"junegunn/fzf.vim",
	--	requires = { "junegunn/fzf", run = ":call fzf#install()" }
	-- }

    -- Telescope
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make"
    }
    use {"nvim-telescope/telescope.nvim", branch = "0.1.x"}

    -- file explorer
    use "nvim-tree/nvim-tree.lua"

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
      end,
    }

    -- I wasn't going to do it, but the file explorer seems better with some icons
    -- NOTE: does this require ligature support in terminal?
    use "kyazdani42/nvim-web-devicons"

    -- statusline 
    use "nvim-lualine/lualine.nvim"

    -- Navigation, editing, etc
    use "tpope/vim-surround"

    -- Jupyter plugin 
    use "luk400/vim-jukit"

    -- docs say add this bootstrap check here
    if packer_bootstrap then
        require("packer").sync()
    end
end)
