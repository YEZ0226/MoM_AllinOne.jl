using Test

files = readdir(joinpath(@__DIR__, "../examples"))

map(f -> include(joinpath(@__DIR__, "../examples", f)), files)