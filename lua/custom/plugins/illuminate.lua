-- Description: Neovim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
return {
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "BufReadPost",
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
