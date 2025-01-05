local sql_ft = { "sql", "mysql", "plsql" }

return {
	{
		"jsborjesson/vim-uppercase-sql",
		lazy = true,
		ft = sql_ft,
	},

	{
		"tpope/vim-dadbod",
		lazy = true,
		enabled = true,
		dependencies = {
			{ "kristijanhusak/vim-dadbod-ui" },
			{ "kristijanhusak/vim-dadbod-completion" },
		},
		config = function()
			vim.g.db_ui_save_location = "~/code/dbui"
			vim.g.db_ui_tmp_query_location = "~/code/queries"
			vim.g.db_ui_use_nerd_fonts = true
			vim.g.db_ui_execute_on_save = false
			vim.g.db_ui_use_nvim_notify = true
		end,
		cmd = { "DBUI", "DBUIFindBuffer" },
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		-- ft = { "sh" },
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					{
						"williamboman/mason.nvim",
					},
				},
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "sqls" })
				end,
			},
		},
		opts = {
			servers = {
				sqls = {
					filetypes = sql_ft,
				},
			},
		},
	},
}
