using TorsExperimentalTools
using Documenter

DocMeta.setdocmeta!(TorsExperimentalTools, :DocTestSetup, :(using TorsExperimentalTools); recursive=true)

makedocs(;
    modules=[TorsExperimentalTools],
    authors="Tor Erlend Fjelde <tor.erlend95@gmail.com> and contributors",
    repo="https://github.com/torfjelde/TorsExperimentalTools.jl/blob/{commit}{path}#{line}",
    sitename="TorsExperimentalTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://torfjelde.github.io/TorsExperimentalTools.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/torfjelde/TorsExperimentalTools.jl",
    devbranch="main",
)
