# Dispersal Potential Estimator (DPE)
module DPE
    
    # Other libraries
    using StatsBase
    using Distributions
    using DataFrames
    using CSV
    using ProgressMeter
    using LinearAlgebra
    
    # Submodules

    ## Individual-Based Model for generating abundance timeseries
    ## for testing DPE
    module IBM
    end


    abstract type DispersalKernel end     
    abstract type ParameterBundle end
    abstract type Parameter end

    # Other source files

    include("DispersalPotential.jl")
    include("Metapopulation.jl")
    include("Parameters.jl")
    include("SummaryStats.jl")
    include("TreatmentFactory.jl")


end
