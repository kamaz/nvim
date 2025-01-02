local sql_ft = { "sql", "mysql", "plsql" }

return {

  {
    "jsborjesson/vim-uppercase-sql",
    lazy = true,
    ft = sql_ft,
  },

  {
    "tpope/vim-dadbod",
    lazy = true,
    enabled = true,
    dependencies = {
      { "kristijanhusak/vim-dadbod-ui" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
    config = function()
      vim.g.db_ui_save_location = "~/code/dbui"
      vim.g.db_ui_tmp_query_location = "~/code/queries"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_execute_on_save = false
      vim.g.db_ui_use_nvim_notify = true
    end,
    cmd = { "DBUI", "DBUIFindBuffer" },
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    ft = sql_ft,
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.api.nvim_create_autocmd("dadbod", {
        filetypes = sql_ft,
        callback = function()
          require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
        end
      }
      )
    end
  },
}
