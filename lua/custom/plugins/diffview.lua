-- Description: Vim's diff mode is pretty good, but there is no convenient way to quickly bring up all modified files in a diffsplit. This plugin aims to provide a simple, unified, single tabpage interface that lets you easily review all changed files for any git rev.
-- Repositry: https://github.com/sindrets/diffview.nvim
return {
  {
    -- NOTE: jump between diffs with ]c and [c (vim built in), see :h jumpto-diffs
    "sindrets/diffview.nvim",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },

    opts = {

      default = {
        disable_diagnostics = false,
      },
      view = {
        merge_tool = {
          disable_diagnostics = false,
          winbar_info = true,
        },
      },
      enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
      hooks = {
        -- do not fold
        diff_buf_win_enter = function(bufnr)
          vim.opt_local.foldenable = false
        end,

        -- TODO: jump to first diff: https://github.com/sindrets/diffview.nvim/issues/440
        -- TODO: enable diagnostics in diffview
      },
    },

    config = function(_, opts)
      local actions = require("diffview.actions")

      require("diffview").setup(opts)
    end,
    keys = require("config.keymaps").diffview(),
  },
}
