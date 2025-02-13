vim.filetype.add({
	-- extension = {},
	-- filename = {},
	pattern = {
		-- can be comma-separated for a list of paths
		[".*/%.github/dependabot.yml"] = "dependabot",
		[".*/%.github/dependabot.yaml"] = "dependabot",
		[".*/%.github/workflows[%w/]+.*%.yml"] = "gha",
		[".*/%.github/workflows/[%w/]+.*%.yaml"] = "gha",
	},
})

-- use the yaml parser for the custom filetypes
vim.treesitter.language.register("yaml", "gha")
vim.treesitter.language.register("yaml", "dependabot")

return {

	{
		"stevearc/conform.nvim",
		lazy = true,
		ft = { "yaml", "gha", "dependabot" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "yamlfmt" })
				end,
			},
		},
		opts = {
			formatters_by_ft = {
				-- https://github.com/google/yamlfmt
				yaml = { "yamlfmt" },
				gha = { "yamlfmt" },
				dependabot = { "yamlfmt" },
			},
			formatters = {
				yamlfmt = {
					prepend_args = {
						-- https://github.com/google/yamlfmt/blob/main/docs/config-file.md#configuration-1
						"-formatter",
						"retain_line_breaks_single=true",
					},
				},
			},
		},
	},

	{
		"mfussenegger/nvim-lint",
		lazy = true,
		ft = { "gha" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "yamllint", "actionlint" })
				end,
			},
		},
		opts = {
			linters_by_ft = {
				yaml = { "yamllint" },
				gha = { "actionlint" },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		ft = { "yaml", "gha", "dependabot" },
		dependencies = {
			{
				"b0o/SchemaStore.nvim",
				version = false, -- last release is very old
			},
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					{
						"williamboman/mason.nvim",
					},
				},
				opts = function(_, opts)
					opts.ensure_installed = opts.ensure_installed or {}
					vim.list_extend(opts.ensure_installed, { "yamlls" })
				end,
			},
		},
		opts = function(_, opts)
			local defaults = {
				servers = {
					yamlls = {
						-- https://github.com/redhat-developer/yaml-language-server
						filetypes = { "yaml", "gha", "dependabot" },
						settings = {
							yaml = {
								schemaStore = {
									-- Disabled because using b0o/SchemaStore.nvim
									enable = false,
									-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
									url = "",
								},
								schemas = require("schemastore").yaml.schemas(),
								validate = true,
								format = {
									enable = false, -- delegate to conform.nvim
								},
							},
						},
					},
				},
			}
			opts = require("utils.table").deep_merge(opts, defaults)
			return opts
		end,
	},
}
