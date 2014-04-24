#To calculate the time it takes to run the parallel
include("par_launcher.jl")

@time par_launcher("koi_list.csv", "detrend_6", 6, "noplot")
