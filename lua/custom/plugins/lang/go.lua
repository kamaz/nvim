local tags = "-tags=wireinject,integration"

return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    ft = { "go", "gomod", "gosum", "gowork" },
    opts = {
      ensure_installed = { "go", "gomod", "gosum", "gowork" },
    },
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    ft = { "go", "gomod", "gowork" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "gofumpt", "goimports", "gci", "golines" })
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gci", "gofumpt", "golines" },
      },
      formatters = {
        goimports = {
          -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/goimports.lua
          args = { "-srcdir", "$FILENAME" },
        },
        gci = {
          -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/gci.lua
          args = {
            "write",
            "--skip-generated",
            "-s",
            "standard",
            "-s",
            "default",
            "--skip-vendor",
            "$FILENAME",
          },
        },
        gofumpt = {
          -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/gofumpt.lua
          prepend_args = { "-extra", "-w", "$FILENAME" },
          stdin = false,
        },
        golines = {
          -- https://github.com/stevearc/conform.nvim/blob/master/lua/conform/formatters/golines.lua
          -- NOTE: golines will use goimports as base formatter by default which can be slow.
          -- see https://github.com/segmentio/golines/issues/33
          prepend_args = { "--base-formatter=gofumpt", "--ignore-generated", "--tab-len=1", "--max-len=120" },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    ft = { "go", "gomod", "gowork", "gosum" },
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = function(_, opts)
              opts.ensure_installed = opts.ensure_installed or {}
            end,
          },
        },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, {
            "gopls",
          })
        end,
      },
    },
    opts = function(_, opts)
      local go_opts = {
        servers = {

          gopls = {
            filetypes = { "go", "gomod", "gowork", "gosum" },

            -- main readme: https://github.com/golang/tools/blob/master/gopls/doc/features/README.md
            --
            -- for all options, see:
            -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
            -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            -- for more details, also see:
            -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
            -- https://github.com/golang/tools/blob/master/gopls/README.md
            settings = {

              -- NOTE: the gopls defaults will apply if not overridden here.
              gopls = {
                buildFlags = { tags },
                -- env = {},
                -- analyses = {
                --   -- https://github.com/golang/tools/blob/master/gopls/internal/settings/analysis.go
                --   -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
                -- },
                -- codelenses = {
                --   -- https://github.com/golang/tools/blob/master/gopls/doc/codelenses.md
                --   -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                -- },
                -- hints = {
                --   -- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
                --   -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                --   --
                --   -- parameterNames = true,
                --   -- assignVariableTypes = true,
                --   -- constantValues = true,
                --   -- compositeLiteralTypes = true,
                --   -- compositeLiteralFields = true,
                --   -- functionTypeParameters = true,
                -- },
                -- completion options
                -- https://github.com/golang/tools/blob/master/gopls/doc/features/completion.md
                -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go

                -- build options
                -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#build
                directoryFilters = {
                  "-**/node_modules",
                  "-**/.git",
                  "-.vscode",
                  "-.idea",
                  "-.vscode-test",
                },

                -- formatting options
                -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                gofumpt = false, -- handled by conform instead.

                -- ui options
                -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                semanticTokens = false, -- disabling this enables treesitter injections (for sql, json etc)

                -- diagnostic options
                -- https://github.com/golang/tools/blob/master/gopls/internal/settings/settings.go
                staticcheck = true,
                vulncheck = "imports",
                analysisProgressReporting = true,
              },
            },
          },
        },
      }
      return require("utils.table").deep_merge(opts, go_opts)
    end,
  },

  {
    "maxandron/goplements.nvim",
    lazy = true,
    ft = "go",
    opts = {},
  },

  {
    "ray-x/go.nvim",
    lazy = true,
    ft = { "go", "gomod" },
    enabled = false,
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_cfg = false, -- handled with nvim-lspconfig instead
        lsp_inlay_hints = {
          enable = false, -- handled with LSP keymap toggle instead
        },
        dap_debug = false, -- handled by nvim-dap instead
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    ft = { "go" },
    dependencies = {
      { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
    },

    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-golang"] = {
        go_list_args = { tags },
        go_test_args = {
          "-v",
          "-count=1",
          "-race",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
          -- "-p=1",
          "-parallel=1",
          tags,
        },
        runner = "gotestsum",
        gotestsum_args = { "--format=standard-verbose" },
        log_level = vim.log.levels.WARN,

        -- experimental
        dev_notifications = true,
      }
    end,
  },

  {
    "andythigpen/nvim-coverage",
    lazy = true,
    ft = { "go" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- https://github.com/andythigpen/nvim-coverage/blob/main/doc/nvim-coverage.txt
      auto_reload = true,
      lang = {
        go = {
          coverage_file = vim.fn.getcwd() .. "/coverage.out",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    ft = { "go" },
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          "williamboman/mason.nvim",
        },
        opts = {
          ensure_installed = { "delve" },
        },
      },
      {
        -- TODO: try to configure this so the virtual text is helpful.
        "theHamsta/nvim-dap-virtual-text",
        enabled = false,
      },
      {
        "leoluz/nvim-dap-go",
        opts = {
          dap_configurations = {
            {
              type = "go",
              name = "Debug opened file's cmd/cli",
              request = "launch",
              cwd = "${fileDirname}", -- FIXME:  should work from repo root
              program = "./${relativeFileDirname}",
              args = {},
            },
          },
        },
        config = function(_, opts)
          require("dap-go").setup(opts)
        end,
      },
    },
    opts = {
      configurations = {
        go = {
          -- See require("dap-go") source for full dlv setup.
          {
            type = "go",
            name = "Debug test (manually enter test name)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
            args = function()
              local testname = vim.fn.input("Test name (^regexp$ ok): ")
              return { "-test.run", testname }
            end,
          },
        },
      },
    },
  },

  {
    "CRAG666/code_runner.nvim",
    lazy = true,
    opts = {
      filetype = {
        go = {
          "go run",
        },
      },
    },
  },
}
