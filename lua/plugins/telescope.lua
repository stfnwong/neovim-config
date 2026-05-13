return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				pickers = {
					lsp_references = {
						show_line = false, -- don't show the code line in results, less noise
						include_declaration = false, -- don't include the definition itself in references
						fname_width = 40,
					},
					lsp_definitions = {
						show_line = false,
					},
					lsp_implementations = {
						show_line = false,
					},
					lsp_document_symbols = {
						symbol_width = 40,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- Use telescope to display LSP
		local builtin = require("telescope.builtin")

		-- Remap LSP keys to telescope equivalents
		-- These shadow the definitions in lua/core/lsp_attach.lua
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("TelescopeLspAttach", { clear = true }),
			callback = function(ev)
				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gr", builtin.lsp_references, opts)
				vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
				vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
				vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions, opts)
				vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
				vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, opts)
			end,
		})
	end,
}
