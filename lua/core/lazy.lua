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

-- configure the plugins 
return require("lazy").setup({
    -- Add list of plugins here 
	
	-- many plugins use these lua functions 
	"nvim-lua/plenary.nvim",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

	-- Colors
	"bluz71/vim-nightfly-guicolors",
	"sheerun/vim-polyglot",
	"morhetz/gruvbox",
	"rakr/vim-one",
	"Lokaltog/vim-distinguished",
	"nanotech/jellybeans.vim",
	"folke/tokyonight.nvim",
	"bfrg/vim-cuda-syntax",
	"rebelot/kanagawa.nvim",
    "NLKNguyen/papercolor-theme",
    "romainl/Apprentice",

	-- FZF
	-- Note that we need some extra steps as per https://github.com/junegunn/fzf.vim/issues/1388#issuecomment-1462691362
	--{
	--	"junegunn/fzf.vim",
	--	dependencies = { "junegunn/fzf", build = ":call fzf#install()" }
	-- },

    -- Telescope
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make"
    },
    {"nvim-telescope/telescope.nvim", branch = "0.1.x"},

    -- file explorer
    "nvim-tree/nvim-tree.lua",

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = function()
        local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
        ts_update()
      end,
    },

    -- I wasn't going to do it, but the file explorer seems better with some icons
    -- NOTE: does this require ligature support in terminal?
    "kyazdani42/nvim-web-devicons",

    -- statusline 
    "nvim-lualine/lualine.nvim",

    -- Navigation, editing, etc
    "tpope/vim-surround",

    -- Jupyter plugin 
    --"luk400/vim-jukit",
})
