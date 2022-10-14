-- PROBLEM DESCRIPTION
--[[
  Exercise 4.9: Redo the previous exercise for UTF-8 strings.

  (Redo the previous exercise so that it ignores differences
  in spaces and punctuation.)
	
  (Write a function to check whether a given string is a
  palindrome)

  > ispali("step on no pets") --> true
  > ispali("banana") --> false  
--]]


function utf8_reverse(str)
	local reversed = ""
	for id, char in utf8.codes(str) do
		reversed = utf8.char(char) .. reversed
	end
	return reversed
end

function ispali(str)
	local str = str:gsub("[%s%p]", "")
	return str == utf8_reverse(str)
end



print(ispali("step on no pets"))
print(ispali("banana"))
print(ispali("was it a car or a cat i saw?"))
print(ispali("a man, a plan, a canal - panama"))
print(ispali("a man, a plan, a canal – panama"))
print(ispali("perica reže raci rep"))
print(ispali("edo suče meč usode."))
print(ispali("kapelniki že ne vedo ali bo dama dobila od eve nežikin lepak."))