-- Grab telescope if available, nil if not installed
local telescope_ok, builtin = pcall(require, "telescope.builtin")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }

		-- Navigation: telescope
		vim.keymap.set("n", "gd", telescope_ok and builtin.lsp_definitions or vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", telescope_ok and builtin.lsp_references or vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", telescope_ok and builtin.lsp_implementations or vim.lsp.buf.implementation, opts)
		vim.keymap.set(
			"n",
			"<leader>D",
			telescope_ok and builtin.lsp_type_definitions or vim.lsp.buf.type_definition,
			opts
		)

		-- Symbols: telescope
		vim.keymap.set(
			"n",
			"<leader>ds",
			telescope_ok and builtin.lsp_document_symbols or vim.lsp.buf.document_symbol,
			opts
		)
		vim.keymap.set(
			"n",
			"<leader>ws",
			telescope_ok and builtin.lsp_workspace_symbols or vim.lsp.buf.workspace_symbol,
			opts
		)

		-- These stay native
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})
