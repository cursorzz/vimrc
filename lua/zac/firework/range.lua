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
  setmetatable(r, self)
  self.__index = self
  self.get_length()
  return r
end

function Range:get_length()
  local start_pos = self.start_pos
  local end_pos = self.end_pos
  if vim.deep_equal(start_pos, end_pos) then
    self.length = 0
  end
  self.length = 0
  self.content = ""

  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  if #lines == 1 then
    lines = {lines[1]:sub(start_pos[3], end_pos[3])}
  else
    lines[1] = lines[1]:sub(start_pos[3])
    lines[#lines] = lines[#lines]:sub(1, end_pos[3])
  end
  for _, line in ipairs(lines) do
    self.length = self.length + line:len()
    self.content = self.content .. line
  end
end

return Range

-- 我想初始化 range 时填写起始位置和结束位置后，就能得到
-- 自身的长度
-- 是否和其它range重合
-- 以及计算外一层的位置，另一个range？
--
-- 如何测试， 在v模式下调用按键打印对应的值
