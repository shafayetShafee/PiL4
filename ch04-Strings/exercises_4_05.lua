-- PROBLEM DESCRIPTION
--[[
  Exercise 4.5: Write a function to remove a slice from a string; the slice
  should be given by its initial position and its length:

  > remove("hello world", 7, 4) --> hello d
--]]


function remove(str, pos, len)
  -- if no len is supplied, assume 1 character
  -- if negative len is supplied, assume 0 character
  local len = len or 1
  local len = len < 0 and 0 or len
  local pos = pos % (#str + 1)
  local residual1 = str:sub(1, pos - 1)
  local residual2 = str:sub(pos + len, #str)
  return residual1 .. residual2
end

print(remove("hello world", 7, 4))       --> hello d
print(remove("hello world", 6, 6))       --> hello
print(remove("hello world", 6, 10))      --> hello
print(remove("hello world", 1, 6))       --> world
print(remove("hello world", 3, 2))       --> heo world
print(remove("hello world", 1))          --> ello world
print(remove("hello world", 1,-5))       --> hello world

-- negative index
print(remove("hello world", -1, 2))       --> hello worl
print(remove("hello world", -2, 2))       --> hello wor
print(remove("hello world", -9, 2))       --> heo world