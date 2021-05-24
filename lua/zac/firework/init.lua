local M = {
  expands = {'i(', 'i]'};
}

local exec = vim.api.nvim_exec
local puts = function(whatever)
  print(vim.inspect(whatever))
end

function get_selection_length(start_pos, end_pos)
  lines = vim.fn.getline(start_pos[2], end_pos[2])
  lines[1] = lines[1]:sub(start_pos[3])
  lines[#lines] = lines[#lines]:sub(1, end_pos[3])
  length = 0
  for i, line in ipairs(lines) do
    length = length + line:len()
  end
  return length
end

function M.expand()

  shortest = nil
  for _, v in ipair(M.expand) do
    result = M.get_candidate_dict(v)
    if shortest == nil or shortest.length > result.length
      shortest = result
    end
  end
end

function do_expand()
end

function M.get_candidate_dict(text_object)
  saved_window = vim.fn.winsaveview()
  exec('normal! v', false)
  exec('silent! normal '.. text_object, false)
  exec([[normal! \<Esc>]], false)

  result = M.get_visual_selection()
  result["text_object"] = text_object
  puts(result)
  vim.fn.winrestview(saved_window)
  return result
end


function M.get_visual_selection()
  start_pos = vim.fn.getpos("'<")
  end_pos = vim.fn.getpos("'>")

  return {
    start_pos = {start_pos[2], start_pos[3]},
    end_pos = {end_pos[2], end_pos[3]},
    length = get_selection_length(start_pos, end_pos)
  }
end

return M
