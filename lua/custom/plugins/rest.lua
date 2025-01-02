--[[
-- A very fast, powerful, extensible and asynchronous Neovim HTTP client written in Lua.
--]]
return {
  {
    "rest-nvim/rest.nvim",
    lazy = true,
    enabled = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
      "nvim-lua/plenary.nvim",
    },
    ft = { "http" },
    config = function()
      require("rest-nvim").setup({
        _log_level = vim.log.levels.WARN,
      })
    end,
    keys = require("config.keymaps").rest(),
  },
}
