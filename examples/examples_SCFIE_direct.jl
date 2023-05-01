## 导入程序包
using MoM_Basics, MoM_Kernels, MoM_Visualizing
# using MKL, MKLSparse
using DataFrames, CSV, LaTeXStrings
using CairoMakie, MoM_Visualizing

## 参数设置
# 设置精度，是否运行时出图等
setPrecision!(Float32)
SimulationParams.SHOWIMAGE = true

# 网格文件
filename = joinpath(@__DIR__, "..", "meshfiles/sphere_600MHz.nas")
meshUnit = :m
## 设置输入频率（Hz）从而修改内部参数
frequency = 6e8

# 积分方程类型
ieT  = :CFIE

# 更新基函数类型参数(不推荐更改)
sbfT = :RWG
vbfT = :nothing

# 求解器类型
solverT = :direct

# 设置 gmres 求解器精度，重启步长(步长越大收敛越快但越耗内存)
rtol    = 1e-3
restart = 50

# 源
source  =   PlaneWave(π/2, 0, 0f0, 1f0)

## 远场观测角度
θs_obs  =   LinRange{Precision.FT}(  -π, π,  721)
ϕs_obs  =   LinRange{Precision.FT}(  0, π/2,  3 )

##开始计算
# 计算脚本
include(joinpath(@__DIR__, "../src/direct_solver.jl"))

## 比较绘图
# 导入feko数据
feko_RCS_file = joinpath(@__DIR__, "../deps/compare_feko/sphere_600MHzRCS.csv")
data_feko = DataFrame(CSV.File(feko_RCS_file, delim=' ', ignorerepeated=true))
RCS_feko = reshape(data_feko[!, "in"], :, 2)

# 绘图保存
fig = farfield2D(θs_obs, 10log10.(RCS_feko), 10log10.(RCS[:, 1:2:3]),
                [L"\text{Feko} (\phi = 0^{\circ})", L"\text{Feko} (\phi = 90^{\circ})"], [L"\text{CEM_MoMs} (\phi = 0^{\circ})", L"\text{CEM_MoMs} (\phi = 90^{\circ})"],
                xlabel = L"\theta (^{\circ})", ylabel = L"\text{RCS(dBsm)}", legendposition = :rt)
save(joinpath(@__DIR__, "..", "figures/SCFIE_RCS_sphere_600MHz_direct.pdf"), fig)