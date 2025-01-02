return {
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			local nvim_tree = require("nvim-tree")
			nvim_tree.setup {
				update_focused_file = {
					enable = true,
					update_cwd = true,
				},
				renderer = {
					root_folder_modifier = ":t",
					icons = {
						glyphs = {
							default = "",
							symlink = "",
							folder = {
								arrow_open = "",
								arrow_closed = "",
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
								symlink_open = "",
							},
							git = {
								unstaged = "",
								staged = "S",
								unmerged = "",
								renamed = "➜",
								untracked = "U",
								deleted = "",
								ignored = "◌",
							},
						},
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},
				view = {
					width = 30,
					side = "left",
				},
			}
			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
		end
	}
}
