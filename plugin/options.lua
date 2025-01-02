vim.opt.clipboard = "unnamedplus"
-- more space in the neovim command line for displaying messages
vim.opt.cmdheight = 1
-- mostly just for cmp
vim.opt.completeopt = { "menuone", "noselect" }
-- so that `` is visible in markdown files
vim.opt.conceallevel = 0
-- the encoding written to a file
-- vim.opt.fileencoding = "utf-8"
-- highlight all matches on previous search pattern
vim.opt.hlsearch = false
-- incremental search
vim.opt.incsearch = true
-- ignore case in search patterns
vim.opt.ignorecase = true
-- pop up menu height
vim.opt.pumheight = 10
-- we don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false
-- always show tabs
vim.opt.showtabline = 0
-- smart case
vim.opt.smartcase = true
-- make indenting smarter again
vim.opt.smartindent = true
-- force all horizontal splits to go below current window
vim.opt.splitbelow = true
-- force all vertical splits to go to the right of current window
vim.opt.splitright = true
-- creates a swapfile
vim.opt.swapfile = false
-- set term gui colors (most terminals support this)
vim.opt.termguicolors = true
-- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.timeoutlen = 500
-- enable undo dir
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- enable persistent undo
vim.opt.undofile = true
-- faster completion (4000ms default)
vim.opt.updatetime = 300
-- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.writebackup = false
-- convert tabs to spaces
vim.opt.expandtab = true
-- the number of spaces inserted for each indentation
vim.opt.shiftwidth = 2
-- insert 2 spaces for a tab
vim.opt.tabstop = 2
-- highlight the current line
vim.opt.cursorline = true
-- set numbered lines
vim.opt.number = true
-- set numbered lines
vim.opt.relativenumber = true
-- only the last window will always have a status line
vim.opt.laststatus = 3
-- hide (partial) command in the last line of the screen (for performance)
vim.opt.showcmd = false
-- hide the line and column number of the cursor position
vim.opt.ruler = true
-- minimal number of columns to use for the line number {default 4}
vim.opt.numberwidth = 4
-- always show the sign column, otherwise it would shift the text each time
vim.opt.signcolumn = "yes"
-- display lines as one long line
vim.opt.wrap = false
-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8
-- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.sidescrolloff = 8
-- vim.opt.guifont = "monospace:h17"                      -- the font used in graphical neovim applications
-- -- the font used in graphical neovim applications
vim.opt.guifont = "JetBrainsMono\\ NFM:h12"
-- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.fillchars.eob = " "
-- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.shortmess:append "c"
-- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.whichwrap:append("<,>,[,],h,l")
-- treats words with `-` as single words
vim.opt.iskeyword:append("-")
-- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.showbreak = "↳ "
vim.opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "•", extends = "⟩", precedes = "⟨", space = "·" }
