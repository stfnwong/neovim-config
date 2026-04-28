-- Lazy requires that mapleader is set before loading lazy
vim.g.mapleader = "\\"

-- boostrap lazy
require("core.lazy")

-- General setup
require("core.options")
require("core.keymaps")
require("core.colorscheme")
require("core.lsp_attach")

-- Plugin specific setups
--require("plugins.lualine")
--require("plugins.nvim-tree")

-- Try turning netrw back on
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- Turn off the system clipboard mapping for kitty
-- TODO: I need to work out what config I actually want longterm, the point
-- of this is just to shut the system clipboard warning up. When I move away
-- from packer to lazy I will also want to come back and clean this up.
--vim.opt.clipboard = ""
