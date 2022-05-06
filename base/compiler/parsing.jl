# This file is a part of Julia. License is MIT: https://julialang.org/license

# Call Julia's builtin flisp-based parser. `offset` is 0-based offset into the
# byte buffer or string.
function fl_parse(text::Union{Core.SimpleVector,String},
                  filename::String, lineno, offset, options)
    if text isa Core.SimpleVector
        # Will be generated by C entry points jl_parse_string etc
        text, text_len = text
    else
        text_len = sizeof(text)
    end
    ccall(:jl_fl_parse, Any, (Ptr{UInt8}, Csize_t, Any, Csize_t, Csize_t, Any),
          text, text_len, filename, lineno, offset, options)
end

function fl_parse(text::AbstractString, filename::AbstractString, lineno, offset, options)
    fl_parse(String(text), String(filename), lineno, offset, options)
end
