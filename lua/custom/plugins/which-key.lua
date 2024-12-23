local multi_grep = require("config.telescope.multi_grep")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      --
      -- LSP
      --
      { "<leader>l",  group = "lsp",                                       desc = "LSP", },
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",            desc = "Code Action" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>",       desc = "Format" },
      { "<leader>li", "<cmd>LspInfo<cr>",                                  desc = "Info" },
      { "<leader>lI", "<cmd>LspInstallInfo<cr>",                           desc = "Installer Info" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",               desc = "CodeLens Action" },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",          desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                 desc = "Rename" },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",           desc = "Document Symbols" },
      { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",            desc = "Document Diagnostics", },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                    desc = "Workspace Diagnostics", },
      { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", desc = "Next Diagnostic", },
      { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", desc = "Prev Diagnostic", },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",  desc = "Workspace Symbols", },

      --
      -- Search
      --
      { "<leader>s",  group = "search",                                    desc = "Search", },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",                     desc = "[S]earch [f]iles" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>",                    desc = "[S]earch current [w]ord" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",                      desc = "[S]earch by [g]rep" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>",                    desc = "[S]earch [d]iagnostic" },
      { "<leader>sb", "<cmd>Telescope git_branches<cr>",                   desc = "[S]earch [b]ranch" },
      { "<leader>sc", "<cmd>Telescope colorscheme<cr>",                    desc = "[S]earch [c]olorscheme" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                      desc = "[S]earch [h]elp" },
      { "<leader>sp", "<cmd>Telescope projects<cr>",                       desc = "[S]earch [p]rojects" },
      { "<leader>sm", multi_grep.multi_grep,                               desc = "[S]earch [m]ulti grep" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                      desc = "[S]earch [M]an Pages" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                       desc = "[S]earch Open [r]ecent File" },
      { "<leader>sR", "<cmd>Telescope registers<cr>",                      desc = "[S]earch [R]egisters" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                        desc = "[S]earch [k]eymaps" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                       desc = "[S]earch [C]ommands" },
      { "<leader>sG", "<cmd>Telescope gh gist<cr>",                        desc = "[S]earch [G]ist" },

      --
      -- Terminal
      --
      { "<leader>t",  group = "terminal",                                  desc = "Terminal", },
      { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>",                       desc = "Node" },
      { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>",                     desc = "Python" },
      { "<leader>tt", "<cmd>lua _TERRAFORM_TOGGLE()<cr>",                  desc = "Terraform" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",               desc = "Float" },
      { "<leader>th", "<cmd>ToggleTerm size=20 direction=horizontal<CR>",  desc = "Horizontal" },
      { "<leader>ta", "<cmd>ToggleTermToggleAll<cr>",                      desc = "Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",    desc = "Vertical" },
      --
      -- Git
      --
      -- { "<leader>g",  group = "git",                                      desc = "Git", },
      -- { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",                   desc = "Lazygit" },
      -- { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",      desc = "Next Hunk" },
      -- { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",      desc = "Prev Hunk" },
      -- { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",     desc = "Blame" },
      -- { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",   desc = "Preview Hunk" },
      -- { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",     desc = "Reset Hunk" },
      -- { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",   desc = "Reset Buffer" },
      -- { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",     desc = "Stage Hunk" },
      -- { "<leader>gu",
      -- 	"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      -- 	"Undo Stage Hunk",
      -- },
      -- { "<leader>go", "<cmd>Telescope git_status<cr>",   desc = "Open changed file" },
      -- { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
      -- { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Checkout commit" },
      -- { "<leader>gd",
      -- 	"<cmd>Gitsigns diffthis HEAD<cr>",
      -- 	"Diff",
      -- },
    },
  }
}
