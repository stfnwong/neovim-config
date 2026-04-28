return {
	-- Mason: the installer
	{
		"mason-org/mason.nvim",
		opts = {}, -- mason.setup() with defaults, opts is fine here
	},

	-- Bridge: mason <-> lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = {
					"pyright",
					"lua_ls",
					"clangd",
					"rust_analyzer",
					"ocamllsp",
					"sqlls",
					"docker_compose_language_service",
					"dockerls",
					"yamlls",
					"bashls",
					"clojure_lsp",
					"hdl_checker",
					"html",
					-- "hls",  -- TODO: this doesn't seem to work...
				},
			})

			-- Per-server setup: only where you need non-default options
			local lspconfig = require("lspconfig")

			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {},
				},
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } }, -- stops lua_ls screaming at you
					},
				},
			})

			-- Servers that need no special config: one line each
			for _, server in ipairs({
				"pyright",
				"clangd",
				"ocamllsp",
				"sqlls",
				"docker_compose_language_service",
				"dockerls",
				"yamlls",
				"bashls",
				"clojure_lsp",
				"html",
				"hls",
			}) do
				lspconfig[server].setup({})
			end
		end,
	},
}
