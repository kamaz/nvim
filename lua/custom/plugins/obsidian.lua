-- Description: Note taking application
local M = {}
M.vault_path = vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents")
M.notes_path = vim.fn.expand(M.vault_path .. "/Meeting_notes")
M.scratchpad_path = vim.fn.expand(M.vault_path .. "/scratchpad.md")

return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	dependencies = {
		-- required
		"nvim-lua/plenary.nvim",
		-- optional
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	enabled = true,
	ft = "markdown",
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/vault/obsidian/personal",
			},
			{
				name = "work",
				path = "~/vault/obsidian/work",
			},
		},

		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
	},
	keys = require("config.keymaps").obsidian(M),
}
