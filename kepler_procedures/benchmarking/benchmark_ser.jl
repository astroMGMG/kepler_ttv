#To calculate the time it takes to run the serial
include("ser_launcher.jl")

@time ser_launcher("koi_list.csv","detrend_ser","notest", "no_plot")
println("serial")
