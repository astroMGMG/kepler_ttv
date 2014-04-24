#To calculate the time it takes to detrend the 
include("koi_launcher.jl")

@time koi_launcher("koi_list.csv","notest", "no_plot","no_mast_data")
println("Serial detrend time: ", ser_detrend_time)
