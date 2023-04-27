# Intel MKL 可以带来更好的性能
# using MKL, MKLSparse

# 更新参数
inputParameters(;frequency = frequency, ieT = ieT)
updateVSBFTParams!(;sbfT = sbfT, vbfT = vbfT)

# 网格文件读取
meshData, εᵣs   =  getMeshData(filename; meshUnit=meshUnit);

# 基函数生成
ngeo, nbf, geosInfo, bfsInfo =  getBFsFromMeshData(meshData; sbfT = sbfT, vbfT = vbfT)

# 设置介电参数
setGeosPermittivity!(geosInfo, 2(1-0.0002im))

# 矩阵元计算
Zmat = getImpedanceMatrix(geosInfo, nbf)

# 激励向量
V    =   getExcitationVector(geosInfo, size(Zmat, 1), source);

# 求解
ICoeff, ch   =   solve(Zmat, V; solverT = solverT, rtol = rtol, restart = restart);

# RCS
RCSθsϕs, RCSθsϕsdB, RCS, RCSdB = radarCrossSection(θs_obs, ϕs_obs, ICoeff, geosInfo) 
