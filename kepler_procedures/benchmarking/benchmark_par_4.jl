#To calculate the time it takes to run the parallel
include("par_launcher.jl")

@time par_launcher("koi_list.csv", "detrend_4", 4, "noplot")
println("4 processors")
