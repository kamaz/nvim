--[[
-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
--]]
return {
  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        opts = {
          extensions = { "trouble" },
        },
      },
    },
    opts = {},
    keys = require("config.keymaps").trouble(),
  },
}
