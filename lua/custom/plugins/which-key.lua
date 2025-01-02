local multi_grep = require("config.telescope.multi_grep")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
    },
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      require("config.keymaps").whichkey(wk)
      wk.setup(opts)
    end,
    keys = require("config.keymaps").whichkey_contextual(),
  }
}
