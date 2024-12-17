vim.opt_local.shiftwidth = 2

-- Execute lua
vim.keymap.set("n", "<leader>x", "<cmd>.!node<CR>", { desc = "Execute current line" })


function MyPlugin()
  local bufnr = vim.api.nvim_get_current_buf()
  print("Buffer name: " .. bufnr)
  -- local bufnr = 25
  -- vim.bo[bufnr].buflisted = true -- same as vim.bo.buflisted = true
  -- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { "Hello, World!" })
  -- run job
end

vim.api.nvim_create_user_command("MyPlugin", MyPlugin, {})
