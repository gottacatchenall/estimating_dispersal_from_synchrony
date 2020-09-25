function get_dispersal_potential(metapopulation::Metapopulation; alpha::Number=3.0, rho::Number=0.001, kernel=ExpKernel)
    get_number_populations(metapopulation)
    matrix::Array{Float64,2} = zeros(num_populations, num_populations)
    return DispersalPotential(matrix) 
end
