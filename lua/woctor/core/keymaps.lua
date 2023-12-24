-- vim.g.mapleader = " "   -- set leader key


local keymap = vim.keymap

-- general keymaps
keymap.set("n", "<F5>", ":setlocal spell! spelllang=en_gb<CR>") -- toggle spellcheck
keymap.set("n", "<F6>", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")   -- remove trailing whitespace
keymap.set("n", "<CR>", ":noh<CR><CR>")		-- was some escape thing I had, may not need this now
keymap.set("n", "<Up>", "gk")
keymap.set("n", "<Down>", "gj")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>+", "<C-a>")  -- increment number with \+
keymap.set("n", "<leader>-", "<C-x>")  -- decrement number with \+

-- FZF keymap 
keymap.set("n", "<leader>f", ":FZF<CR>")		-- this was my old FZF keymap
