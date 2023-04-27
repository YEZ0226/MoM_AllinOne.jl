## 激活环境
using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

## 删除之前的包
map(["MoM_Basics", "MoM_Kernels", "IterativeSolvers", "MoM_Visualizing"]) do pkg
    try
        Pkg.rm(pkg)
    catch
        nothing
    end
end
    

## 安装包
pkgs = ["https://gitee.com/deltaeecs/mom_basics.git",
        "https://gitee.com/deltaeecs/mom_kernels.git",
        "https://gitee.com/deltaeecs/IterativeSolvers.jl.git",
        "https://gitee.com/deltaeecs/mom_visualizing.git"]

map(pkgs) do pkg
    try
        Pkg.add(url = pkg)
    catch e
        @show e
    end
end

## 初始化
Pkg.instantiate()
