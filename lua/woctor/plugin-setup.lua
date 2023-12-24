-- Taken directly from bootstrapping section of 
-- https://github.com/wbthomason/packer.nvim#bootstrapping

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

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


-- Reload nvim whenever this file is saved (implies always online)
-- (Note that in the example I am looking at PackerCompile has been renamed 
-- to PackerSync)
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


local status, packer = pcall(require, "packer")
if not status then
    return
end


-- configure the plugins 
return require("packer").startup(function(use)
    -- Add list of plugins here 
    use("wbthomason/packer.nvim")       -- let packer manage itself
	-- many plugins use these lua functions 
	use("nvim-lua/plenary.nvim")

    -- LSP
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

	-- Colors
    use("bluz71/vim-nightfly-guicolors")
	use("sheerun/vim-polyglot")
	use("morhetz/gruvbox")
	use("rakr/vim-one")
	use("Lokaltog/vim-distinguished")
	use("nanotech/jellybeans.vim")
	use("folke/tokyonight.nvim")
	use("bfrg/vim-cuda-syntax")

	-- FZF
	-- Note that we need some extra steps as per https://github.com/junegunn/fzf.vim/issues/1388#issuecomment-1462691362
	use {
		"junegunn/fzf.vim",
		requires = { "junegunn/fzf", run = ":call fzf#install()" }
	 }

     -- statusline 
     use("nvim-lualine/lualine.nvim")

    -- docs say add this bootstrap check here
    if packer_bootstrap then
        require("packer").sync()
    end
end)
