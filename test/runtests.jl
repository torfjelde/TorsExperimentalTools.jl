using TorsExperimentalTools
using Test
using ArgParse
using LibGit2

@testset "TorsExperimentalTools.jl" begin
    repo = LibGit2.GitRepo(abspath(joinpath(dirname(pathof(TorsExperimentalTools)), "..")))
    commit = string(TorsExperimentalTools.getcommit(repo))

    argsparser = ArgParseSettings()
    add_default_args!(argsparser)
    # Empty args.
    _args = []
    args = @parse_args argsparser

    @test args["ignore-commit"] == false
    @test args["verbose"] == false

    # Create run.
    run = run_from_args(TorsExperimentalTools, args)
    # Check that the commit is included.
    @test occursin(commit, rundir(run))
    @test occursin(commit, outputdir(run))
    @test occursin(commit, plotsdir(run))

    # Ignore commit.
    _args = ["--ignore-commit"]
    args = @parse_args argsparser
    @test args["ignore-commit"] == true
    @test args["verbose"] == false

    # Create run.
    run = run_from_args(TorsExperimentalTools, args)
    # Check that the commit is not included.
    @test !occursin(commit, rundir(run))
    @test !occursin(commit, outputdir(run))
    @test !occursin(commit, plotsdir(run))
end
