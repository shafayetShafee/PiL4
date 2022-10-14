-- PROBLEM DESCRIPTION
--[[
  Exercise 4.7: Write a function to check whether a given string is a
  palindrome:

  > ispali("step on no pets") --> true
  > ispali("banana") --> false

--]]


function ispali(str)
	return str == str:reverse()
end


print(ispali("step on no pets"))  --> true
print(ispali("banana"))           --> false