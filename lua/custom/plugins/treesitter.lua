return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("lazy").setup({ {
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				config = function()
					local configs = require("nvim-treesitter.configs")
					configs.setup({
						ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "typescript", "go", "gosum", "goctl", "gotmpl", "gowork", "gomod", "markdown", "python", "hcl", "json", "cpp", "bash", "json5" },
						sync_install = false,
						highlight = { enable = true },
						indent = { enable = true },
						autopairs = {
							enable = true,
						},

						rainbow = {
							enable = true,
							extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
							max_file_lines = nil, -- Do not enable for files with more than n lines, int
						},
						playground = {
							enable = true
						}
					})
				end
			} })
		end
	}
}
