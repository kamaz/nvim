return {
  {
    "goolord/alpha-nvim",
    lazy = true,
    event = "VimEnter",
    dependencies = {},
    opts = function()
      require("alpha")
      require("alpha.term")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.opts.hl = "DashboardHeader"
      dashboard.section.header.opts.position = "center"

      dashboard.section.buttons.val = {
        dashboard.button("s", " " .. " Restore Session", ":SessionRestore"),
        dashboard.button("f", " " .. " Recent files", ":lua require('telescope').extensions.recent_files.pick()<CR>"),
        dashboard.button("l", " " .. " Update plugins", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      return dashboard
    end,
    config = function(_, opts)
      require("alpha").setup(opts.config)
    end,
  }
}

