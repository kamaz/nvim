local M = {}

local function map_normal_mode(keys, func, desc)
	-- default values:
	-- noremap: false
	-- silent: false
	vim.keymap.set("n", keys, func, { desc = desc, noremap = false, silent = true })
end

function M.undotree()
	return {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>" },
	}
end

function M.venv_selector()
	return {
		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	}
end

function M.diagnostics()
	map_normal_mode("<leader>ud", function()
		vim.diagnostic.enable(not vim.diagnostic.is_enabled())
	end, "Toggle diagnostics")
end

function M.telescope()
	--- @param set_cwd boolean
	local function open_file_in_other_project(set_cwd)
		vim.g.project_set_cwd = set_cwd
		local telescope = require("telescope")
		telescope.extensions.project.project({ display_type = "full", hide_workspace = true })
	end

	local telescope_builtin = require("telescope.builtin")

	return {

		-- project files
		{
			"<leader>sp",
			function()
				open_file_in_other_project(true)
			end,
			desc = "Switch project",
		},
		-- yank
		-- NOTE: reminder;
		-- Use `vep` to replace current a word with a yank.
		-- Use `Vp` to replace a line with a yank.
		{
			"<leader>p",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
			desc = "Yanky history",
		},
		{
			"<leader>sf",
			function()
				open_file_in_other_project(false)
			end,
			desc = "Switch to file", -- NOTE: without changing cwd
		},

		-- search
		{
			"<leader>sg",
			function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end,
			desc = "[s]earch [g]rep",
		},
		{ '<leader>s"', "<cmd>Telescope registers<cr>", desc = '[s]earch ["]registers' },
		{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "[s]earch [a]utocommands" },
		{ "<leader>sb", "<cmd>Telescope buffers<CR>", desc = "[s]earch opened [b]uffers" },
		{ "<leader>sc", "<cmd>Telescope commands<cr>", desc = "[s]earch [c]ommands" },
		{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "[s]earch [d]ocument diagnostics" },
		{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "[s]earch [D]iagnostics" },
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[s]earch [f]iles" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[s]earch [h]elp pages" },
		{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "[s]earch [H]ighlight groups" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[s]earch [k]ey maps" },
		{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "[s]earch [M]an pages" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "[s]earch [m]arks" },
		{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "[s]earch [o]ptions" },
	}
end

function M.snacks()
	-- NOTE: Snacks is a global; _G.Snacks = M
	return {
		{
			"<leader>uz",
			function()
				Snacks.zen.zen()
			end,
			desc = "Toggle Zen mode",
		},
		{
			"<leader>uZ",
			function()
				Snacks.zen.zen()
			end,
			desc = "Toggle Zen mode",
		},
		{
			"<leader>sn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Toggle notification history",
		},
	}
end

function M.neotest()
	return {
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "Attach",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>tA",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run All Test Files",
		},
		{
			"<leader>tT",
			function()
				require("neotest").run.run({ suite = true })
			end,
			desc = "Run Test Suite",
		},
		{
			"<leader>tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Run Nearest",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show Output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.stop()
			end,
			desc = "Terminate",
		},
		{
			"<leader>td",
			function()
				vim.cmd("Neotree close")
				require("neotest").summary.close()
				require("neotest").output_panel.close()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end,
			desc = "Debug nearest test",
		},
		{
			"<leader>tD",
			function()
				vim.cmd("Neotree close")
				require("neotest").summary.close()
				require("neotest").output_panel.close()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end,
			desc = "Debug current file",
		},

		-- -- map_normal_mode("<leader>td", ':lua require("neotest").run.run({vim.fn.expand("%"), strategy = "dap"})<CR>', "[t]est [d]ebug Nearest")
		-- map_normal_mode("<leader>td", ':lua require("neotest").run.run({ strategy = "dap" })<CR>', "[t]est [d]ebug Nearest")
		-- map_normal_mode("<leader>tg", function()
		--   -- FIXME: https://github.com/nvim-neotest/neotest-go/issues/12
		--   -- Depends on "leoluz/nvim-dap-go"
		--   require("dap-go").debug_test()
		-- end, "[d]ebug [g]o (nearest test)")
	}
end

