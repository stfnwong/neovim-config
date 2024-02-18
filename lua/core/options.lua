-- In here we should have access to the "vim" global variable

local opt = vim.opt -- This var hold vim options

-- line numering
-- opt.relativenumber = true
opt.number = true

-- indent
opt.tabstop = 4
opt.shiftwidth = 4

-- I"ve seen this somewhere (here https://gist.github.com/ammarnajjar/3bdd9236cf62513a79db20520ba8467d) which might give me the retab behaviour I want
vim.api.nvim_set_keymap("n", "<leader>T", "<cmd>lua TablToggle()<cr>", {})
function TabToggle()
    if vim.bo.expandtab then
        vim.bo.expandtab = false
    else
        vim.bo.expandtab = true
        vim.cmd("retab")
    end
end
-- a manual workaround for syntax highlight problems after retab
-- https://github.com/nvim-treesitter/nvim-treesitter#i-experience-weird-highlighting-issues-similar-to-78
-- vim.api.nvim_set_keymap("n", "<F4>", "<cmd>write | edit | TSBufEnable highlight<cr>", {})

-- Colorcolumn
vim.api.nvim_set_option_value("colorcolumn", "88", {})

-- Use relative line numbers
vim.wo.relativenumber = true

-- wrapping
opt.wrap = true
opt.linebreak = true

-- backspace
-- opt.backspace = "indent,eol,start"  -- This "fixes" backspace, whatever that means

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true         -- does this work like old vim?
opt.incsearch = true            -- does this work like old vim?

-- appearance
opt.cursorline = true   -- puts a line on the cursor
opt.termguicolors = true
opt.background = "dark"   -- forces colorschemes to default to dark

-- clipboard
opt.clipboard:append("unnamedplus")

-- window splits 
opt.splitright = true
opt.splitbelow = false

-- affect how words are joined 
--opt.iskeyword:append("-")   -- adding this means that text joined with '-' is considered a single word
