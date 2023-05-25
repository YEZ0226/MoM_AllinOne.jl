using MoM_Basics, MoM_Kernels, MoM_Visualizing, MoM_AllinOne
using Documenter

DocMeta.setdocmeta!(MoM_AllinOne, :DocTestSetup, :(using MoM_AllinOne); recursive=true)

makedocs(;
    modules=[MoM_Basics, MoM_Kernels, MoM_AllinOne],
    authors="deltaeecs <1225385871@qq.com> and contributors",
    repo="https://github.com/deltaeecs/MoM_AllinOne.jl/blob/{commit}{path}#{line}",
    sitename="MoM_AllinOne.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://deltaeecs.github.io/MoM_AllinOne.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/deltaeecs/MoM_AllinOne.jl",
)