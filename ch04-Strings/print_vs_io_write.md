# `print` vs `io.write()`

`print` is used for outputting text messages. 
- It joins its arguments with a tab character 
- automatically inserts a newline.

```
print("a")
print("b")

print("a") print("b")
print("a", "b", "c")
```
```
a
b
a
b
a	b	c
```

`io.write` is more simple. While it also accepts any number of arguments, 
- it simply concatenates them (without inserting any characters) and 
- doesn't add any newline

```
io.write("a")
io.write("b")

io.write("a") io.write("b")
io.write("a", "b", "c")
```
```
abababc
```

## More details

- `write` uses the current output file, whereas `print` always uses the standard output. 
- `print` automatically applies `tostring` to its arguments, so it can also show tables, functions, and `nil`.
- As a rule, `print` should be used for quick-and-dirty programs, or for debugging, and `write` should be used when full control over the output is needed.

Essentially, `io.write` calls a write method using current output file, making `io.write(x)` equivalent to `io.output():write(x)`.

And since `print` can only write data to the standard output, its usage is obviously limited. At the same time this guarantees that message always goes to the standard output, so we don't accidently mess up some file content, making it a better choice for debug output.

Another difference is in return value: print returns `nil`, while io.write returns file handle. This allows us to chain writes like that:

```
io.write('Hello '):write('world\n')
```
