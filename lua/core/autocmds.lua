-- in lua/core/options.lua or a dedicated lua/core/autocmds.lua
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",  -- highlight group to use
      timeout = 150,          -- milliseconds
    })
  end,
})
