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

  -- vim.cmd("sil! norm! <ESC>v<ESC>v")
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
--
function M.expand_v2()
  local mode = vim.fn.mode()

  local matches = {{'"', '"'}, {"'", "'"}, {"(", ")"}, {"[", "]"}, {"{", "}"}}

  local origin_node = ts.get_node_at_cursor()

  local found = false
  local matched = nil
  local matched_pair = nil
  local node = nil

  if mode == "v" then
    node = origin_node

    put("=========================")

    while node:type() ~= "chunk" and not found do
      if node:id() ~= origin_node:id() and not node_equal(node, origin_node) then
        local node_start, node_end = get_node_type(node)
        for _, pair in ipairs(matches) do
          local start_symbol, end_symbol = unpack(pair)

          if node_start == start_symbol and node_end == end_symbol then
            found = true
            matched_pair = pair
            matched = node
            break
          end
        end
      end
      node = node:parent()
    end
  else
    node = origin_node
    while node:type() ~= "chunk" and not found do
      -- if node:id() ~= origin_node:id() then
      local node_start, node_end = get_node_type(node)
      put("checking node ", node:type(), node:named(), get_node_content(node))
      for _, pair in ipairs(matches) do
        local start_symbol, end_symbol = unpack(pair)

        if node_start == start_symbol and node_end == end_symbol then
          put("found match ", pair)
          found = true
          matched_pair = pair
          matched = node
          break
        end
      end
      -- end
      node = node:parent()
    end
  end

  -- put(get)

  if matched ~= nil then
    if mode == "v" then
      put("in visual", get_node_content(matched))
      exec("normal! <Esc>")
      update_selection(node_to_range(matched))
    else
      update_selection(get_node_inner(matched, matched_pair))
    end
  -- put(get_node_content(matched))
  end
end

function handle_special_case_for_bracket()
end

function get_node_content(node)
  local start_row, start_col, end_row, end_col = node:range()
  -- put("node is ", node:type(), node:named())
  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
end

function get_node_type(node)
  local start_row, start_col, end_row, end_col = node:range()
  -- put("node is ", node:type(), node:named())
  local buf = vim.api.nvim_get_current_buf()
  local content = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
  -- put("content is", content)
  local last_line = content[#content]
  return string.sub(content[1], 1, 1), string.sub(last_line, #last_line, #last_line)
end

function get_node_inner(node, matched_pair)
  -- TODO 可以利用到 node
  local total = node:named_child_count()
  local start_row, start_col, _ = node:named_child(0):start()
  local end_row, end_col, _ = node:named_child(total - 1):end_()

  return Range:new(
    {
      start_pos = {start_row + 1, start_col + 1},
      end_pos = {end_row + 1, end_col}
    }
  )
  -- local start_symbol, end_symbol = unpack(matched_pair)
  -- put("sdfdsf", start_symbol, end_symbol)
  -- local start_row, start_col, end_row, end_col = node:range()
  -- local contents = get_node_content(node)
  -- if #contents == 1 then
  --   -- just one line
  --   --
  --   local left_content = string.sub(contents[1], #start_symbol + 1, -(#end_symbol + 1))
  --   if #left_content > 0 then
  --     start_col = start_col + #start_symbol
  --     end_col = end_col - #end_symbol
  --   else
  --     start_col = start_col + #start_symbol
  --     end_col = start_col
  --   end
  -- else
  --   if contents[1] == start_symbol then
  --     start_row = start_row + 1
  --     start_col = 0
  --   end
  --
  --   if contents[#contents] == end_symbol then
  --     end_row = end_row - 1
  --     end_col = #contents[#contents - 1]
  --   end
  -- end
  -- return Range:new(
  --   {
  --     start_pos = {start_row + 1, start_col + 1},
  --     end_pos = {end_row + 1, end_col}
  --   }
  -- )
end



function node_equal(nodeA, nodeB)
  local a_s_row, a_s_col, a_e_row, a_e_col = nodeA:range()
  local b_s_row, b_s_col, b_e_row, b_e_col = nodeB:range()

  return a_s_row == b_s_row and a_s_col == b_s_col and a_e_row == b_e_row and a_e_col and b_e_col
end

function get_node_content(node)
  put(node:range())
  local start_row, start_col, end_row, end_col = node:range()

  local buf = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
end

function node_to_range(node)
  local start_row, start_col, end_row, end_col = node:range()
  put("range is ", node:range())
  return Range:new(
    {
      start_pos = {start_row + 1, start_col + 1},
      end_pos = {end_row + 1, end_col}
    }
  )
end

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

function M._get_selected_node(range)
  local node = ts.get_node_at_cursor()
  local node_range = node_to_range(node)
  while node_range < range do
    node = node:parent()
    node_range = node_to_range(node)
  end
end

return M
