return {

	{
		"stevearc/conform.nvim",
		lazy = true,
		ft = { "lua" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "stylua" })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		-- ft = { "lua" },
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
					vim.list_extend(opts.ensure_installed, { "lua_ls" })
				end,
			},
			{
				"folke/lazydev.nvim",
				opts = {
					library = {

						-- Library paths can be absolute
						-- "~/projects/my-awesome-lib",

						-- Or relative, which means they will be resolved from the plugin dir.
						"lazy.nvim",
						"neotest",
						"plenary",

						-- It can also be a table with trigger words / mods
						-- Only load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

						-- always load the LazyVim library
						-- "LazyVim",

						-- Only load the lazyvim library when the `LazyVim` global is found
						{ path = "LazyVim", words = { "LazyVim" } },
						{ path = "snacks.nvim", words = { "Snacks" } },
						{ path = "lazy.nvim", words = { "LazyVim" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
		},
		opts = {
			servers = {
				lua_ls = {
					filetypes = { "lua" },
					settings = {
						Lua = {
							runtime = {
								-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
							},
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = false, -- causes annoying flickering
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
		},
	},

	{
		"nvim-neotest/neotest",
		lazy = true,
		ft = { "lua" },
		dependencies = {
			{
				"nvim-neotest/neotest-plenary",
			},
		},
		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			opts.adapters["neotest-plenary"] = {}
		end,
	},
}
