return {
  {
    "chrishrb/gx.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Browse" },
    config = true, -- default settings
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  },
}
