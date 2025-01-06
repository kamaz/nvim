--[[
-- Lightweight yet powerful formatter plugin for Neovim
--]]
return {
  {
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    lazy = true,
    event = "BufWritePre",
    config = function(_, _opts)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          if vim.g.auto_format then
            require("conform").format({
              bufnr = args.buf,
              timeout_ms = 5000,
              lsp_format = "fallback",
            })
          else
          end
        end,
      })

      -- set initial state to auto-format
      vim.g.auto_format = true

      require("conform").setup({
        formatters_by_ft = {
          hcl = { "hcl" },
          lua = { "stylua" },
          go = { "gofmt", "goimports", "golines" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- Conform will run the first available formatter
          javascript = { "prettierd" },
        },
      })
      require("config.keymaps").conform()
    end,
  },
}
