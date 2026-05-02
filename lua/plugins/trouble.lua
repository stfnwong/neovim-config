return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble", -- lazy-load: only when first invoked
	keys = {
		-- Current buffer's diagnostics: your primary "what's wrong here" view
		{
			"<leader>xx",
			"<cmd>Trouble document_diagnostics toggle<cr>",
			desc = "Buffer diagnostics (Trouble)",
		},
		-- All workspace diagnostics
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Workspace diagnostics (Trouble)",
		},
		-- LSP references for symbol under cursor
		{
			"<leader>xr",
			"<cmd>Trouble lsp_references toggle<cr>",
			desc = "LSP references (Trouble)",
		},
		-- Quickfix list in trouble
		{
			"<leader>xq",
			"<cmd>Trouble quickfix toggle<cr>",
			desc = "Quickfix (Trouble)",
		},
		-- Jump to next/prev diagnostic item within trouble's list
		{
			"]x",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Next trouble item",
		},
		{
			"[x",
			function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end,
			desc = "Prev trouble item",
		},
	},
	opts = {
		modes = {
			-- Customise document_diagnostics to be compact and focused
			document_diagnostics = {
				auto_open = false, -- don't open automatically
				auto_close = true, -- close when no more diagnostics
				auto_preview = true, -- preview item under cursor in the buffer
				focus = true, -- focus the trouble window when opened
			},
		},
	},
}
