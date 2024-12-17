return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "nvim-telescope/telescope-dap.nvim" },
		{ "nvim-telescope/telescope-media-files.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "nvim-telescope/telescope-packer.nvim" },
		{ "nvim-telescope/telescope-symbols.nvim" },
		{ "nvim-telescope/telescope-vimspector.nvim" },
		{ "nvim-telescope/telescope-z.nvim" },
		{ "nvim-telescope/telescope-github.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {

				prompt_prefix = " ",
				selection_caret = " ",
				-- path_display = { "smart" },
				-- path_display = { shorten = 5 },
				path_display = { "truncate" },
				file_ignore_patterns = { ".git/", "node_modules" },

				mappings = {
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})

		local telescope_builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [f]iles' })
		vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [h]elp' })
		vim.keymap.set('n', '<C-p>', telescope_builtin.git_files, { desc = '[S]earch' })
		vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [w]ord' })
		vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [g]rep' })
		vim.keymap.set('n', '<leader>sG', telescope_builtin.live_grep, { desc = '[S]earch by [G]ist' })
		vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [d]iagnostics' })
		vim.keymap.set('n', '<leader>sp', ":Telescope projects<CR>", { desc = '[S]earch [p]rojects' })
		vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, { desc = '[S]earch [p]rojects' })

    -- require('config.telescope.multi_grep').setup()
	end
}
