function run_dispersal(ibm)
        num_populations = get_number_populations(ibm.metapopulation)
        new_abundance_vector::Vector{Int64} = zeros(num_populations)
        mig_prob::Float64 = ibm.parameters.migration_probability
        for p = 1:num_populations
            for i = 1:ibm.state[p]
                # choose to migrate
                mig_bit  = rand(Bernoulli(mig_prob))
                if mig_bit
                    new_pop = draw_from_dispersal_potential_row(ibm.dispersal_potential[p])
                    new_abundance_vector[new_pop] += 1
                else
                    new_abundance_vector[p] += 1
                end
            end
        end

    end

    function run_local_dynamics(ibm)
        num_populations = get_number_populations(ibm.metapopulation)
        for p = 1:num_populations
            ibm.state[p] = ibm.get_new_abundance(ibm.state[p])
        end
    end

    function run_ibm_timestep(ibm::IBMInstance)
        run_dispersal(ibm)
        run_local_dynamics(ibm)
    end

    function run_IBM(ibm::IBMInstance)
        num_populations = get_number_populations(ibm.metapopulation)
        num_timesteps = ibm.num_timesteps / log_frequency
        abundance_matrix::Array{Float64} = zeros(num_populations)     
        
        for t = 1:num_timesteps
            run_ibm_timestep(ibm)
        end
    end


