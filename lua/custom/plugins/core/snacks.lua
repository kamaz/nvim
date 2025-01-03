--[[
-- A collection of small QoL plugins for Neovim.
--]]
return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		---@type snacks.Config
		opts = {
			styles = {
				notification_history = {
					width = 0.9,
					height = 0.9,
				},
				zen = {
					enter = true,
					fixbuf = false,
					minimal = false,
					width = 180,
					height = 0,
					backdrop = { transparent = false, blend = 40 },
					keys = { q = false },
					zindex = 40,
					wo = {
						winhighlight = "NormalFloat:Normal",
					},
				},
			},

			notifier = { enabled = true, timeout = 2000 },

			statuscolumn = { enabled = true },

			indent = {
				enabled = true,
				animate = {
					enabled = vim.fn.has("nvim-0.10") == 1,
					style = "out",
					easing = "linear",
					duration = {
						step = 20, -- ms per step
						total = 500, -- maximum duration
					},
				},
			},

			-- special mode
			zen = {
				enabled = true,
				-- You can add any `Snacks.toggle` id here.
				-- Toggle state is restored when the window is closed.
				-- Toggle config options are NOT merged.
				---@type table<string, boolean>
				toggles = {
					dim = false,
					git_signs = false,
					mini_diff_signs = false,
					diagnostics = true,
				},
			},

			-- convenience
			quickfile = { enabled = true },
		},
		keys = require("config.keymaps").snacks(),
	},
}
