local path = vim.fn.stdpath("config")

local present_path = path .. "/plugins/present.nvim"
-- local jstest_path = path .. "/plugins/jstest.nvim"

return {
	{
		dir = present_path,
		config = function()
			require("present")
		end,
	},
	{
		-- dir = jstest_path,
		config = function()
			require("jstest")
		end,
	},
}
