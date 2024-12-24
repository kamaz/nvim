-- Silent keymap option
local opts = { silent = true }

-- Normal --
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)


-- Resize with arrows
vim.keymap.set("n", "<C-,>", "<c-w>5<")
vim.keymap.set("n", "<C-.>", "<c-w>5>")
vim.keymap.set("n", "<C-t>", "<C-W>+")
vim.keymap.set("n", "<C-s>", "<C-W>-")

-- Keep the cursor at the beginning of line
vim.keymap.set("n", "J", "mzJ`z")

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- When scrolling keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
vim.keymap.set("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Close buffer
vim.keymap.set("n", "<leader>c", function()
  local last_buf = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  vim.cmd("bp")
  vim.api.nvim_buf_delete(last_buf, {})
end, opts)
