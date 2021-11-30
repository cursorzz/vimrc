local function compare_pos(a, b)
  if a[1] < b[1] then
    return -1
  elseif a[1] == b[1] then
    return a[2] - b[2]
  else
    return 1
  end
end

Range = {
  start_pos = {0, 0}, -- lnum, col
  end_pos = {0, 0},
  content = "",
  length = 0,
  visual = false,
  matched = false,
  __lt = function(a, b)
    -- put(
    --   a.text_object,
    --   b.text_object,
    --   compare_pos(a.start_pos, b.start_pos),
    --   compare_pos(a.end_pos, b.end_pos),
    --   a.length < b.length
    -- )
    return (a.length < b.length) and not (compare_pos(a.start_pos, b.start_pos) < 0) and
      not (compare_pos(a.end_pos, b.end_pos) > 0)
  end,
  __eq = function(a, b)
    return compare_pos(a.start_pos, b.start_pos) == 0 and compare_pos(a.end_pos, b.end_pos) == 0 and
      a.length == b.length
  end
}

function Range:new(r)
  setmetatable(r, self)
  self.__index = self
  if r.visual then
    r:get_length()
  end
  return r
end

function Range:get_length()
  local start_pos = self.start_pos
  local end_pos = self.end_pos
  self.length = 0
  self.content = ""
  local lines
  if start_pos[1] == end_pos[1] then
    lines = {vim.fn.getline(start_pos[1])}
  else
    lines = vim.fn.getline(start_pos[1], end_pos[1])
  end
  if #lines == 1 then
    lines = {lines[1]:sub(start_pos[2], end_pos[2])}
  else
    lines[1] = lines[1]:sub(start_pos[2])
    lines[#lines] = lines[#lines]:sub(1, end_pos[2])
  end
  for _, line in ipairs(lines) do
    self.length = self.length + line:len()
    self.content = self.content .. line
  end
end

return Range
