local M            = {}

---@class present.Slides
---@fields slides string[]: slides of the file

--- Parse the slides from the file
---@param lines string[]: table
---@return present.Slides
local parse_slides = function(lines)
  local slides = {
    slides = {}
  }

  local current_slide = {}

  local separator = "^# (.+)$"

  for _, line in ipairs(lines) do
    print(line, "find:", line:find(separator), "|")
  end

  return slides
end

-- vim.print(parse_slides({
-- "# Slide 1",
-- "This is the first slide",
-- "# Slide 2",
-- "This is the second slide",
-- }))

--- Setup the present plugin
M.setup            = function()

end


return M
