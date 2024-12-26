local path = vim.fn.stdpath('config')

local present_path = path .. '/plugins/present.nvim'

return {
  {
    dir = present_path,
    config = function()
      require("present")
    end
  }
}
