-- Adds git related signs to the gutter, as well as utilities for managing changes

return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        require("config.keymaps").gitsigns(bufnr)
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
