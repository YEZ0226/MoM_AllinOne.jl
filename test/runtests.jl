using Test#, Pkg

files = readdir(joinpath(@__DIR__, "../examples"))
map(f -> include(joinpath(@__DIR__, "../examples", f)), files)

# for package in ["MoM_Basics", "MoM_Kernels", "MoM_Visualizing"]
#     Pkg.test(package)
# end