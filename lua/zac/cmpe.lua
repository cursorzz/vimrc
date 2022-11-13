local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.is_available = function()
  return true
  -- print(vim.bo.filetype)
  -- return vim.bo.filetype == "telekasten"
end

-- source.get_keyword_pattern = function()
--   return "*"
--   -- return [[\+]]
-- end

source.get_trigger_characters = function()
  return { "[[" }
end

source.complete = function(self, params, callback)
  local items = {
    { label = "ABC" },
    { label = "B" },
    { label = "C" }
  }

  callback { items = items }
end
-- local offset_0 = self:_invoke(vim.bo.omnifunc, { 1, '' })
-- if type(offset_0) ~= 'number' then
--   return callback()
-- end
-- local result = self:_invoke(vim.bo.omnifunc, { 0, string.sub(params.context.cursor_before_line, offset_0 + 1) })
-- if type(result) ~= 'table' then
--   return callback()
-- end
--
-- local items = {}
-- for _, v in ipairs(result) do
--   if type(v) == 'string' then
--     table.insert(items, {
--       label = v,
--     })
--   elseif type(v) == 'table' then
--     table.insert(items, {
--       label = v.abbr or v.word,
--       insertText = v.word,
--       labelDetails = {
--         detail = v.kind,
--         description = v.menu,
--       },
--     })
--   end
-- end
-- if params.offset < offset_0 + 1 then
--   local follow = string.sub(params.context.cursor_before_line, params.offset, offset_0)
--   for _, item in ipairs(items) do
--     if item.insertText then
--       item.insertText = follow .. item.insertText
--     end
--   end
-- end
-- callback({ items = items })

-- source._invoke = function(_, func, args)
--   local prev_pos = vim.api.nvim_win_get_cursor(0)
--   local _, result =
--   pcall(
--     function()
--       return vim.api.nvim_call_function(func, args)
--     end
--   )
--   local next_pos = vim.api.nvim_win_get_cursor(0)
--   if prev_pos[1] ~= next_pos[1] or prev_pos[2] ~= next_pos[2] then
--     vim.api.nvim_win_set_cursor(0, prev_pos)
--   end
--   return result
-- end

-- return source
print("start plugin")
require("cmp").register_source("zac", source.new())
