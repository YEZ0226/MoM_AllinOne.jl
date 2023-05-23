## 激活环境
using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))

## 删除之前的包
map(["IterativeSolvers"]) do pkg
    try
        Pkg.rm(pkg)
    catch
        nothing
    end
end
    

## 安装包
pkgs = ["https://gitee.com/deltaeecs/IterativeSolvers.jl.git",]

map(pkgs) do pkg
    try
        Pkg.add(url = pkg)
    catch e
        @show e
    end
end

## 初始化
Pkg.instantiate()
