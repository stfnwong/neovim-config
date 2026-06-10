return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
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
						["<C-t>"] = actions.select_tab,
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

				-- Extensions to style the ui-select popup
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							previewer = false,
							layout_config = {
								width = 0.4,
								height = 0.4
							},
						}),
					}
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")  -- register overrride
	end,
}
