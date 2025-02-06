-- exe 'set rtp+=' . expand("~/.config/nvim-lazyvim/plugins/jstest.nvim/")
vim.opt.runtimepath:prepend({
	"~/.config/nvim-lazyvim/plugins/jstest.nvim",
	"~/.local/share/nvim-lazyvim/lazy/neotest",
	"~/.local/share/nvim-lazyvim/lazy/plenary.nvim",
	"~/.local/share/nvim-lazyvim/lazy/nvim-nio",
})

-- require("nvim-treesitter.configs").setup({
-- 	ensure_installed = { "typescript", "javascript" },
-- 	-- Install parsers synchronously (only applied to `ensure_installed`)
-- 	sync_install = true,
-- 	-- Automatically install missing parsers when entering buffer
-- 	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
-- 	auto_install = true,
-- 	additional_vim_regex_highlighting = false,
-- })

vim.treesitter.language.add(
	"typescript",
	{ path = "/Users/kamil/.local/share/nvim-lazyvim/lazy/nvim-treesitter/parser/typescript.so" }
)

vim.treesitter.language.add(
	"javascript",
	{ path = "/Users/kamil/.local/share/nvim-lazyvim/lazy/nvim-treesitter/parser/javascript.so" }
)
