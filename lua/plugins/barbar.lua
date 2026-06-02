-- lua/plugins/barbar.lua
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  version = "^1.0.0",
  opts = {
    animation       = true,
    auto_hide       = 1,
    focus_on_close  = "previous",
    icons = {
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true },
        [vim.diagnostic.severity.WARN]  = { enabled = true },
      },
      gitsigns = {
        added   = { enabled = true, icon = "+" },
        changed = { enabled = true, icon = "~" },
        deleted = { enabled = true, icon = "-" },
      },
      separator = { left = "▎", right = "" },
      modified  = { button = "●" },
    },
    insert_at_end  = true,
    focus_on_close = "previous",
  },
}
