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
        redraw_parameters_every_timestep::Bool
        log_abundances::Bool
        log_metapopulation::Bool
    end

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

    # -----------------------------------------------------------
    # Include methods
    # -----------------------------------------------------------
    include(joinpath(".", "StochasticLogisticWDiffusion.jl"))

    # -----------------------------------------------------------
    # export
    # -----------------------------------------------------------

    export DynamicsModel, DynamicsInstance, SimulationSettings, StochasticLogisticWDiffusion

end