function M.fzf()
	return {
		-- {
		--   "<leader><leader>",
		--   function()
		--     require("fzf-lua").files()
		--   end,
		--   desc = "Files",
		-- },
		-- {
		--   "<leader>/",
		--   function()
		--     -- local git_grep = "git grep --line-number --column --color=always"
		--     -- opts = {cmd = git_grep}
		--     require("fzf-lua").live_grep({ multiprocess = true })
		--   end,
		--   desc = "Grep",
		-- },
		-- { 'leader>s"',   "<cmd>FzfLua registers<cr>",                                desc = '[s]earch ["]registers' },
		-- { "<leader>sh",  "<cmd>FzfLua helptags<cr>",                                 desc = "[s]earch [h]elp pages" },
		-- { "<leader>sa",  "<cmd>FzfLua autocmds<cr>",                                 desc = "[s]earch [a]utocommands" },
		-- { "<leader>sb",  "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>", desc = "[s]earch opened [b]uffers" },
		-- { "<leader>sc",  "<cmd>FzfLua commands<cr>",                                 desc = "[s]earch [c]ommands" },
		-- { "<leader>sH",  "<cmd>FzfLua highlights<cr>",                               desc = "[s]earch [H]ighlight groups" },
		-- { "<leader>sk",  "<cmd>FzfLua keymaps<cr>",                                  desc = "[s]earch [k]ey maps" },
		-- { "<leader>sM",  "<cmd>FzfLua manpages<cr>",                                 desc = "[s]earch [M]an pages" },
		-- { "<leader>sm",  "<cmd>FzfLua marks<cr>",                                    desc = "[s]earch [m]arks" },
		-- { "<leader>sj",  "<cmd>FzfLua jumps<cr>",                                    desc = "[s]earch [j]umplist" },
		-- { "<leader>sq",  "<cmd>FzfLua quickfix<cr>",                                 desc = "[s]earch [q]uickfix List" },
		--
		-- { "<leader>sF",  "<cmd>FzfLua oldfiles<CR>",                                 desc = "[s]earch recent [F]iles" },
		--
		-- -- git
		-- { "<leader>sgc", "<cmd>FzfLua git_commits<CR>",                              desc = "[s]earch [g]it [c]ommits" },
		-- { "<leader>sgC", "<cmd>FzfLua git_bcommits<CR>",                             desc = "[s]earch [g]it branch [C]ommits" },
		-- { "<leader>sgs", "<cmd>FzfLua git_status<CR>",                               desc = "[s]earch [g]it [s]tatus changes" },
		-- { "<leader>sgb", "<cmd>FzfLua git_branches<CR>",                             desc = "[s]earch [g]it [b]ranches" },
	}
end

function M.dap_ui()
	-- keymaps: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L508
	-- NOTE: see e.g. :h nvim-dap-ui for help on *dapui.elements.stacks*, where o opens up a stack.
	return {
		{
			"<leader>du",
			function()
				require("dapui").toggle({})
			end,
			desc = "DAP UI",
		},

		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			desc = "DAP Eval",
		},
	}
end

function M.dap()
	return {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "toggle [d]ebug [b]reakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "[d]ebug [B]reakpoint",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "[d]ebug [c]ontinue (start here)",
		},
		{
			"<leader>dC",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "[d]ebug [C]ursor",
		},
		{
			"<leader>dg",
			function()
				require("dap").goto_()
			end,
			desc = "[d]ebug [g]o to line",
		},
		{
			"<leader>do",
			function()
				require("dap").step_over()
			end,
			desc = "[d]ebug step [o]ver",
		},
		{
			"<leader>dO",
			function()
				require("dap").step_out()
			end,
			desc = "[d]ebug step [O]ut",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "[d]ebug [i]nto",
		},
		{
			"<leader>dj",
			function()
				require("dap").down()
			end,
			desc = "[d]ebug [j]ump down",
		},
		{
			"<leader>dk",
			function()
				require("dap").up()
			end,
			desc = "[d]ebug [k]ump up",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "[d]ebug [l]ast",
		},
		{
			"<leader>dp",
			function()
				require("dap").pause()
			end,
			desc = "[d]ebug [p]ause",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "[d]ebug [r]epl",
		},
		{
			"<leader>dR",
			function()
				require("dap").clear_breakpoints()
			end,
			desc = "[d]ebug [R]emove breakpoints",
		},
		{
			"<leader>ds",
			function()
				require("dap").session()
			end,
			desc = "[d]ebug [s]ession",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "[d]ebug [t]erminate",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "[d]ebug [w]idgets",
		},
	}
end

function M.conform()
	map_normal_mode("<leader>uf", require("utils.toggle").toggle_formatting, "Toggle auto-formatting")
end

