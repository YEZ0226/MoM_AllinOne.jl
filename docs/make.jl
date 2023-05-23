using MoM_Basics, MoM_Kernels, MoM_Visualizing, CEM_MoMs
using Documenter

DocMeta.setdocmeta!(CEM_MoMs, :DocTestSetup, :(using CEM_MoMs); recursive=true)

makedocs(;
    modules=[MoM_Basics, MoM_Kernels, CEM_MoMs],
    authors="deltaeecs <1225385871@qq.com> and contributors",
    repo="https://github.com/deltaeecs/CEM_MoMs.jl/blob/{commit}{path}#{line}",
    sitename="CEM_MoMs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://deltaeecs.github.io/CEM_MoMs.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/deltaeecs/CEM_MoMs.jl",
)