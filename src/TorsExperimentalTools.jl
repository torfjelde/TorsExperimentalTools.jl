module TorsExperimentalTools

using Pkg: Pkg
using ArgParse: ArgParse
using LibGit2: LibGit2

using Dates
using DrWatson

"""
    pkgversion(m::Module)

Return version of module `m` as listed in its Project.toml.
"""
function pkgversion(m::Module)
    projecttoml_path = joinpath(dirname(pathof(m)), "..", "Project.toml")
    return Pkg.TOML.parsefile(projecttoml_path)["version"]
end


"""
    default_name(mod; include_commit_id=false)

Construct a name from either repo information or package version of `mod`.

If the path of `mod` is a git-repo, return name of current branch,
joined with the commit id if `include_commit_id` is `true`.

If path of `mod` is _not_ a git-repo, it is assumed to be a release,
resulting in a name of the form `release-VERSION`.
"""
function default_name(mod::Module; kwargs...)
    mod_path = abspath(joinpath(dirname(pathof(mod)), ".."))
    local name
    try
        name = default_name(mod_path; kwargs...)
    catch e
        if e isa LibGit2.GitError
            @info "No git repo found for $(mod_path); extracting name from package version."
            name = "release-$(pkgversion(mod))"
        else
            rethrow(e)
        end
    end

    return name
end
function default_name(repo_path; include_commit_id=true)
    # Extract branch name and commit id
    githead = LibGit2.head(LibGit2.GitRepo(repo_path))
    branchname = LibGit2.shortname(githead)

    name = replace(branchname, "/" => "_")
    if include_commit_id
        gitcommit = LibGit2.peel(LibGit2.GitCommit, githead)
        commitid = string(LibGit2.GitHash(gitcommit))
        name *= "-$(commitid)"
    end

    return name
end

export @default_argparse_rules, @parse_args, add_default_args!
include("argparse.jl")

export run_from_args, runsdir, rundir, outputdir, plotsdir, interactive_checkout_maybe
include("runs.jl")

end
