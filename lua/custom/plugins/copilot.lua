return {
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    enabled = true,
    dependencies = {
      {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
          local function codepilot()
            local icon = require("theme.icons").icons.kinds.Copilot
            return icon
          end

          local colors = {
            ["Normal"] = require("theme.colors").fgcolor("Special"),
            ["Warning"] = require("theme.colors").fgcolor("DiagnosticError"),
            ["InProgress"] = require("theme.colors").fgcolor("DiagnosticWarn"),
            ["Offline"] = require("theme.colors").fgcolor("Comment"),
            ["Error"] = require("theme.colors").fgcolor("Error"),
          }

          opts.copilot = {
            lualine_component = {
              codepilot,
              color = function()
                if not package.loaded["copilot"] or vim.g.custom_copilot_status == "disabled" then
                  -- offline
                  return colors["Offline"]
                else
                  -- online
                  local status = require("copilot.api").status
                  if status.data.status ~= "" or status.data.message ~= "" then
                    return colors[status.data.status] or colors["Error"]
                  else
                    return colors["InProgress"]
                  end
                end
              end,
            },
          }
        end,
      },
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-y>",
          accept_word = false,
          accept_line = false,
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
    keys = require("config.keymaps").ai_copilot(),
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = true,
    event = "VeryLazy",
    enabled = true,
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false, -- Enable debugging
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      -- NOTE: cmp is disabled
      -- require("CopilotChat.integrations.cmp").setup()
    end,
    keys = require("config.keymaps").ai_copilot_chat(),
  },
}

