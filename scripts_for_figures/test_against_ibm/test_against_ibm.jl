using DPE


# 1. Run an IBM with known parameters
true_prob_dispersal = 0.1
true_dispersal_potential = [0.5 0.5; 0.5 0.5]

ibm = IBM(IBMParameters(metapop, true_prob_dispersal, true_dispersal_potential; log_frequency=10))
abundance_data = run_ibm_model(ibm)


# 2. Run ABCSampler w/ DPE to estimate the true dispersal potential

abc_sampler_params = ABCSamplerParams(params)
abc_estimate = run_abc_sampler(priors, abundance_data, parameters=abc_sampler_params)


# 3. plot density of abc_estimate of \alpha versus true

abc_estimate.Phi = blah     # edge weight
abc_estimate.Epsilon = blah  # the cutoff value of a dispersal kernel beyond which an edge doesn't exist
abc_estimate.alpha = blah
