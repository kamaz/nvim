vim.api.nvim_create_autocmd({"BufWritePre"}, {
  callback = function()
    vim.lsp.buf.format({ async = true })
  end
})
