-- Config for lualine

--local status, lualine = pcall(require, "lualine")
--if not status then 
--  return 
--end
--
--lualine.setup()


return {
    "nvim-lualine/lualine.nvim",

	config = function()
		local status, lualine = require("lualine")

		lualine.setup()
	end,
}
