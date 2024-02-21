"""
# UnicodeREPL

On an empty line, press ^ to enter unicode_repl mode and backspace to exit.

In unicode_repl mode, `\\u(XXXX)` tab completes to the symbol at Unicode
codepage `XXXX` where `XXXX` is a hexadecimal string of any length.

## Exported Symbols

[`ufind`](@ref)
"""
module UnicodeREPL

using ReplMaker
import REPL
import REPL.LineEdit.complete_line
import REPL.LineEdit.CompletionProvider

export ufind

struct UnicodeCompletionProvider <: CompletionProvider
    repl_completion_provider::CompletionProvider
end

function substitution(istr::AbstractString)
    substr = split(istr, "\\u(")
    if length(substr) == 1
        return istr
    else
        ostr = substr[1]
        for str in substr[2:end]
            m = match(r"^[0-9a-fA-F]+[)]", str)
            ostr *=
                    if m == nothing
                        "\\u(" * str
                    else
                        codepoint = m.match[1:end-1]
                        Meta.parse("\"\\u$codepoint\"") * str[length(m.match)+1:end]
                    end
        end
        return ostr
    end
end

"""
    ufind(r::Union{AbstractString,Regex})

Return the Unicode completion pairs whose keys match `r`

## Example
```julia-repl
julia> using UnicodeREPL
REPL mode unicode_repl initialized. Press ^ to enter and backspace to exit.

julia> ufind("feed")
2-element Vector{Pair{String, String}}:
 "\\\\:breast-feeding:" => "🤱"
         "\\\\linefeed" => "↴"

julia> ufind(r"^[^:]*feed")
1-element Vector{Pair{String, String}}:
 "\\\\linefeed" => "↴"

julia>
```

Note that Unicode codepages themselves are not included, so the mapping
`"\\\\u(feed)" => "ﻭ"` is not in the output.
"""
function ufind(r::Union{AbstractString,Regex})
    completions = vcat(collect(REPL.REPLCompletions.latex_symbols),
        collect(REPL.REPLCompletions.emoji_symbols))
    filter(pair->contains(pair.first,r), completions) |> sort
end

function input_handler(inputstr)
    Main.eval(Meta.parse(substitution(inputstr)))
end

function complete_line(x::UnicodeCompletionProvider, s::REPL.LineEdit.PromptState)
    firstpart = String(s.input_buffer.data[1:s.input_buffer.ptr-1])
    firstpartsub = substitution(firstpart)
    if firstpart != firstpartsub
        return ([firstpartsub], firstpart, true)
    elseif VERSION <= v"1.9-"
        return complete_line(x.repl_completion_provider, s)
    else
        return complete_line(x.repl_completion_provider, s, Main)
    end
end

function __init__()
    if !isinteractive()
        @info "Session is not interactive"
        return
    end
    initrepl(input_handler;
             prompt_text="unicode repl> ",
             prompt_color=26,
             start_key='^',
             mode_name=:unicode_repl,
             completion_provider=UnicodeCompletionProvider(REPL.REPLCompletionProvider()))
end

end # module
