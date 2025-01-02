return {

  {
    "mfussenegger/nvim-lint",
    lazy = true,
    ft = { "dockerfile" },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "hadolint" })
        end,
      },
    },
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
    config = function(_, opts)
      -- https://www.josean.com/posts/neovim-linting-and-formatting
      local lint = require("lint")

      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    -- ft = {
    --   "dockerfile",
    --   -- "yaml",
    -- },
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
          vim.list_extend(opts.ensure_installed, {
            "dockerls",
          })
        end,
      },
    },
    opts = {
      servers = {
        -- https://github.com/rcjsuen/dockerfile-language-server
        dockerls = {
          filetypes = { "dockerfile" },
        },
      },
    },
  },
}
