# Just a way to avoid type-piracy, and force the user to make things explicit.
"""
    @default_argparse_rules

Add generally applicable rules to `ArgParseSettings`.

In particular, it adds the following rules:
- `::Type{Date}`: `Date(x, dateformat"y-m-d")`
"""
macro default_argparse_rules()
    return quote
        $ArgParse.parse_item(::Type{$Date}, x::AbstractString) = $Date(x, dateformat"y-m-d")
    end
end

"""
    @parse_args s
    @parse_args s _args

Calls `parse_args` on `s` and `_args`, with `_args = ARGS` if `_args` is not defined.

This is convenient when wanting to run a script using `include` instead of from the
command line, for example allowing temporary halting of a long-running process to 
save some results, and then resume.
"""
macro parse_args(argparsesettings, argsvar = :_args)
    return quote
        if !($(Expr(:escape, Expr(:isdefined, argsvar))))
            $(esc(argsvar)) = $(esc(:ARGS))
        end

        $(ArgParse.parse_args)($(esc(argsvar)), $(esc(argparsesettings)))
    end
end

"""
    add_default_args!(s::ArgParseSettings)

Add generally applicable arguments to `s`.

In particular, it adds the following arguments:
- `--ignore-commit`
- `--verbose`
"""
function add_default_args!(s::ArgParse.ArgParseSettings)
    ArgParse.@add_arg_table! s begin
        "--ignore-commit"
        help = "If specified, no check to ensure that we're working with the correct version of the package is performed."
        action = :store_true
        "--verbose"
        help = "If specified, additional info will be printed."
        action = :store_true
        "--seed"
        help = "Random seed to use."
        arg_type = Int
        default = 1
    end
    return s
end
