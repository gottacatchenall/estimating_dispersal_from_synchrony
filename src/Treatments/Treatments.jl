module Treatments
    # -------------------------------------------------------------
    #   Libraries
    # -------------------------------------------------------------
    using ..DPE
    using DataFrames
    using ProgressMeter



    # -----------------------------------------------------------
    # Include methods
    # -----------------------------------------------------------
    include(joinpath(".", "types.jl"))
    include(joinpath(".", "create_treatments.jl"))

    # -----------------------------------------------------------
    # export
    # -----------------------------------------------------------

    # types
    export  TreatmentInstance,
            Treatment,
            TreatmentSet



end
