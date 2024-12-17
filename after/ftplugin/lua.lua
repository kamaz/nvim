vim.opt_local.shiftwidth = 2

-- Execute lua
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute current file" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute current selection" })
