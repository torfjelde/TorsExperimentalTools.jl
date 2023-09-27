struct Run
    name::String
end

Run() = generate_name(; already_taken = available_runs_maybe())

"""
    run_from_args(mod::Module, args)

Return a `Run` created from `mod` and `args`.
"""
function run_from_args(mod, args)
    # TODO: Make `args` something nicer than a `Dict`.
    name = default_name(mod, include_commit_id=!args["ignore-commit"])
    return Run(name)
end

# Directory containing all the runs.
runsdir(args...) = DrWatson.projectdir("runs", args...)

# Directories for a particular run.
rundir(run::Run, args...) = runsdir(run.name, args...)
outputdir(run::Run, args...) = rundir(run, "output", args...)
DrWatson.plotsdir(run::Run, args...) = rundir(run, "plots", args...)

"""
    getcommit(run)

Return the commit ID from the run name.

Assumes `name` came form [`default_path`](@ref).
"""
getcommit(run::String) = LibGit2.GitHash(split(run, "-")[end])

"""
    getcommit(repo::LibGit2.GitRepo)

Return the commit ID of HEAD for `repo`.
"""
function getcommit(repo::LibGit2.GitRepo)
    githead = LibGit2.head(repo)
    return LibGit2.GitHash(LibGit2.peel(LibGit2.GitCommit, githead))
end

"""
    interactive_checkout_maybe(source, repodir=projectdir())
    interactive_checkout_maybe(source_commit::LibGit2.GitHash, repodir=projectdir())

Check if commit of `source` matches current HEAD of `repodir`.

If `source` is specified instead of `source_commit`, then `getcommit(source)` is used.
"""
function interactive_checkout_maybe(source, repodir=projectdir())
    return interactive_checkout_maybe(getcommit(source), repodir)
end
function interactive_checkout_maybe(
    source_commit::LibGit2.GitHash,
    repodir=projectdir()
)
    repo = LibGit2.GitRepo(repodir)

    if source_commit != getcommit(repo)
        print(
            "Run came from $(source_commit) but HEAD is ",
            "currently pointing to $(getcommit(repo)); ",
            "do you want to checkout the correct branch? [y/N]: "
        )
        answer = readline()
        if lowercase(answer) == "y"
            if LibGit2.isdirty(repo)
                error("HEAD is dirty! Please stash or commit the changes.")
            end
            LibGit2.checkout!(repo, string(source_commit))
        else
            error("Add flag --ignore-commit to avoid this prompt/check.")
        end
    elseif LibGit2.isdirty(repo)
        print("HEAD is dirty! Are you certain you want to continue? [y/N]: ")
        answer = readline()
        if lowercase(answer) != "y"
            exit(1)
        end
    end

    return nothing
end

"""
    available_runs(; prefix=nothing, commit=nothing, full_path=false)

Return available runs.

# Keyword arguments
- `prefix`: filters based on the prefix of the runs.
- `commit`: filters based on the commit id from which the run is produced.
- `full_path`: if `true`, the full path to each run will be returned rather
  than only their directory names.
"""
function available_runs(; prefix=nothing, commit=nothing, full_path=false)
    runs = readdir(runsdir())
    if prefix !== nothing
        filter!(Base.Fix2(startswith, prefix), runs)
    end

    if commit !== nothing
        commit_ids = map(runs) do run
            last(split(run, "-"))
        end
        indices = findall(Base.Fix2(startswith, commit), commit_ids)
        runs = runs[indices]
    end

    if full_path
        runs = map(runsdir, runs)
    end

    return runs
end

function available_runs_maybe(; kwargs...)
    try
        return available_runs(; kwargs...)
    catch e
        return String[]
    end
end
