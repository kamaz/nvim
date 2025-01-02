-- [[
-- Undotree visualizes the undo history and makes it easy to browse and switch between different undo branches. You may be wondering, what are undo "branches" anyway? They're a feature of Vim that allow you to go back to a prior state even after it has been overwritten by later edits.
-- ]]
return {
  {
    "mbbill/undotree",
    lazy = true,
    cmd  = "UndotreeToggle",
    keys = require("config.keymaps").undotree(),
  },
}
