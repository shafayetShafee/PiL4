-- PROBLEM DESCRIPTION

--[[
  Exercise 4.3: Write a function to insert a string into a given position
  of another one:

  > insert("hello world", 1, "start: ") --> start: hello world
  > insert("hello world", 7, "small ") --> hello small world
--]]


function insert(str, pos, ins)
	--[[ 
		If the position is positive 
	      then use that position as is
	    else if that position is negative
	      then 
	      	if position is equal to -1
	      	  then use (given-string-length + 1) as index
	      	else use position + 1
	--]]
	idx = pos > 0 and pos or (pos == -1 and (#str + 1) or (pos + 1))
	return str:sub(1, idx - 1) .. ins .. str:sub(idx, #str)
end


-- testing

print(insert("hello world", 1, "start: "))            --> start: hello world
print(insert("hello world", 7, "small "))             --> hello small world

print(insert("hello world", -6, "inserted "))     	  --> hello inserted world
print(insert("hello world", -1, "!"))                 --> hello world!

print(insert("hello world", -7, ","))                 --> hello, world
print(insert("hello world", 6, ","))                  --> hello, world