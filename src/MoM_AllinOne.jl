module MoM_AllinOne

using Reexport, Pkg
@reexport using MoM_Basics, MoM_Kernels, MoM_Visualizing

export run_examples, develop_Pkgs

"""
    run_examples(;targetdir = joinpath(@__DIR__, "../examples"))

运行 `targetdir` 中的所有脚本。
"""
function run_examples(;targetdir = joinpath(@__DIR__, "../examples"))
    files = readdir(targetdir)
    map(f -> include(joinpath(targetdir, f)), files)
    nothing
end

PKG_NAMES = [   "MoM_Basics.jl", "MoM_Kernels.jl", "MoM_Visualizing.jl", 
                "MPIArray4MoMs.jl", "MoM_MPI.jl", "IterativeSolvers.jl"]

"""
    generate_Pkgs_URLs([; git = "gitee"])

生成所有 MoM 子包在 `git` (`github`或`gitee`)上的仓库地址。
"""
function generate_Pkgs_URLs(; git = "gitee")

    pkgs_urls = ["https://$(git).com/deltaeecs/$(pkg_name).git" for pkg_name in PKG_NAMES]
    return pkgs_urls
    
end

"""
    clone_Pkgs(; destdir = normpath(joinpath(@__DIR__, "../pkgs")),  git = "gitee")

将所有 MoM 子包从 `git` (`github`或`gitee`)上的仓库地址 clone 到本地的 `destdir` 文件夹中。
"""
function clone_Pkgs(; destdir = normpath(joinpath(@__DIR__, "../pkgs")),  git = "gitee")
    
    # 创建目的地文件夹
    !ispath(destdir) && mkpath(destdir)
    cd(destdir)
    
    # 获取链接
    pkgs_urls = generate_Pkgs_URLs(; git = git)
    # 克隆到本地
    for pkg_url in pkgs_urls
        try
            run(`git clone $(pkg_url)`)
        catch e
            @show e
        end
    end

    cd(joinpath(@__DIR__, ".."))

    nothing

end

"""
    install_Pkg(pkg_name; destdir = normpath(joinpath(@__DIR__, "../pkgs")))

安装 `destdir` 名为 `pkg_name` 文件夹下的程序包。
"""
function install_Pkg(pkg_name; destdir = normpath(joinpath(@__DIR__, "../pkgs")))
    Pkg.add(url = joinpath(destdir, pkg_name))
end

function develop_Pkgs(; destdir = normpath(joinpath(@__DIR__, "../pkgs")), git = "gitee")
    # 拷贝到本地
    clone_Pkgs(destdir = destdir, git = git)
    # 逐个安装
    map(pkg_name -> install_Pkg(pkg_name; destdir = destdir), PKG_NAMES)

    nothing

end

end # module MoM_AllinOne