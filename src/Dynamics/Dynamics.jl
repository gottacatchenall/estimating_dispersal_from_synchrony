module Dynamics
    # -------------------------------------------------------------
    #   Libraries
    # -------------------------------------------------------------
    using ..DPE
    """
        DynamicsModel
        ----------------------------------------------------
        An abstract type
    """
    abstract type DynamicsModel end
    struct StochasticLogisticWDiffusion <: DynamicsModel end

    """
        SimulationSettings()
        ----------------------------------------------------
        A parametric struct which contains parameters related
        to simulating dynamics.
    """
    mutable struct SimulationSettings
        number_of_timesteps::Int64
        timestep_width::Float64
        log_frequency::Int64
        log_abundances::Bool
        log_metapopulation::Bool
    end
    SimulationSettings(; number_of_timesteps = 100, timestep_width=0.1, log_frequency=10, log_abundances=false, log_metapopulation=false) = 
        SimulationSettings(number_of_timesteps, timestep_width, log_frequency, log_abundances, log_metapopulation)

    """
        DynamicsInstance()
        ----------------------------------------------------
        An instance of a treatment, which contains the resulting
        abundance matrix.
    """
    mutable struct DynamicsInstance
        metapopulation::Metapopulation
        dx_dt::DynamicsModel
        simulation_parameters::SimulationSettings
        parameter_values::ParameterValues
        abundance_matrix::Array{Float64,2}
        state::Array{Float64}
    end
    
    DynamicsInstance(;  metapopulation = get_random_metapopulation(),
                        dx_dt = StochasticLogisticWDiffusion,
                        simulation_parameters=SimulationSettings(),
                        parameter_values = StochasticLogisticParameterValues(),
                        abundance_matrix = get_number_populations(metapopulation),
                        state = zeros(get_number_populations(metapopulation), simulation_settings.number_of_timesteps)
                       ) = DynamicsInstance(metapopulation, dx_dt, simulation_parameters, parameter_values, abundance_matrix, rand(Uniform(10,100), get_number_populations(metapopulation)))

    # -----------------------------------------------------------
    # Include methods
    # -----------------------------------------------------------
    include(joinpath(".", "StochasticLogisticWDiffusion.jl"))

    # -----------------------------------------------------------
    # export
    # -----------------------------------------------------------
    export DynamicsModel, DynamicsInstance, SimulationSettings, StochasticLogisticWDiffusion
end
