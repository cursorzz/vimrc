local ts = require("nvim-treesitter.ts_utils")
local M = {
  candidates = {"i]", 'i"', "i'", "i)", "it", "i}", "i>"}
}

local function t(str)
  -- Adjust boolean arguments as needed
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local exec = function(cmd)
  vim.api.nvim_exec(t(cmd), true)
end
local puts = function(...)
  print(vim.inspect({...}))
end

M.__index = M
-- nagative means a < b.  0 means a == b
function compare_pos(a, b)
  if a[1] < b[1] then
    return -1
  elseif a[1] == b[1] then
    return a[2] - b[2]
  else
    return 1
  end
end

local function in_visual_mode(m)
  local mode = vim.fn.mode()
  return mode == "v"
end

Range = {
  start_pos = {0, 0}, -- line, column
  end_pos = {0, 0},
  content = "",
  length = 0,
  __lt = function(a, b)
    return compare_pos(a.start_pos, b.start_pos) > 0 and compare_pos(a.end_pos, b.end_pos) < 0
  end,
  __eq = function(a, b)
    return compare_pos(a.start_pos, b.start_pos) == 0 and compare_pos(a.end_pos, b.end_pos) == 0
  end
}

function Range:new(r)
  setmetatable(r, Range)
  return r
end

local function do_expand(text_object)
  -- exec("normal! v")
  exec("normal! v" .. text_object)
  -- exec("normal! gv")
end

function get_selection_length(start_pos, end_pos)
  if vim.deep_equal(start_pos, end_pos) then
    return "", 0
  end
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  local length = 0
  if #lines == 1 then
    lines = {lines[1]:sub(start_pos[3], end_pos[3])}
  else
    lines[1] = lines[1]:sub(start_pos[3])
    lines[#lines] = lines[#lines]:sub(1, end_pos[3])
  end
  local content = ""
  for _, line in ipairs(lines) do
    length = length + line:len()
    content = content .. line
  end
  return content, length
end

-- [(sdfsdfsdf)]

function M.expand(mode)
  M.mode = mode
  local shortest = nil
  local selection = M.get_current_visual_selection()
  if selection == nil then
    selection = M.get_cursor_position()
  end
  for _, v in ipairs(M.candidates) do
    local result = M.get_best_match(selection, v)
    if result ~= nil then
      if shortest == nil then
        shortest = result
      elseif result.length ~= 0 and shortest.length > result.length then
        shortest = result
      end
    end
  end
  if shortest ~= nil then
    do_expand(shortest.text_object)
  else
    -- if M.mode == "v" then
    --   exec("normal! gv")
    -- end
  end
end

--- [ [123123] ]
function M.get_best_match(selection, text_object)
  local count = 1
  local continue = true
  local result
  while continue do
    result = M.get_candidate_dict(text_object, count)
    if count == 100 then
      puts(result)
      puts(selection)
      continue = false
    end
    if result.length == 0 then
      result = nil
      continue = false
    elseif result > selection then
      continue = false
    elseif result == selection then
      next_try = M.get_candidate_dict(text_object, count + 1)
      if next_try == result then
        -- not increase anymore
        result = nil
        continue = false
      else
        count = count + 1
      end
    else
      count = count + 1
    end
  end
  return result
end

function M.get_candidate_dict(text_object, count)
  local saved_window = vim.fn.winsaveview()
  -- if M.mode == "v" then
  --   exec(t("normal! <C-u>"))
  -- end
  exec("sil! norm! <ESC>v<ESC>v")
  -- exec("normal! v")
  -- end
  exec("normal! " .. count .. text_object)
  exec("normal! <Esc>")

  local result = M.get_visual_selection()
  result["text_object"] = count .. text_object
  M._get_selected_node(result)
  vim.fn.winrestview(saved_window)
  return result
end

function M.get_current_visual_selection()
  if M.mode ~= "v" then
    return
  end
  return M.get_visual_selection()
end

function M.get_cursor_position()
  local pos = vim.api.nvim_win_get_cursor(0)
  return Range:new({start_pos = pos, end_pos = pos})
end

function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local content, length = get_selection_length(start_pos, end_pos)

  return Range:new {
    start_pos = {start_pos[2], start_pos[3]},
    end_pos = {end_pos[2], end_pos[3]},
    length = length,
    content = content
  }
end

function node_to_range(node)
  local start_row, start_col, end_row, end_col = node:range()
  return Range:new(
    {
      start_pos = {start_row, start_col},
      end_pos = {end_row, end_col}
    }
  )
end

function M._get_selected_node(range)
  local node = ts.get_node_at_cursor()
  local node_range = node_to_range(node)
  while node_range < range do
    node = node:parent()
    node_range = node_to_range(node)
  end
  puts(node_range)

  -- local parser = vim.treesitter.get_parser(0):parse()
  -- if #parser > 0 then
  -- local root_node = parser[1]:root()
  -- return root_node:descendant_for_range(range.start_pos[1], range.start_pos[2], range.end_pos[1], range.end_pos[2]):range(
  -- )
  -- end
end

M.in_visual_mode = in_visual_mode

return M
