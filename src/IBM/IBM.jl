module IBM
    using ..DPE
    using Distributions 

    include(joinpath(".", "ricker_models.jl"))
    include(joinpath(".", "types.jl"))
    include(joinpath(".", "run_dynamics.jl"))

    export  IBMInstance,
            IBMParameterValues

    export run_ibm
end
