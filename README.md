# NEOVIM CONFIG
This is to shut github up about not having a README. This is my config for neovim.
I am moving to neovim because vim is too slow on my mac, and its only partly
because of the fucking antivirus shit that we have at work. Why a 2019 Macbook
pro is fucking slow like dogshit I don't know but even on this fucked up ISO
keyboard I can still type as fast if not faster than the buffer can render
because it takes a literal age to draw one fucking character. I can fly through 
the exact same thing without breaking a sweat on a T440p, which was not hand 
designed by a Trillion Dollar company in Sunny California.

Typing in this same file in `neovim` is slightly faster, although the real reason 
is that somehow this machine can barely run a terminal that is designed to 
emulate a teletype machine from the mid 20th century.

### Outdated
For my future self, this file goes in `$HOME/.config/nvim`.

## Prerequisites
As of this writing I am running on Arch Linux. As well as `neovim` I also need the 
following packages:

- `python-pynvim`

## Installation
It should just work. From `init.lua` we call `lua/plugin-setup.lua` which ensures that
`packer` is installed and then goes through all the plugins and installs them. To add 
new plugins add a `use "<URL>"` line in `lua/plugin-setup.lua`. Thanks to the `autocmd`
in the setup `PackerSync` is run each time the file is modified, so cloning the plugins
should happen right away

### LSP installation
This config uses `Mason` which is also supposed to handle this. In `lua/plugins/lsp-config.lua`
there is a `ensure_installed` table which has the names of all the LSPs to install. 
The actual setup here seems complicated to me, because we have these three components that
are supposed to work together `lspconfig` on the `nvim` side, `mason` for installing and
managing the LSPs, and then `mason-lspconfig` which I think writes configs for each of 
the LSPs in turn?


### New plugin layout using lua

This long explanation is here for future me since despite using `vim` for 10 years I 
am completely new to this world of customizing everything with `lua`.

The directory layout is 

```.
├── init.lua
├── init.vim.old     # Ignore this
├── lua
│   ├── core
│   │   ├── colorscheme.lua
│   │   ├── keymaps.lua
│   │   └── options.lua
│   ├── plugins
│   │   ├── lsp-config.lua
│   │   ├── lualine.lua
│   │   ├── nvim-tree.lua
│   │   ├── telescope.lua
│   │   └── treesitter.lua
│   └── plugin-setup.lua
├── plugin
│   └── packer_compiled.lua
└── README.md    # <- This file
```




I followed some guide or other that puts all the `lua` stuff into named folders.
From what I can tell as someone who knows no `lua` you glue everything together 
in `init.lua` by using `require()`.

So each plugin gets its own `lua` file that controls its settings, each of these
is under `lua/woctor/plugins` and needs to be `require()`'d from `init.lua`.


### NetRW
I think I prefer the old behaviour of `netrw` where you can `:e` to a directory and 
then select something without having `nvimtree` pop up and then place the source file 
in the current buffer.



## LSP Keymaps 
I forget these all the time so I've duplicated them here for my reference. Check the
keymaps file at `lua/plugins/lsp-config.lua` for the actual keymaps


```



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

```
