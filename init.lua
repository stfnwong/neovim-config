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

-- Add command to dump current keymaps
vim.api.nvim_create_user_command("DumpKeymaps", function()
	local output = vim.api.nvim_exec2("nnoremap", { output = true }).output
	local lines = vim.split(output, "\n")
	local path = vim.fn.expand("~/nvim_keymaps.txt")
	vim.fn.writefile(lines, path)
	vim.notify("Keymaps written to " .. path)
end, {})