function M.auto_session()
	return {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>ss", "<cmd>SessionSearch<CR>", desc = "[s]earch [s]ession" },
		{ "<leader>uS", "<cmd>SessionSave<CR>", desc = "Save session" },
		{ "<leader>ua", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle session autosave" },
		{ "<leader>uD", "<cmd>SessionDelete<CR>", desc = "Delete session" },
	}
end

function M.lsp()
	map_normal_mode("<leader>uh", require("utils.toggle").toggle_inlay_hints, "Toggle inlay hints")
end

function M.lsp_autocmd(event)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, nowait = true })
	end

	-- Jump to the definition of the word under your cursor.
	--  This is where a variable was first declared, or where a function is defined, etc.
	--  To jump back, press <C-t>.

	map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
	-- map(
	--   "gd",
	--   "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>",
	--   "[G]oto [D]efinition"
	-- )

	-- Find references for the word under your cursor.
	map("gr", ':lua require("telescope.builtin").lsp_references({ show_line = false })<CR>', "[G]oto [R]eferences")
	-- map(
	--   "gr",
	--   "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
	--   "[G]oto [R]eferences"
	-- )

	-- Jump to the implementation of the word under your cursor.
	--  Useful when your language has ways of declaring types without an actual implementation.
	map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	-- map(
	--   "gI",
	--   "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
	--   "[G]oto [I]mplementation"
	-- )

	-- Jump to the type of the word under your cursor.
	--  Useful when you're not sure what type a variable is and you want to see
	--  the definition of its *type*, not where it was *defined*.
	map("gt", require("telescope.builtin").lsp_type_definitions, "[G]oto [t]ype definition")
	-- map(
	--   "gt",
	--   "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
	--   "[G]oto [t]ype definition"
	-- )

	-- Fuzzy find all the symbols in your current document.
	--  Symbols are things like variables, functions, types, etc.
	map("<leader>cS", require("telescope.builtin").lsp_document_symbols, "Do[c]ument [S]ymbols (telescope)")
	-- map("<leader>cS", "<cmd>FzfLua lsp_document_symbols", "Do[c]ument [S]ymbols (telescope)")

	-- Fuzzy find all the symbols in your current workspace
	--  Similar to document symbols, except searches over your whole project.
	map("<leader>cw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols (telescope)")
	-- map("<leader>cw", "<cmd>FzfLua lsp_workspace_symbols", "[w]orkspace [s]ymbols (telescope)")

	-- Rename the variable under your cursor
	--  Most Language Servers support renaming across files, etc.
	map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")

	map("<leader>cR", Snacks.rename.rename_file, "[C]ode [R]ename")

	-- Execute a code action, usually your cursor needs to be on top of an error
	-- or a suggestion from your LSP for this to activate.
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	-- Show the available code actions for the word under your cursor
	map("<leader>cc", vim.lsp.codelens.run, "Run Codelens")
	-- map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens") -- only needed if not using autocmd

	-- Opens a popup that displays documentation about the word under your cursor
	--  See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover Documentation")

	-- WARN: This is not Goto Definition, this is Goto Declaration.
	--  For example, in C this would take you to the header
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

function M.typescript_lsp()
	return {
		{
			"gD",
			function()
				require("vtsls").commands.goto_source_definition(0)
			end,
			desc = "Goto Source Definition",
		},
		{
			"gR",
			function()
				require("vtsls").commands.file_references(0)
			end,
			desc = "File References",
		},
		{
			"<leader>co",
			function()
				require("vtsls").commands.organize_imports(0)
			end,
			desc = "Organize Imports",
		},
		{
			"<leader>cM",
			function()
				require("vtsls").commands.add_missing_imports(0)
			end,
			desc = "Add missing imports",
		},
		{
			"<leader>cu",
			function()
				require("vtsls").commands.remove_unused_imports(0)
			end,
			desc = "Remove unused imports",
		},
		{
			"<leader>cD",
			function()
				require("vtsls").commands.fix_all(0)
			end,
			desc = "Fix all diagnostics",
		},
		{
			"<leader>cV",
			function()
				require("vtsls").commands.select_ts_version(0)
			end,
			desc = "Select TS workspace version",
		},
	}
end

function M.markdown()
	return {
		{
			"<leader>uM",
			function()
				local m = require("render-markdown")
				local enabled = require("render-markdown.state").enabled
				if enabled then
					m.disable()
					vim.cmd("setlocal conceallevel=0")
				else
					m.enable()
					vim.cmd("setlocal conceallevel=2")
				end
			end,
			desc = "Toggle markdown render",
		},
	}
end

function M.winshift()
	return {
		{ "<leader>ww", "<cmd>WinShift<CR>", desc = "[w]inshift (shift + arrows)" },
	}
end

function M.trouble()
	return {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		-- {
		--   "<leader>cs",
		--   "<cmd>:Neotree document_symbols<cr>",
		--   desc = "Symbols (Neotree)",
		-- },
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	}
end

