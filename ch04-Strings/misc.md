# Escape sequences

An escape sequence is a sequence of characters that does not represent itself when used inside a character or string literal, but is translated into another character or a sequence of characters that may be difficult or impossible to represent directly.

Escape sequences consist of two or more characters, the first of which is the backslash, `\` (called the "Escape character"); the remaining characters determine the interpretation of the escape sequence. For example, `\n` is an escape sequence that denotes a newline character.

## Table of Escape Sequences

The following escape sequences are defined in `standard C`. This table also shows the values they map to in `ASCII`. However, these escape sequences can be used on any system with a C compiler, and may map to different values if the system does not use a character encoding based on `ASCII`.

|Escape sequence|Hex value in ASCII|Character represented|
|:----|:----|:----|
|\a|07|Alert (Beep, Bell) (added in C89)[1]|
|\b|08|Backspace|
|\e|1B|Escape character|
|\f|0C|Formfeed Page Break|
|\n|0A|Newline (Line Feed); see notes below|
|\r|0D|Carriage Return|
| |09|Horizontal Tab|
|\v|0B|Vertical Tab|
|\\|5C|Backslash|
|\'|27|Apostrophe or single quotation mark|
|\"|22|Double quotation mark|
|\?|3F|Question mark (used to avoid trigraphs)|
|\nnn|any|The byte whose numerical value is given by nnn interpreted as an octal number|
|\xhhh|any|The byte whose numerical value is given by hh… interpreted as a hexadecimal number|
|\uhhhh|none|Unicode code point below 10000 hexadecimal (added in C99)[1]: 26 |
|\Uhhhhhhhh|none|Unicode code point where h is a hexadecimal digit|

## Some Details about these escape sequences 

### \n vs \r

- **`\r` (Carriage Return)** → moves the cursor to the beginning of the line without advancing to the next line.
- **`\n` (Line Feed**) → moves the cursor down to the next line without returning to the beginning of the line — In a unix environment `\n` moves to the beginning of the line.
- **`\r\n` (End Of Line)** → a combination of `\r` and `\n`

`\n` produces one byte, despite the fact that the platform may use more than one byte to denote a newline, such as the *DOS/Windows CRLF sequence*, `0x0D 0x0A`

All three represent end of the line. But,

- **`\r` = CR (Carriage Return)** → Used as a new line character in Mac OS before X
- **`\n` = LF (Line Feed)** → Used as a new line character in Unix/Mac OS X
- **`\r\n` = CR + LF** → Used as a new line character in Windows

## hex escape sequences

A hex escape sequence must have at least one hex digit following `\x`, with no upper bound; it continues for as many hex digits as there are. Thus, for example, `\xABCDEFG` denotes the byte with the numerical value *ABCDEF1~6~*, followed by the letter G, which is not a hex digit.

## octal escape sequences

An octal escape sequence consists of `\` followed by one, two, or three octal digits. The octal escape sequence ends when it either contains three octal digits already, or the next character is not an octal digit. For example, `\11` is a single octal escape sequence denoting a byte with numerical value *9 (11 in octal)*, rather than the escape sequence `\1` followed by the *digit 1*. However, `\1111` is the octal escape sequence `\111` followed by the *digit 1*

## Non-standard escape sequences

A sequence such as `\z` is not a valid escape sequence according to the `C standard` as it is not found in the table above. But `Lua` offer this escape sequences; `\z` skips all subsequent space chars in the string until the first non-space character.

## Universal character names

From the `C99 standard`, `C` has also supported escape sequences that denote Unicode code points in string literals. Such escape sequences are called **universal character names**, and have the form `\uhhhh` or `\Uhhhhhhhh`, where *h stands for a hex digit*. Unlike the other escape sequences considered, a universal character name may expand into more than one code unit.

The sequence `\uhhhh` denotes the code point hhhh, interpreted as a hexadecimal number. The sequence `\Uhhhhhhhh` denotes the code point hhhhhhhh, interpreted as a hexadecimal number. (Therefore, code points located at U+10000 or higher must be denoted with the \U syntax, whereas lower code points may use \u or \U.) The code point is converted into a sequence of code units in the encoding of the destination type on the target system.

### What is `Code units`

A code unit is the "word size" of the character encoding scheme, such as 7-bit, 8-bit, 16-bit. In some schemes, some characters are encoded using multiple code units, resulting in a variable-length encoding. A code unit is referred to as a code value in some documents.

- A code unit in `US-ASCII` consists of 7 bits;
- A code unit in `UTF-8`, `EBCDIC` and `GB 18030` consists of 8 bits;
- A code unit in `UTF-16` consists of 16 bits;
- A code unit in `UTF-32` consists of 32 bits.


# Character Set, Encoding, Code page

- A Character Set is just that, a set of characters that can be used.
- Each of these characters is mapped to an integer called **code point**.
- How these code points are represented in memory is the **encoding**. An encoding is just a method to transform a code-point (`U+0041` - Unicode code-point for the character 'A') into raw data (bits and bytes).

So  **Character sets** just map integers (codepoints) to each character, but it's the encoding that dictates the binary/byte-level representation of the character.

A **code page** is a page containing a list of character codes and their corresponding glyphs (characters). For example, with **code page 437** (used with most English versions of Windows), the character code number 160 is an "a" with an accent (á). In hexadecimal, this character would be code number A0.

And a **Character code** describes a specific encoding for characters as defined in the **code page**. Each character code defines how the bits in a stream of text are mapped to the characters they represent. ASCII is the basis of most code pages; for example, the value for a character "C" is represented by 67 in ASCII.

So basically, a **code page** is a character encoding and as such it is a specific association of a set of printable characters and control characters with unique numbers. (In this sense, **code page and encoding can be interchangeably used**)

When one is talking of **code page <some number>** one is typically talking about a Windows-specific encoding, as distinct from an encoding devised by a standards body. For example `code page 28591` would not normally be referred to under that name, but simply `‘ISO-8859-1’`. The *Windows-specific Western European encoding based on ISO-8859-1* (with a few extra characters replacing some of its control codes) would normally be referred to as `code page 1252` aka `cp-1252`

Most machines use one of the following code pages (encoding):
- US-ASCII (7-bit ASCII)
- MS Latin1 (MS 1252) for Windows operating systems
- Latin1 (ISO 8859-1) for UNIX operating systems

## How to know which code page my Windows machine is using

open cmd and type the following

```
> chcp

Active code page: 437
```
```
> chcp /?

Displays or sets the active code page number.

CHCP [nnn]
  nnn   Specifies a code page number.
Type CHCP without a parameter to display the active code page number.
```

**Side Note**

The [**code page 437**](https://en.wikipedia.org/wiki/Code_page_437) on my Windows-10 machine was the reason to get smiley face `☺` instead of SOH (Start of Header) since 01 is the ascii hex code for SOH, while I run the following in `Lua` or `python`

```
> print("\x01")
☺
```

Now after all this messy notes, to know more about these messy topics, read this [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/)
