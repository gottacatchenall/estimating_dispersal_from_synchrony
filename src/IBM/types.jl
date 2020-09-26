"""
    IBMParameterValues
    -----------------------------------------------------------
    A set of parameter values for the individual-based model (IBM).
"""

struct IBMParameterValues <: ParameterValues
    mortality_probability::Float64
    predation_strength::Float64 
    migration_probability::Float64
    base_offspring_per_indiv::Float64
    num_timesteps::Int64
    log_frequency::Int64
end

IBMParameterValues(; 
                   mortality_probability::Number = 0.1,
                   predation_strength::Number = 0.03,
                   migration_probability::Number = 0.01,
                   base_offspring_per_indiv::Number = 3,
                   num_timesteps::Number = 1000,
                   log_frequency::Number = 10
                  ) = IBMParameterValues(mortality_probability, predation_strength, migration_probability, base_offspring_per_indiv, num_timesteps, log_frequency)

"""
    IBMInstance
    -----------------------------------------------------------
    An instance of the IBM 
"""
struct IBMInstance 
    metapopulation::Metapopulation
    parameters::IBMParameterValues
    dispersal_potential::DispersalPotential
    get_new_abundance::Function
    state::Vector{Int}
end

IBMInstance(;
            metapopulation=get_random_metapopulation(), 
            parameters = IBMParameterValues(),
            get_new_abundance = ricker_demographic_stochasticity,
            state = []
           ) =  IBMInstance(metapopulation, 
                            parameters, 
                            get_dispersal_potential(metapopulation), 
                            get_new_abundance, 
                            rand(DiscreteUniform(10, 100), get_number_populations(metapopulation)))