function M.todo()
	local todo_comments = require("todo-comments")

	vim.keymap.set("n", "]t", function()
		todo_comments.jump_next()
	end, { desc = "Next todo comment" })

	vim.keymap.set("n", "[t", function()
		todo_comments.jump_prev()
	end, { desc = "Previous todo comment" })

	vim.keymap.set("n", "<leader>sT", function()
		vim.cmd("TodoTelescope")
	end, { desc = "Search todo comment" })
	return {}
end

function M.showkeys()
	return {
		{ "<leader>uk", ":ShowkeysToggle<CR>", desc = "Show keys (toogle)" },
	}
end

function M.obsidian(obsidian_vars)
	return {
		{ "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "[n]otes: [s]earch text" },
		{ "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "[n]otes: search [f]ilenames" },
		{ "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "[n]otes: [n]new" },
		{ "<leader>nl", "<cmd>ObsidianQuickSwitch Learning.md<cr><cr>", desc = "[n]otes: [l]earning" },
		{ "<leader>ng", "<cmd>ObsidianQuickSwitch Go.md<cr><cr>", desc = "[n]otes: [g]olang learning" },
		{ "<leader>nv", "<cmd>ObsidianQuickSwitch Neovim config.md<cr><cr>", desc = "[n]otes: Neo[v]im todo" },

		{
			"<leader>nS",
			function()
				local client = require("obsidian").get_client()
				client:open_note(obsidian_vars.scratchpad_path)
			end,
			desc = "[n]otes: [S]cratchpad",
		},
		{
			"<leader>nm",
			function()
				local client = require("obsidian").get_client()
				-- client.dir is the vault path
				local note = client:create_note({
					title = "Meeting notes",
					dir = vim.fn.expand(obsidian_vars.notes_path),
					-- NOTE: if folder "templates" exist in $cwd,
					-- the template is expected to be found there.
					template = "meeting_notes",
				})
				client:open_note(note)
			end,
			desc = "[n]otes: new [m]eeting agenda from template",
		},
	}
end

function M.neogit()
	local function open_in_split()
		require("neogit").open({ kind = "split" })
	end

	vim.keymap.set("n", "<leader>gn", open_in_split, { silent = true, noremap = true, desc = "Neogit" })
	vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true, desc = "[g]it [p]ull" })
	vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true, desc = "[g]it [P]ush" })
	vim.keymap.set(
		"n",
		"<leader>gc",
		":Telescope git_commits<CR>",
		{ silent = true, noremap = true, desc = "[g]it [c]ommits" }
	)
	vim.keymap.set(
		"n",
		"<leader>gb",
		":Telescope git_branches<CR>",
		{ silent = true, noremap = true, desc = "[g]it [b]ranches" }
	)
end

function M.grug_far()
	return {
		{ "<leader>sr", ":GrugFar<cr>", desc = "[s]earch and [r]eplace (grug-far)" },
	}
end

function M.gitsigns(bufnr)
	local gs = package.loaded.gitsigns

	vim.keymap.set("n", "]h", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.nav_hunk("next")
		end)
		return "<Ignore>"
	end, { expr = true })

	vim.keymap.set("n", "[h", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.nav_hunk("prev")
		end)
		return "<Ignore>"
	end, { expr = true })

	vim.keymap.set(
		{ "n", "v" },
		"<leader>ghb",
		":Gitsigns change_base main",
		{ buffer = bufnr, silent = false, noremap = true, desc = "change [b]ase" }
	)
	vim.keymap.set(
		{ "n", "v" },
		"<leader>ghs",
		":Gitsigns stage_hunk<CR>",
		{ buffer = bufnr, silent = true, noremap = true, desc = "[s]tage hunk" }
	)
	vim.keymap.set(
		{ "n", "v" },
		"<leader>ghS",
		":Gitsigns stage_buffer<CR>",
		{ buffer = bufnr, silent = true, noremap = true, desc = "[S]tage buffer" }
	)
	vim.keymap.set(
		"n",
		"<leader>ghu",
		gs.undo_stage_hunk,
		{ buffer = bufnr, silent = true, noremap = true, desc = "[u]ndo stage hunk" }
	)
	vim.keymap.set(
		"n",
		"<leader>ghr",
		gs.reset_hunk,
		{ buffer = bufnr, silent = true, noremap = true, desc = "[r]eset hunk" }
	)
	vim.keymap.set(
		"n",
		"<leader>ghb",
		gs.blame,
		{ buffer = bufnr, silent = true, noremap = true, desc = "[b]lame on the side" }
	)
	vim.keymap.set("n", "<leader>gbl", gs.blame_line, { desc = "[b]lame line" })

	-- Previous Setup:
	-- Navigation
	-- map('n', ']c', function()
	--   if vim.wo.diff then
	--     vim.cmd.normal { ']c', bang = true }
	--   else
	--     gitsigns.nav_hunk 'next'
	--   end
	-- end, { desc = 'Jump to next git [c]hange' })
	--
	-- map('n', '[c', function()
	--   if vim.wo.diff then
	--     vim.cmd.normal { '[c', bang = true }
	--   else
	--     gitsigns.nav_hunk 'prev'
	--   end
	-- end, { desc = 'Jump to previous git [c]hange' })
	--
	-- -- Actions
	-- -- visual mode
	-- map('v', '<leader>hs', function()
	--   gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
	-- end, { desc = 'stage git hunk' })
	-- map('v', '<leader>hr', function()
	--   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
	-- end, { desc = 'reset git hunk' })
	-- -- normal mode
	-- map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
	-- map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
	-- map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
	-- map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
	-- map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
	-- map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
	-- map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
	-- map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
	-- map('n', '<leader>hD', function()
	--   gitsigns.diffthis '@'
	-- end, { desc = 'git [D]iff against last commit' })
	-- -- Toggles
	-- map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
	-- map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
