-- Description: Automatically disables certain features if the opened file is big. File size and features to disable are configurable.
-- Repositry: https://github.com/LunarVim/bigfile.nvim

return {
  {
    "LunarVim/bigfile.nvim",
    lazy = true,
    event = "BufReadPre",
    opts = {
      filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
    },
  },
}
