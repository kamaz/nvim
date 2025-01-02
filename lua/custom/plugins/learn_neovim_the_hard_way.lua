-- Description: helps with learning habit of using the right tool for the job
return {
  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "tris203/precognition.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = false,
    opts = {},
  },
}
