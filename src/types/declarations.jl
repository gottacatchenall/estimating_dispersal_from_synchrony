# -----------------------------------------------------------
# Dispersal
# -----------------------------------------------------------
# declarations of types relating to dispersal, including:
#   - DispersalKernel
#   - DispersalPotential
#   -
#   -
# -----------------------------------------------------------


"""
    DispersalKernel 
    -----------------------------------------------------------
        An abstract type which represents a set of parameters
        for a specific dynamics model. 
"""
abstract type DispersalKernel end


"""
    DispersalPotential 
    -----------------------------------------------------------
        A type which holds a matrix of floats, where matrix[i,j]
        is the probability an individual born in i reproduces in j.
        
        Note that this forms a probabiity distribution over j for all i, 
        meaning that sum_j matrix[i,j] = 1 for all i. 
"""
struct DispersalPotential
    matrix::Array{Float64}
end


# -----------------------------------------------------------
# Parameters
# -----------------------------------------------------------
# declarations of types relating to parameters, including:
#   - ParameterBundle
#   - ParameterValues
#   -
#   -
# -----------------------------------------------------------


"""
    ParameterBundle 
    -----------------------------------------------------------
        An abstract type which represents a set of parameters
        for a specific dynamics model. 

        Each concrete instance of a ParameterBundle contains a 
        set of named Parameters in an parametric type.
            e.g. StochasticLogisticParameterBundle contains fields of 
                 type Parameter which correspond to sigma, lambda, etc.
"""
abstract type ParameterBundle end


"""
    ParameterValues
    ----------------------------------------------------
    An abstract type which represents a the values of parameters
    for a specific dynamics model.
    
    Each concrete instance of ParameterValues contains the values of 
    each named parameter in a parametric type. 
        e.g. StochasticLogisticParameterValues contains fields of type
             <: Number for sigma, lambda, etc. 
"""
abstract type ParameterValues end

"""
    Parameter()
    ----------------------------------------------------
    Each parameter has a distribution with provided hyperparameters.

"""
struct Parameter
    distribution::Distribution
    hyperparameters::Vector{Parameter}
    dimensionality::Int64
    Parameter(distribution::Distribution, dimensionality::Int64; hyperparameters=[])  = new(distribution, hyperparameters, dimensionality)
    Parameter(distribution::Distribution; dimensionality=1) = new(distribution, [], dimensionality)
end
Base.show(io::IO, p::Parameter) = print(io, "Parameter ~ ", p.distribution, "\n")



"""
    StochasticLogisticParameterBundle()
    ----------------------------------------------------
    The bundle of parameters for the stochastic
    logistic Model
"""
struct StochasticLogisticParameterBundle <: ParameterBundle
    num_populations::Int64
    alpha::Float64
    migration_rate::Parameter
    lambda::Parameter
    sigma::Parameter
    carrying_capacity::Parameter
end

"""
    StochasticLogisticParameterValues()
    ----------------------------------------------------
    The value of parameters for an instance of the 
    stochastic logistic model.
"""
struct StochasticLogisticParameterValues <: ParameterValues
    num_populations::Int64
    alpha::Float64  # dispersal kernel alpha
    lambda::Vector{Float64} # lambda across pops
    migration_rate::Vector{Float64} # mig across pops
    carrying_capacity::Vector{Float64} # K across pops
    sigma::Vector{Float64} # sigma across pops
end

"""
    SimulationParameters()
    ----------------------------------------------------
    A parametric struct which contains parameters related
    to simulating the dynamics.
"""
mutable struct SimulationParameters
    number_of_timesteps::Int64
    timestep_width::Float64
    log_frequency::Int64
    redraw_parameters_every_timestep::Bool
    log_abundances::Bool
    log_metapopulation::Bool
end

# -------------------------------------------------------------
#   Treatment
# -------------------------------------------------------------

"""
    TreatmentInstance()
    ----------------------------------------------------
    An instance of a treatment, which contains the resulting 
    abundance matrix.
"""
mutable struct TreatmentInstance
    metapopulation::Metapopulation
    dx_dt::Function
    simulation_parameters::SimulationParameters
    parameter_values::ParameterValues
    abundance_matrix::Array{Float64,2}
    state::Array{Float64}
end

"""
    Treatment()
    ----------------------------------------------------
    A treatment contains everything that is required to 
    run the simulation model:
        - a metapopulation of type ::Metapopulation
        - a model of dynamics dx_dt, of type
        - a set of priors on each parameter of type ::ParameterBundle,
          that corresponds to the model of dynamics. 
            i.e. if 
        - a set of simulation parameters, ::SimulationParameters
        - number of replicates 
        - a vector (of length number_of_replicates) of instances of this treatment, of type ::TreatmentInstance
"""
mutable struct Treatment
    metapopulation_generator
    dx_dt::Function
    theta::ParameterBundle
    simulation_parameters::SimulationParameters
    number_of_replicates::Number
    instances::Vector{TreatmentInstance}
end
Base.show(io::IO, treatment::Treatment) = print(io, "\n\n\nTreatment w/ priors: ", treatment.theta,)


"""
    TreatmentSet()
    ----------------------------------------------------
    A TreatmentSet is a vector of Treatments, and a dataframe
    of metadata which holds information about distribution and hyperparameters 
    of the parameters in the ParamaterBundle for each treatment.
"""
struct TreatmentSet
    metadata::DataFrame
    treatments::Vector{Treatment}
end


