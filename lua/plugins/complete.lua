return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		completion = {
			accept = {
				-- What is the equivalent for matching parens, quotes, etc?
				auto_brackets = {
					enabled = false,
				},
			},
			trigger = {
				show_on_keyword = false,
				show_on_trigger_character = false,
			},
			menu = { auto_show = false }, -- never show automatically
		},
		keymap = {
			preset = "none", -- define everything yourself
			["<C-Space>"] = { "show", "fallback" },
			["<C-y>"] = { "accept" },
			["<C-e>"] = { "cancel", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
		},
	},
}
