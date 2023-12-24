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

mason.setup()
