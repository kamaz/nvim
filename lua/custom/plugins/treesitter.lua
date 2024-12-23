return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "vrischmann/tree-sitter-templ",
    },
    config = function()
      vim.treesitter.language.register("templ", "templ")
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "typescript", "go", "gosum", "goctl", "gotmpl", "gowork", "gomod", "markdown", "python", "hcl", "json", "cpp", "bash", "json5" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<M-space>",
          },
        },
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
  }
}
