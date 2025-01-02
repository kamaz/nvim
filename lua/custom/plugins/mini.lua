return {
	{
		'echasnovski/mini.nvim',
		version = '*',
		config = function()
			-- local statusline = require("mini.statusline")
			-- statusline.setup({
			-- 	use_icons = true
			-- })

      local surround = require("mini.surround")
      surround.setup()

      local ai = require("mini.ai")
      ai.setup()

      -- local operators = require("mini.operators")
      -- operators.setup()

		end
	},
}
