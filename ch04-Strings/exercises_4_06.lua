-- PROBLEM DESCRIPTION
--[[
  Exercise 4.6: Redo the previous exercise for UTF-8 strings:
  (Exercise 4.5: Write a function to remove a slice from a string; the slice
  should be given by its initial position and its length)

  > remove("ação", 2, 2) --> ao

  (Here, both the initial position and the length should be counted in
  codepoints.)

--]]


function usub(...)
  return utf8.char(utf8.codepoint(...))
end

local offset = utf8.offset

function remove(str, pos, len)
  -- if no len is supplied, assume 1 character
  -- if negative len is supplied, assume 0 character
  len = len or 1
  len = len < 0 and 0 or len
  local size = offset(str, utf8.len(str))
  local byte_pos1 = offset(str, pos)
  byte_pos1 = byte_pos1 == nil and (size + 1) or byte_pos1
  local byte_pos2 = offset(str, byte_pos1 + len)
  local part1 = usub(str, 1, byte_pos1 - 1)
  local part2 = byte_pos2 == nil and "" or usub(str, byte_pos2, size)
  return part1 .. part2
end

print(remove("ação", 2))                  --> aão
print(remove("ÃøÆËÐ", 1, 1))              --> øÆËÐ
print(remove("ÃøÆËÐ ÃøÆËÐ", 6, 5))        --> ÃøÆËÐÐ
print(remove("ação ÃøÆËÐ", 5, 10))        --> ação
print(remove("ação ÃøÆËÐ", 1, 4))         --> ÃøÆËÐ
print(remove("ação ÃøÆËÐ", 2, 2))         --> ao ÃøÆËÐ
print(remove("hello ÃøÆËÐ", 1))           --> ello ÃøÆËÐ
print(remove("hello ÃøÆËÐ", 1,-5))        --> hello ÃøÆËÐ
print(remove("hello ÃøÆËÐ", 15,2))        --> hello ÃøÆËÐ

-- negative index
print(remove("ação ÃøÆËÐ", -1, 2))       --> ação ÃøÆË
print(remove("ação ÃøÆËÐ", -2, 2))       --> ação ÃøÆ
print(remove("ação ÃøÆËÐ", -10, 2))       --> ão ÃøÆËÐ
