include("koi_launcher.jl")

#----------------------------------------------
# Serial tests
#----------------------------------------------

# First test - Big regression test
# PURPOSE: Check if you can get data from kplr, save data to file, and check RMS

include("test_rms_ser.jl")
println("Beginning test 1: Getting data from kplr, saving it, and checking RMS")
rms_test_ser()
