# TorsExperimentalTools

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://torfjelde.github.io/TorsExperimentalTools.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://torfjelde.github.io/TorsExperimentalTools.jl/dev/)
[![Build Status](https://github.com/torfjelde/TorsExperimentalTools.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/torfjelde/TorsExperimentalTools.jl/actions/workflows/CI.yml?query=branch%3Amain)

This is a simple package containing some utility that I find myself using across different projects when running different sorts of experiments.

It's meant to help cover the following parts of running computational experiments:
1. Creating names, etc. for a particular _run_ of an experiment.
2. Creating scripts using ArgParse.jl.
3. Navigating the resulting runs.

## Usage

Typically usage looks something like this.

```julia
using ArgParse
using TorsExperimentalTools

# Add some default parsing rules for ArgParse.jl.
@default_argparse_rules

# Argument parsing.
argparsesettings = ArgParseSettings(...)
# Add defaults from TorsExperimentalTools.
add_default_args!(argparsesettings)
# Parse arguments, possibly allowing specification of the args from the variable `_args` rather than `ARGS`.
args = @parse_args argparsesettings

# Load your package here instead of at the top of the file to avoid long startup times.
using MyPackage
# Create the run.
run = run_from_args(MyPackage, args)

# From her on, we simply use `run` to provide context to everything we do, e.g.
# if we need to save some results, we'll get the path by calling `outputdir(run, args...)`.
...
```
