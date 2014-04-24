#To calculate the time it takes to run the serial
include("ser_launcher.jl")

@time ser_launcher("koi_list.csv","notest", "no_plot")
