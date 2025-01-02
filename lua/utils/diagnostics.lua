M = {}

function M.setup_diagnostics()
  local diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      -- prefix
    },
    severity_sort = true,
    -- todo: check if we really need it
    -- signs = {
    --   text = {
    --     [vim.diagnostic.severity.ERROR] = TODO: "icon",
    --     [vim.diagnostic.severity.WARN] = TODO: "icon",
    --     [vim.diagnostic.severity.HINT] = TODO: "icon",
    --     [vim.diagnostic.severity.INFO] = TODO: "icon"
    --   },
    -- },
  }

  vim.diagnostic.config(vim.deepcopy(diagnostics))

  require("config.keymaps").diagnostics()
end

return M
