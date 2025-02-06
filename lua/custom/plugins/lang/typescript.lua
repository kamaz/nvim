local path = vim.fn.stdpath("config")
-- /Users/kamil/.config/nvim-lazyvim/plugins/jstest.nvim
local vitest_path = path .. "/plugins/vitest.nvim"
local jstest_path = path .. "/plugins/jstest.nvim"
print("vitest path: ", vitest_path)
print("jstest path: ", jstest_path)
local filetypes =
	{ "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }

return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		ft = filetypes,
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
					-- vim.list_extend(opts.ensure_installed, { "ts_ls", "vtsls" })
					vim.list_extend(opts.ensure_installed, { "ts_ls" })
				end,
			},
			-- {
			-- 	"yioneko/nvim-vtsls",
			-- 	lazy = true,
			-- 	opts = {},
			-- 	config = function(_, opts)
			-- 		require("vtsls").config(opts)
			-- 	end,
			-- },
		},
		opts = {
			-- servers = {
			-- 	vtsls = {
			-- 		filetypes = filetypes,
			-- 		settings = {
			-- 			complete_function_calls = true,
			-- 			vtsls = {
			-- 				enableMoveToFileCodeAction = true,
			-- 				experimental = {
			-- 					completion = {
			-- 						enableServerSideFuzzyMatch = true,
			-- 					},
			-- 				},
			-- 			},
			-- 			typescript = {
			-- 				updateImportsOnFileMove = { enabled = "always" },
			-- 				suggest = {
			-- 					completeFunctionCalls = true,
			-- 				},
			-- 				inlayHints = {
			-- 					parameterNames = { enabled = "literals" },
			-- 					parameterTypes = { enabled = true },
			-- 					variableTypes = { enabled = true },
			-- 					propertyDeclarationTypes = { enabled = true },
			-- 					functionLikeReturnTypes = { enabled = true },
			-- 					enumMemberValues = { enabled = true },
			-- 				},
			-- 			},
			-- 			javascript = { -- NOTE: just copy the typescript settings here
			-- 				updateImportsOnFileMove = { enabled = "always" },
			-- 				suggest = {
			-- 					completeFunctionCalls = true,
			-- 				},
			-- 				inlayHints = {
			-- 					parameterNames = { enabled = "literals" },
			-- 					parameterTypes = { enabled = true },
			-- 					variableTypes = { enabled = true },
			-- 					propertyDeclarationTypes = { enabled = true },
			-- 					functionLikeReturnTypes = { enabled = true },
			-- 					enumMemberValues = { enabled = true },
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
		keys = require("config.keymaps").typescript_lsp(),
	},
	{
		"nvim-neotest/neotest",
		lazy = true,
		ft = filetypes,
		dependencies = {
			-- { "marilari88/neotest-vitest" },
			-- { dir = vitest_path, lazy = true },
			-- { dir = jstest_path, lazy = true },
		},

		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			-- opts.adapters["vitest"] = {}
			-- opts.adapters["jstest"] = {}
		end,
	},
}
