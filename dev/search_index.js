var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = TorsExperimentalTools","category":"page"},{"location":"#TorsExperimentalTools","page":"Home","title":"TorsExperimentalTools","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for TorsExperimentalTools.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [TorsExperimentalTools]","category":"page"},{"location":"#TorsExperimentalTools.add_default_args!-Tuple{ArgParse.ArgParseSettings}","page":"Home","title":"TorsExperimentalTools.add_default_args!","text":"add_default_args!(s::ArgParseSettings)\n\nAdd generally applicable arguments to s.\n\nIn particular, it adds the following arguments:\n\n--ignore-commit\n--verbose\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.available_runs-Tuple{}","page":"Home","title":"TorsExperimentalTools.available_runs","text":"available_runs(; prefix=nothing, commit=nothing, full_path=false)\n\nReturn available runs.\n\nKeyword arguments\n\nprefix: filters based on the prefix of the runs.\ncommit: filters based on the commit id from which the run is produced.\nfull_path: if true, the full path to each run will be returned rather than only their directory names.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.default_name-Tuple{Module}","page":"Home","title":"TorsExperimentalTools.default_name","text":"default_name(mod; include_commit_id=false)\n\nConstruct a name from either repo information or package version of mod.\n\nIf the path of mod is a git-repo, return name of current branch, joined with the commit id if include_commit_id is true.\n\nIf path of mod is not a git-repo, it is assumed to be a release, resulting in a name of the form release-VERSION.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.generate_name-Tuple{}","page":"Home","title":"TorsExperimentalTools.generate_name","text":"generate_name([rng::Random.AbstractRNG]; kwargs...)\n\nGenerate a random name.\n\nKeyword arguments\n\nrng: A random number generator. Default: Random.default_rng().\nalready_taken: A set of names that are already taken. Default: Set{String}().\nprefix: A prefix to the name. Default: \"\".\nsuffix: A suffix to the name. Default: \"\".\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.getcommit-Tuple{LibGit2.GitRepo}","page":"Home","title":"TorsExperimentalTools.getcommit","text":"getcommit(repo::LibGit2.GitRepo)\n\nReturn the commit ID of HEAD for repo.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.getcommit-Tuple{String}","page":"Home","title":"TorsExperimentalTools.getcommit","text":"getcommit(run)\n\nReturn the commit ID from the run name.\n\nAssumes name came form default_name.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.interactive_checkout_maybe","page":"Home","title":"TorsExperimentalTools.interactive_checkout_maybe","text":"interactive_checkout_maybe(source, repodir=projectdir())\ninteractive_checkout_maybe(source_commit::LibGit2.GitHash, repodir=projectdir())\n\nCheck if commit of source matches current HEAD of repodir.\n\nIf source is specified instead of source_commit, then getcommit(source) is used.\n\n\n\n\n\n","category":"function"},{"location":"#TorsExperimentalTools.pkgversion-Tuple{Module}","page":"Home","title":"TorsExperimentalTools.pkgversion","text":"pkgversion(m::Module)\n\nReturn version of module m as listed in its Project.toml.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.run_from_args-Tuple{Any, Any}","page":"Home","title":"TorsExperimentalTools.run_from_args","text":"run_from_args(mod::Module, args)\n\nReturn a Run created from mod and args.\n\n\n\n\n\n","category":"method"},{"location":"#TorsExperimentalTools.@default_argparse_rules-Tuple{}","page":"Home","title":"TorsExperimentalTools.@default_argparse_rules","text":"@default_argparse_rules\n\nAdd generally applicable rules to ArgParseSettings.\n\nIn particular, it adds the following rules:\n\n::Type{Date}: Date(x, dateformat\"y-m-d\")\n\n\n\n\n\n","category":"macro"},{"location":"#TorsExperimentalTools.@parse_args","page":"Home","title":"TorsExperimentalTools.@parse_args","text":"@parse_args s\n@parse_args s _args\n\nCalls parse_args on s and _args, with _args = ARGS if _args is not defined.\n\nThis is convenient when wanting to run a script using include instead of from the command line, for example allowing temporary halting of a long-running process to  save some results, and then resume.\n\n\n\n\n\n","category":"macro"}]
}
