return {
	"nanozuki/tabby.nvim",
	config = function()
		-- Always show tabline even with one tab
		vim.opt.showtabline = 2

		require("tabby").setup({
			-- preset is the quickest start. options:
			-- "active_tab_with_wins" - shows wins of the active tab
			-- "tab_with_top_win"     - each tab shows its top window
			-- "active_wins_at_end"   - active tab wins appear at the end
			-- "tab_only"             - just tabs, nothing else. This is yours.
			preset = "tab_only",
		})
	end,

	keys = {
		-- Opening tabs
		{ "<leader>tn", "<cmd>tabnew<cr>", desc = "New tab" },
		{ "<leader>te", "<cmd>tabedit<space>", desc = "Edit file in new tab" },
		{ "<leader>tc", "<cmd>tabclose<cr>", desc = "Close tab" },
		{ "<leader>to", "<cmd>tabonly<cr>", desc = "Close all other tabs" },

		-- Navigation: keeping your S-h/S-l muscle memory
		{ "<S-h>", "<cmd>tabprevious<cr>", desc = "Prev tab" },
		{ "<S-l>", "<cmd>tabnext<cr>", desc = "Next tab" },

		-- Jump directly to tab by number
		{ "<leader>1", "<cmd>tabnext 1<cr>", desc = "Tab 1" },
		{ "<leader>2", "<cmd>tabnext 2<cr>", desc = "Tab 2" },
		{ "<leader>3", "<cmd>tabnext 3<cr>", desc = "Tab 3" },
		{ "<leader>4", "<cmd>tabnext 4<cr>", desc = "Tab 4" },
		{ "<leader>5", "<cmd>tabnext 5<cr>", desc = "Tab 5" },

		-- Rename the current tab
		{ "<leader>tr", ":TabRename<space>", desc = "Rename tab" },
	},
}
