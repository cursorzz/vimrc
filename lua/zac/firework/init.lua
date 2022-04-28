function _G.put(...)
  vim.pretty_print(...)
  -- local objects = vim.tbl_map(vim.inspect, {...})
  -- print(unpack(objects))
  -- local objects = {init}
  -- for i = 1, select("#", ...) do
  --   local v = select(i, ...)
  --   table.insert(objects, vim.inspect(v))
  -- end
  --
  -- print(table.concat(objects, " "))
  -- return ...
end

local exec = require("zac.firework.utils").exec
local t = require("zac.firework.utils").t
-- require("./utils")
local ts = require("nvim-treesitter.ts_utils")
local Range = require("zac.firework.range")
-- local logger = require("./log")
local M = {
  candidates = {"i]", "i[", 'i"', "i'", "i)", "it", "i}", "i>", "i`"}
  -- candidates = {"i)"}
}

function M.setup(config)
  put(config)
end
-- M.__index = M

-- nagative means a < b.  0 means a == b

local function update_selection(range)
  local start_row, start_col = unpack(range.start_pos)
  local end_row, end_col = unpack(range.end_pos)

  local buf = vim.api.nvim_get_current_buf()

  vim.fn.setpos(".", {buf, start_row, start_col, 0})
  local mode_string = vim.api.nvim_replace_termcodes("v", true, true, true)
  vim.cmd("normal! " .. mode_string)
  vim.fn.setpos(".", {buf, end_row, end_col, 0})
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

-- [(s)]

function M.expand()
  local mode = vim.fn.mode()
  put("this is mode sssss ", mode)
  local shortest = nil
  local selection = M.get_current_visual_selection()
  if selection == nil then
    selection = M.get_cursor_position()
  end
  -- put("(*", selection)
  for _, v in ipairs(M.candidates) do
    local result = M.get_best_match(selection, v)
    if result ~= nil then
      put(result)
      -- if result.length > selection.length
      if shortest == nil then
        shortest = result
      else
        -- ((0 ))
        if result.length ~= 0 and result.length < shortest.length then
          shortest = result
        end
      end
    end
  end

  put(shortest)
  if shortest ~= nil then
    -- put(shortest)
    update_selection(shortest)
  else
    -- put("sdfdsf", selection, )
    if mode == "v" then
      update_selection(selection)
    end
  end
end

--- [ [123123] ]
function M.get_best_match(selection, text_object)
  local count = 1
  local result
  -- put("selection", selection.start_pos)
  -- (0)
  while true do
    result = M.get_candidate_dict(text_object, count)
    -- put(result)

    if result.matched then
      if result > selection then
        -- put(result.content, result.text_object)
        break
      end
      if result == selection then
        next_try = M.get_candidate_dict(text_object, count + 1)
        if next_try == result then
          break
        -- not increase anymore
        end
      end
      count = count + 1
    else
      result = nil
      break
    end
  end
  -- if result ~= nil then
  -- put("**********", result)
  -- end
  return result
end

function M.get_candidate_dict(text_object, count)
  local saved_window = vim.fn.winsaveview()
  exec("sil! norm! <ESC>v<ESC>v")
  exec("normal! " .. count .. text_object)
  exec("normal! <Esc>")

  local result = M.get_visual_selection()
  result["text_object"] = count .. text_object

  exec("sil! norm! <ESC>v<ESC>v")
  exec("normal! " .. count .. text_object:gsub("i", "a"))
  exec("normal! <Esc>")
  local outer_result = M.get_visual_selection()
  outer_result["text_object"] = count .. text_object:gsub("i", "a")

  -- put("***********", result, outer_result)

  -- M._get_selected_node(result)
  vim.fn.winrestview(saved_window)

  if result ~= outer_result then
    result.matched = true
  end
  return result
end

function M.get_current_visual_selection()
  if M.mode ~= "v" then
    return
  end
  return M.get_visual_selection(text_object)
end

-- parameters variable_list string bracket_index_expression>field table_constructor

function M.get_cursor_position()
  local pos = vim.api.nvim_win_get_cursor(0)
  pos[2] = pos[2] + 1
  local range = Range:new({start_pos = pos, end_pos = pos})
  range.length = 0
  return range
end

function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local range =
    Range:new(
    {
      start_pos = {start_pos[2], start_pos[3]},
      end_pos = {end_pos[2], end_pos[3]},
      visual = true
    }
  )

  return range
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
end

return M
