# Dispersal Potential Estimator (DPE)
module DPE
    
    # Other libraries
    using StatsBase
    using Distributions
    using DataFrames
    using CSV
    using ProgressMeter
    using LinearAlgebra
    
    
    # -----------------------------------------------------------
    # Submodules
    # -----------------------------------------------------------

        # -----------------------------------------------------------
        # Dispersal
        # -----------------------------------------------------------
        include(joinpath(".", "Dispersal/Dispersal.jl"))
        using .Dispersal 
        export DispersalPotential, ExpKernel, GaussKernel

        # -----------------------------------------------------------
        # Metapopulation
        # -----------------------------------------------------------
        include(joinpath(".", "Metapopulation/Metapopulation.jl"))
        using .Metapopulations
        export Metapopulation, Population
        export  get_random_metapopulation, 
                get_lattice_metapop,
                construct_metapopulation_from_coordinates,
                get_distance_between_pops,
                get_coordinates
end
