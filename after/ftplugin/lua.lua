vim.opt_local.shiftwidth = 2

-- Execute lua
vim.keymap.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute current line" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute current file" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute current selection" })

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.lua" },
--   callback = function(ev)
--     print(string.format('event fired: %s', vim.inspect(ev)))
--   end
-- })
