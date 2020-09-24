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

        # -----------------------------------------------------------
        # Parameters
        # -----------------------------------------------------------
        include(joinpath(".", "Parameters/Parameters.jl"))
        using .Parameters
        export  Parameter,
                ParameterBundle,
                ParameterValues


        # -----------------------------------------------------------
        # Dynamics
        # -----------------------------------------------------------
        include(joinpath(".", "Dynamics/Dynamics.jl"))
        using .Dynamics
        export  StochasticLogisticWDiffusion,
                SimulationSettings,
                DynamicsInstance

        # -----------------------------------------------------------
        # Treatments
        # -----------------------------------------------------------
        include(joinpath(".", "Treatments/Treatments.jl"))
        using .Treatments
        export  Treatment,
                TreatmentSet

end
