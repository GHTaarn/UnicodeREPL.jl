# UnicodeREPL

This is a small [Julia](https://julialang.org) package that enables the user
to obtain any Unicode character (that the system fonts can display) in the
Julia REPL if the [Unicode codepoint](https://codepoints.net) is known.

## Installation

In the Julia REPL type:
```julia
import Pkg
Pkg.add("UnicodeREPL")
```
(Because `UnicodeREPL.jl` uses non-public Julia interface components,
the official version is only compatible with stable Julia versions.
You can bypass this check with
`Pkg.add("https://github.com/GHTaarn/UnicodeREPL.jl#nocompat")` if you are
using an unstable version of Julia)

## Use

In the Julia REPL type:
```julia
using UnicodeREPL
```

Hereafter, you will be able to enter "unicode repl" mode by typing
the `^` character at the start of a line.
In "unicode repl" mode, any pattern matching `\u(XXXX)` will be
converted to the Unicode character corresponding to `XXXX`, where `XXXX` is a
string of any length containing the hexadecimal
[Unicode codepoint](https://codepoints.net) of a valid Unicode character.

Pressing the `Backspace` key when the cursor is on the first character of a
"unicode repl" mode line reverts back to "julia" mode while preserving
the contents of the input line.

"unicode repl" mode has most features that "julia" mode has.

### Examples
```julia-repl
julia> using UnicodeREPL
REPL mode unicode_completion initialized. Press ^ to enter and backspace to exit.

unicode repl> println("\u(2560)\u(2563)ello World\u(266c)")
╠╣ello World♬

unicode repl> println("╠\u(2563)ello World\u(266c)")
╠╣ello World♬

unicode repl> println("╠╣ello World♬")
╠╣ello World♬

unicode repl> println("20\u(0b0)C")
20°C

unicode repl> println("20\u(B0)C")
20°C

unicode repl> println("20°C")
20°C

unicode repl> 
```

The first "unicode repl" line shows what happens when merely pressing
`Enter` in this mode.

The second "unicode repl" line shows what would happen if the `Tab` key
was pressed when the cursor was on the second `\` character of the first
"unicode repl" line: The `Tab` key immediately substitutes to the left
of the cursor. Hereafter `Enter` was pressed.

The third "unicode repl" line is what most people want: It was
initially identical to the first "unicode repl" line, hereafter the
`Tab` key was pressed when the cursor was at the end of the line followed by
the `Enter` key.

The next two "unicode repl" lines show that leading zeros and both
upper and lower case codepoints are allowed.

The final "unicode repl" line shows the effect of pressing the `Tab`
key at the end of either of the previous two input lines.

Note that while any Unicode character can be entered in this way, characters
such as `°` that can be handled in "julia" mode should normally be entered
using [standard tab completion sequences](https://docs.julialang.org/en/v1/manual/unicode-input/)
as this minimises the risk of confusion with similar looking characters.

## Feedback

This is a very rough first version, the plan is to make the user experience
smoother in the future. If you encounter real bugs then please report them at
https://github.com/GHTaarn/UnicodeREPL.jl/issues or submit a pull request.
Ideas for extra Unicode related features are also welcome although of course
I cannot necessarily promise to implement them.
