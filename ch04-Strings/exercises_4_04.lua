-- PROBLEM DESCRIPTION
--[[
  Exercise 4.4: Redo the previous exercise for UTF-8 strings:

  > insert("ação", 5, "!") --> ação!
  
  (Note that the position now is counted in codepoints.)
--]]


function usub(...)
  return utf8.char(utf8.codepoint(...))
end


function insert(str, pos, ins)
  local size = utf8.len(str)
  -- negative index is handled by automatically by 
  -- utf8.offset
  local byte_pos = utf8.offset(str, pos)
  local pre = usub(str, 1, byte_pos - 1)
  local post = usub(str, byte_pos, utf8.offset(str, size))
  return pre .. ins .. post
end


-- testing
print(insert('açáo', 5, "!"))
print(insert('résumé', 1, 'test ')) 

print(insert("ação résumé", 1, "start: "))
print(insert("ação résumé", 6, "Månen "))
print(insert("ação résumé", 5, ","))

-- testing a few extra with negative index
print(insert("ação résumé", -6, "Månen "))
print(insert("ação résumé", -1, "!"))
print(insert("ação résumé", -7, ","))
