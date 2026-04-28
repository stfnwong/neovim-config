return {
	"saghen/blink.cmp",
	version = "*",
	opts = {
		completion = {
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
