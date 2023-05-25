module MoM_AllinOne

using Reexport
@reexport using MoM_Basics, MoM_Kernels, MoM_Visualizing

export run_examples

"""
    run_examples(;targetdir = joinpath(@__DIR__, "../examples"))

运行 `targetdir` 中的所有脚本。
"""
function run_examples(;targetdir = joinpath(@__DIR__, "../examples"))
    files = readdir(targetdir)
    map(f -> include(joinpath(targetdir, f)), files)
    nothing
end

end # module MoM_AllinOne