-- Lazy requires that mapleader is set before loading lazy
vim.g.mapleader = "\\"

-- boostrap lazy
require("core.lazy")

-- General setup
require("core.options")
require("core.keymaps")
require("core.lsp_attach")

-- Try turning netrw back on
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0
