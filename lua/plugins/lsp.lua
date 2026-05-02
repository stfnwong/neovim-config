return {
	-- Mason: the installer
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	-- Bridge: mason <-> lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
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
				"hls",
			},
		},
	},

	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Swap this out for blink/cmp equivalent when you add a completion plugin
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- All server configs live here: name -> setup opts
			-- Empty table = setup({}) with just capabilities
			local servers = {
				clangd = {},
				ocamllsp = {},
				sqlls = {},
				docker_compose_language_service = {},
				dockerls = {},
				yamlls = {},
				bashls = {},
				clojure_lsp = {},
				html = {},
				hls = {},

				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},

				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
						},
					},
				},

				basedpyright = {
					settings = {
						basedpyright = {
							typeCheckingMode = "standard",
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
			}

			-- The handler: capabilities injected uniformly, per-server opts merged in
			for server, opts in pairs(servers) do
				lspconfig[server].setup(vim.tbl_deep_extend("force", { capabilities = capabilities }, opts))
			end

			-- Servers not in mason (installed manually, e.g. uv tool install ty)
			lspconfig.ty.setup({ capabilities = capabilities })
		end,
	},
}
