local function deactivate_python_venv()
  vim.env.VIRTUAL_ENV = nil
  require("venv-selector").deactivate()
end

local function activate_python_venv()
  if vim.env.VIRTUAL_ENV ~= nil then
    require("venv-selector").activate_from_path(vim.env.VIRTUAL_ENV)
  elseif vim.fn.isdirectory(".venv") == 1 then
    local venv_path = vim.fn.getcwd() .. "/.venv"
    vim.env.VIRTUAL_ENV = venv_path
    require("venv-selector").activate_from_path(venv_path)
  end
end

local function delete_hidden_buffers()
  local visible = {}
  for _, win in pairs(vim.api.nvim_list_wins()) do
    visible[vim.api.nvim_win_get_buf(win)] = true
  end
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if not visible[buf] then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

return {
  {
    "rmagatti/auto-session",
    lazy = false,
    enabled = true,
    dependencies = {
      "linux-cultist/venv-selector.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = function(_, opts)
      opts = opts or {}

      opts.pre_save_cmds = {
        delete_hidden_buffers,
      }

      opts.pre_restore_cmds = {
        deactivate_python_venv,
      }

      opts.post_restore_cmds = {
        activate_python_venv,
      }

      opts.session_lens = {
        load_on_setup = true,
        previewer = false,
      }
    end,
    config = function(_, opts)
      vim.opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
      require("auto-session").setup(opts)
    end,
    keys = require("config.keymaps").auto_session(),
  },
}
