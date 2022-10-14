-- PROBLEM DESCRIPTION
--[[
  Exercise 4.8: Redo the previous exercise so that it ignores differences
  in spaces and punctuation.
	
  (Write a function to check whether a given string is a
  palindrome)

  > ispali("step on no pets") --> true
  > ispali("banana") --> false

--]]


function ispali(str)
	-- %p: This is a special sequence which matches all punctuation characters.
	-- %s: This is a special sequence which matches all whitespace characters.
	local str = str:gsub("[%s%p]", "")
	return str == str:reverse()
end

print(ispali("step on no pets"))                  --> true
print(ispali("banana"))                           --> false
print(ispali("was it a car or a cat i saw?"))     --> true
print(ispali("a man, a plan, a canal - panama"))  --> true    (minus character is okay)