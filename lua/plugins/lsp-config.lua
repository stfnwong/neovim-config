-- All LSP configuration

-- NOTE: ensure configuration happens in this order
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local status, mason = pcall(require, "mason")
if not status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason.setup()

mason_lspconfig.setup({
    -- LSPs we want installed
    ensure_installed = {
      "pyright",   -- TODO: check out other python langservers
      "lua_ls",
      "clangd",     -- no ccls in mason
      "rust_analyzer",
      "ocamllsp",
      "sqlls",
      -- docker stuff
      "docker_compose_language_service",
      "dockerls",
      "yamlls",
      -- shell stuff
      "bashls",

      -- Clojure 
      "clojure_lsp",

      -- HDL stuff
      "hdl_checker",
      -- Web stuff
      "html",
      -- Haskell stuff
      "hls",  -- NOTE: ghcup needs to be installed for this to work

      -- TODO: stuff to figure out later
      --"mypy",
      
      "julials",
    }
  })


-- If I want autocomplete then do something like
--local capabilities = require("cmp_nvim_lsp").default_capabilities()


lspconfig["pyright"].setup({
    --capabilities = capabilities,
    -- on_attach = on_attach
  })

lspconfig["clangd"].setup({})

lspconfig["lua_ls"].setup({})

-- TODO: what if any options do I need?
lspconfig["rust_analyzer"].setup({
    settings = {
      ["rust-analyzer"] = {}
    }
  })

lspconfig["ocamllsp"].setup({})
lspconfig["sqlls"].setup({})
lspconfig["docker_compose_language_service"].setup({})
lspconfig["dockerls"].setup({})
lspconfig["yamlls"].setup({})

lspconfig["bashls"].setup({})

--lspconfig["mypy"].setup({})
--lspconfig["ocaml_lsp"].setup({})
--lspconfig["julia_lsp"].setup({})


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    --vim.keymap.set("n", "<leader>od", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

