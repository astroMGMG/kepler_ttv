#To calculate the time it takes to run the parallel
include("par_launcher.jl")

@time par_launcher(4, "noplot")
