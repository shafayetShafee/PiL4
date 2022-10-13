-- PROBLEM DESCRIPTION
--[=[
  Exercise 4.1: How can you embed the following fragment of XML as a string
  in a Lua program?

  <![CDATA[
    Hello world
  ]]>

  Show at least two different ways.
--]=]


-- WAY 01 ------------------------------

local xml_fragment1 = [==[
<![CDATA[
   Hello world
]]>
]==]

io.write(xml_fragment1)



-- WAY 02 ------------------------------

local xml_fragment2 = "<![CDATA[\n  Hello world\n]]>\n"
io.write(xml_fragment2)