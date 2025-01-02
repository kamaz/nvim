return {

	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		event = "VeryLazy",
		version = "*",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-telescope/telescope-frecency.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "nvim-telescope/telescope-media-files.nvim" },
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "nvim-telescope/telescope-vimspector.nvim" },
			{ "nvim-telescope/telescope-z.nvim" },
			{ "nvim-telescope/telescope-github.nvim" },
			{ "smartpde/telescope-recent-files" },
			{
				-- used for switching between projects
				"nvim-telescope/telescope-project.nvim",
			},
			{ "gbprod/yanky.nvim" },
			{ "folke/trouble.nvim" }, -- for trouble.sources.telescope
		},
		opts = function(_, opts)
			-- you have to setup otherwise it fails, see: https://github.com/gbprod/yanky.nvim/issues/75
			require("yanky").setup({})
			local actions = require("telescope.actions")
			-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes
			local custom_opts = {
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--hidden",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/node_modules/*",
					},
					mappings = {
						-- optionally, use tab to select file(s) and ...
						i = {
							["<C-t>"] = require("trouble.sources.telescope").open,
							["<a-t>"] = require("trouble.sources.telescope").open,
							["<a-a>"] = require("trouble.sources.telescope").add,
							["<Down>"] = actions.cycle_history_next,
							["<Up>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					recent_files = {
						only_cwd = true,
					},
				},
			}
			return vim.tbl_deep_extend("force", custom_opts, opts)
		end,
		config = function(_, opts)
			local telescope = require("telescope")

			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
			telescope.load_extension("recent_files")
			telescope.load_extension("project")
			telescope.load_extension("yank_history")
		end,
		keys = require("config.keymaps").telescope(),
	},
}
