return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "fixme", "bug", "fixit", "issue" },
        },
        TODO = { icon = " ", color = "info", alt = { "todo" } },
        HACK = { icon = " ", color = "warning", alt = { "hack" } },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning", "warn" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "optimise", "perf", "optimize", "performance" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "info", "note" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED", "testing", "passed", "failed" } },
      }
    },
    config = function(_, opts)
      local todo_comments = require("todo-comments")
      todo_comments.setup(opts)
      require("config.keymaps").todo()
    end,
  }
}
