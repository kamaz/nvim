local state = {
  floating = {
    buf = -1,
    win = -1
  }
}

local function create_centered_float(opts)
  opts = opts or {}

  local outer_width = vim.o.columns
  local outer_height = vim.o.lines

  -- Calculate window size (80% of screen)
  local win_height = opts.height or math.floor(outer_height * 0.8)
  local win_width = opts.width or math.floor(outer_width * 0.8)

  -- Calculate starting position to center the window
  local row = math.floor((outer_height - win_height) / 2)
  local col = math.floor((outer_width - win_width) / 2)

  -- Create the buffer for the floating window
  local buf = opts.buf
  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Configure the window options
  local config = {
    relative = 'editor',
    row = row,
    col = col,
    width = win_width,
    height = win_height,
    style = 'minimal',
    border = 'rounded'
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_centered_float({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.termina()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create a command to open the floating window
vim.api.nvim_create_user_command('Termy', toggle_terminal, {})
vim.keymap.set("n", "<leader>tt", toggle_terminal, { desc = "Toggle terminal" })
