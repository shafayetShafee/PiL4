-- PROBLEM DESCRIPTION

--[[
  Exercise 4.2: Suppose you need to write a long sequence of arbitrary bytes
  as a literal string in Lua. What format would you use? Consider issues
  like readability, maximum line length, and size.
--]]

--[[
  I would write in printable ascii character and for non printable character would use 
  hex code escape sequences like \xhh.

  And to make them readable would write probably 40 characters per line and separate
  them using Lua special (not quite though) escape sequence \z
--]]


long_byte_data = "These are non printable ascii char in hex code\z
                  \x00\x01\x02\x03\x04\x05\x06\x07\z
                  \x08\x09\x0A\x0B\x0C\x0D\x0E\x0F\z
                  \x20and these are printable one"

-- \x20 is the hex code for space, since \z will skip all until a nonspace char
-- we need this \x20 to make some space.

io.write(long_byte_data)