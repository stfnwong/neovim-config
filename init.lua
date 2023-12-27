-- General setup
require("plugin-setup")
require("core.options")
require("core.keymaps")
require("core.colorscheme")

-- Plugin specific setups 
require("plugins.lualine")
require("plugins.nvim-tree")

-- All LSP setup in here (do LSP last?)
require("plugins.lsp-config")
