-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Execute lua
keymap("n", "<leader>x", "<cmd>.lua<CR>", {desc = "Execute current line"})
keymap("n", "<leader><leader>x", "<cmd>source %<CR>", {desc = "Execute current file"})

-- Resize with arrows
keymap("n", "<C-.>", "<c-w>5<")
keymap("n", "<C-,>", "<c-w>5>")
keymap("n", "<C-t>", "<C-W>+")
keymap("n", "<C-s>", "<C-W>-")

-- Keep the cursor at the beginning of line
keymap("n", "J", "mzJ`z")

-- Undotree
keymap("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- When scrolling keep cursor in the middle
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- When searching keep search terms in the middle
keymap("n", "n", "bzzzv")
keymap("n", "N", "Nzzzv")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
