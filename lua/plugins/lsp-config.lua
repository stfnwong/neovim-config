-- All LSP configuration

-- return {
--   "williamboman/mason.nvim",
--   config = function()
--     require("mason").setup()
--   end
-- }

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
      "pyright",
      "lua_ls"
      -- "ccls",    -- Might have to do this one manually
      -- "rust-analyzer",  -- TODO: some issue with this...
    }
  })


-- nvim-lspconfig setup
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- TODO: call setup for each LSP?
-- eg: lspconfig.rust_analyzer.setup {
--    settings = {
--      ["rust-analyzer"] = {}
--    }
-- }


--local keymap = vim.keymap
---- enable keybinds for whatever lsp is attached to the current buffer
---- NOTE TO SELF: Figure out what the variation between this and the example really is.
--local on_attach = function(client, bufnr)
--  local opts = { nnoremap = true, silent = true, buffer = bufnr }
--
--  -- Keybinds 
--  -- Default keybinds
--  keymap.set("n", "gD", "vim.lsp.buf.declaration()<CR>", opts)
--  keymap.set("n", "gd", "vim.lsp.buf.definition()<CR>", opts)
--  keymap.set("n", "gi", "vim.lsp.buf.implementation()<CR>", opts)
--  keymap.set("n", "K", vim.lsp.buf.hover(), opts)
--  --keymap.set("n", "K", "vim.lsp.buf.hover()<CR>", opts)
--  keymap.set("n", "<C-k>", "vim.lsp.buf.signature_help()<CR>", opts)
--  keymap.set("n", "gr", "vim.lsp.buf.references()<CR>", opts)
--  keymap.set({"n", "v"}, "<leader>ca", "vim.lsp.buf.code_action()<CR>", opts)
--  keymap.set("n", "<leader>wa", "vim.lsp.buf.add_workspace_folder()<CR>", opts)
--  keymap.set("n", "<leader>wr", "vim.lsp.buf.remove_workspace_folder()<CR>", opts)
--  keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
--  keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
--  keymap.set("n", "<leader>rn", "vim.lsp.buf.rename()<CR>", opts)
--  keymap.set("n", "<leader>D", "vim.lsp.buf.type_definition()<CR>", opts)
--
--end
--
--
-- If I want autocomplete then do something like
--local capabilities = require("cmp_nvim_lsp").default_capabilities()





lspconfig["pyright"].setup({
    --capabilities = capabilities,
    on_attach = on_attach
  })


lspconfig["ccls"].setup({
  })


lspconfig["lua_ls"].setup({
  })


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
