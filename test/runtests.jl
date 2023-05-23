using Test, Pkg

for package in ["MoM_Basics", "MoM_Kernels", "MoM_Visualizing"]
    Pkg.test(package)
end