return {
  {
    "sindrets/winshift.nvim",
    lazy = true,
    keys = require("config.keymaps").winshift(),
    cmd = { "WinShift" },
  },
}
