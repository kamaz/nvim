return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    ft = { "html" },
    opts = { ensure_installed = { "html" } },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    ft = { "html" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            "html-lsp",
          })
        end,
      },
    },
    opts = {
      servers = {
        -- https://github.com/microsoft/vscode-html-languageservice
        -- TODO: disable formatting, use prettier instead?
        html = { filetypes = { "html" }, settings = { html = {} } },
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#htmx
      },
    },
  },
}
