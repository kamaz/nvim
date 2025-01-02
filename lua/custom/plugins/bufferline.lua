-- Description: This plugin shamelessly attempts to emulate the aesthetics of GUI text editors/Doom Emacs. It was inspired by a screenshot of DOOM Emacs using centaur tabs.
-- Repositry: https://github.com/akinsho/bufferline.nvim
return {
  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      options = {
        mode = "tabs", -- only show tabpages instead of buffers
        always_show_bufferline = false,
      },
    },
  },
}
