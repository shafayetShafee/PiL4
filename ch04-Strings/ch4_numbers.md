# 4 Strings

Strings in `Lua` are immutable objects. We cannot change a character inside a string as we can change in `C`. But we can create new string with desired modifications.

```
a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)
```
one string
another string

String in `Lua` are subjected to automatic memory handling, that means, we don't have to worry about memory allocation, deallocation. SO GARBAGE COLLECTION IS AUTOMATIC IN `LUA`.

## String Length

To get the length of a string we use `#"string"` syntax. But `Lua` counts the length in bytes which is not same as the numbers of chars in some encoding.

```
a = "hello"
print(#a)
print(#"Good bye")
print(#"爸爸")
```

5
8
6

## String Concatenation

We can concatenate two strings in `Lua` using `..` syntax. `Lua` converts the numbers to strings before concatenation.

```
greet = "hello " .. "world"
print(greet)
print("results is " .. 3)
```

hello world
results is 3

This concatenation operator creates new strings, since strings are immutable objects.

## Long Strings

String Literals in the bracketed form do not interpret the escape sequences. Moreover it ignores the first character when it is newline `\n`.

```
page = [[
<html>
<head>
  <title>AN HTML Page</title>
</head>
<body>
  <a href="#">Lua</a>
</body>
</html>
]]

io.write(page)
```
```
<html>
<head>
  <title>AN HTML Page</title>
</head>
<body>
  <a href="#">Lua</a>
</body>
</html>
```

But if the literal strings itself contains `]]`, we need to use `=` signs in between brackets like `[==[` and `]==]`

```
page = [==[
<html>
<head>
  <title>AN HTML Page</title>
</head>
<body>
  <a href="#">Lua</a>
</body>
</html>
a = b[c[i]]
]==]

io.write(page)
```
```
<html>
<head>
  <title>AN HTML Page</title>
</head>
<body>
  <a href="#">Lua</a>
</body>
</html>
a = b[c[i]]
```

## String Coercions

Lua provides automatic conversion between numbers and strings.

- **Any numeric operation applied to string tries to convert the string into numerals.**
- **Conversely whenever Lua finds numbers where it expects strings it converts the number to string.**

```
a = "3" + 4
print(type(a))
print(a)
```
> number
7

```
a = 10 .. 5
print(a)
print(type(a))
```
> 105
string

**But we need to be careful about using `..` with numbers, we must separate numbers and `..` with space**

But it's wise not to count on this. Instead we can be explicit.

```
print(tonumber(" -3 "))
print(tonumber(" 10e5 "))
```
> -3
1000000

```
print(tostring(10) == "10")
true
```

Unlike arithmatic operators, order operators never do automatic coercion. `2 < 15` is obviously `true`, but `"2" < "15"` is false, because of alphabetical order. But 2 < "15" will raise error.

```
2 < "15"
stdin:1: attempt to compare number with string
stack traceback:
    stdin:1: in main chunk
```

## The String Library

**The string library assumes one-byte characters.** This equivalence is true for several encodings (e.g. ASCII, ISO-8859-1).

```
string.len()
string.rep()
string.reverse()
string.lower()
string.upper()
```
They does what you think they does.

String indexing is same as `R` in `Lua`. `string.sub(s, i, j)` extract a string `s` from ith char to jth char inclusive. Indexing starts from 1, 2,  so on and -1 index means the last char, same as `R`.

```
s = "[in brackets]"
string.sub(s, 2, -2)
```
> in brackets

`string.char()` and `string.byte()` convert between char and bytes.

```
 print(string.char(97))
i = 99; print(string.char(i, i+1, i+2))
print(string.byte("abc"))
-- returns bytes for character `a` in position 1 (default)

print(string.byte("abc", 1))
print(string.byte("abc", 2))
print(string.byte("abc", 1, 3))

t = {string.byte("abc", 1, -1)}
-- create table of all bytes values in the string `abc`
```

> a
cde
97
97
98
97  98  99

```
string.format("x = %d y = %d", 10, 20) 
> x = 10 y = 20
string.format("x = %f", 20)
> x = 20.000000
string.format("x = %.2f", 20)
> x = 20.00
tag, title = "h1", "a title"
s = string.format("<%s>%s</%s>", tag, title, tag)
s
> <h1>a title</h1>
```

This `%d`, `%s`, `%f` are called directives.

**we can call all functions from the string library as methods on strings, using the colon operator.**

So we can rewrite `string.sub(s, i, j)` as `s:sub(i, j)` or `string.upper` as `s:upper`

## pattern matching

`string.find` returns first and last position (index) of the pattern in the string, if patterns was there, otherwise returns `nil`.

`string.gsub` (gsub => Global SUBstitution) replaces all the occurrences of pattern with replacement.

```
 s = "hello world"
 s:find("wor")
7   9
 s:find("war")
nil
 s:gsub("l", "-")
he--o wor-d 3
 i = s:gsub("l", "-")
 i
he--o wor-d
 i, j = s:gsub("l", "-")
 i
he--o wor-d
 j
3
```
here 3 is the number of replacement `gsub` did.

## Unicode

**String order operators `<`, `>` compare UTF-8 strings following the order of their unicode code points**

- `reverse`, `upper`, `lower`, `byte`, `char` doesn't work with utf-8 strings, since these functions assume that one character is one byte.
- `format`, `rep` works without problem, except for the case of directive `%c`, which assume one character is one byte.
- `len`, `sub` work correctly with utf-8 string here indices refers to byte count instead of character count.

But we can use  `utf8` lua library.

```
print(utf8.len('résumé'))
print(utf8.len("áçäo"))

print(utf8.char(114, 233, 115, 117, 109, 233))
print(utf8.codepoint('résumé'))
print(utf8.codepoint('résumé', 2,  4))
```

> 6
4
résumé
114
233	115

`utf8.char` and `utf8.codepoint` are equiv to `string.char` and `string.byte`

`utf8.offset` converts a character position to byte position.

```
for i=1, 6 do
  print(utf8.offset('résumé', i))
end
```
> 1
2
4
5
6
7

```
s = 'résumé'
print(utf8.codepoint(s, utf8.offset(s, 4)))
```
>  117

`utf8.codes()` allows us to iterate over the characters in a UTF-8 string.

```
for i, c in utf8.codes("Açäo") do print(i, c) end
```

```
1	65
2	231
4	228
6	111
```

```
for i, c in utf8.codes("résumé") do print(i, c) end

1	114
2	233
4	115
5	117
6	109
7	233
```