end

function M.diffview()
	return {
		-- use [c and [c to navigate diffs (vim built in), see :h jumpto-diffs
		-- use ]x and [x to navigate conflicts
		{ "<leader>gdc", ":DiffviewOpen origin/main...HEAD", desc = "Compare commits" },
		{ "<leader>gdq", ":DiffviewClose<CR>", desc = "Close Diffview tab" },
		{ "<leader>gdh", ":DiffviewFileHistory %<CR>", desc = "File history" },
		{ "<leader>gdH", ":DiffviewFileHistory<CR>", desc = "Repo history" },
		{ "<leader>gdm", ":DiffviewOpen<CR>", desc = "Solve merge conflicts" },
		{ "<leader>gdo", ":DiffviewOpen main", desc = "DiffviewOpen" },
		{ "<leader>gdt", ":DiffviewOpen<CR>", desc = "DiffviewOpen this" },
		{ "<leader>gdp", ":DiffviewOpen origin/main...HEAD --imply-local", desc = "Review current PR" },
		{
			"<leader>gdP",
			":DiffviewFileHistory --range=origin/main...HEAD --right-only --no-merges --reverse",
			desc = "Review current PR (per commit)",
		},
	}
end

function M.whichkey(wk)
	wk.add({
		{ "<leader>a", group = "ai" },
		{ "<leader>c", group = "code" },
		{ "<leader>d", group = "debug" },
		{ "<leader>b", group = "buffer" },
		{ "<leader>g", group = "git" },
		{ "<leader>gd", group = "diffview" },
		{ "<leader>gh", group = "hunks" },
		{ "<leader>n", group = "notes" },
		{ "<leader>r", group = "run" },
		{ "<leader>rt", group = "terminal" },
		{ "<leader>s", group = "search" },
		{ "<leader>sn", group = "noice" },
		{ "<leader>t", group = "test" },
		{ "<leader>u", group = "ui" },
		{ "<leader>x", group = "diagnostics/quickfix" },
		{ "<leader>w", group = "windows", proxy = "<C-w>" },
		{
			"<leader>b",
			group = "buffers",
			expand = function()
				return require("which-key.extras").expand.buf()
			end,
		},
	})
end

function M.whichkey_contextual()
	return {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	}
end

function M.rest()
	return {
		{ "<leader>rr", "<cmd>Rest run<CR>", desc = "Run REST request under cursor" },
	}
end

--
-- ai tooling keymaps
--
function M.ai_codecompanion()
	return {
		{ "<leader>ac", ":CodeCompanionChat anthropic<CR>", desc = "Codecompanion: Claude" },
		{ "<leader>ao", ":CodeCompanionChat openai<CR>", desc = "Codecompanion: OpenAI" },
		{ "<leader>ag", ":CodeCompanionChat gemini<CR>", desc = "Codecompanion: Gemini" },
		{ "<leader>al", ":CodeCompanionChat ollama<CR>", desc = "Codecompanion: Ollama" },
	}
end

function M.ai_copilot_chat()
	return {
		{ "<leader>aC", ":CopilotChat<CR>", desc = "Copilot Chat" },
	}
end

function M.ai_copilot()
	return {
		{ "<leader>ap", ":Copilot panel<CR>", desc = "Copilot panel" },
	}
end

return M
