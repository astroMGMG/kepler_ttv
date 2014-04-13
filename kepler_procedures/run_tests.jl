using Base.Test

include("koi_launcher.jl")

#----------------------------------------------
# Serial tests
#----------------------------------------------

#----------------------------------------------
# Test 1 - Big regression test
# PURPOSE: Check if you can get data from kplr, perform detrending and save data to '.csv' files in 'lightcurves/'
# Furthermore, it reads the data from the '.csv' files, and checks if the written data is the same as the read one.

include("test_getdata_kplr_ser.jl")
println("#################")
println("Beginning Test 1:")
println("Getting data from kplr, saving it, and checking R/W")
test_getdata_kplr_ser()
println("Test 1 completed successfully")
println("#################")

#----------------------------------------------
# Test 2 - NaNs test
# PURPOSE: Read the data from the 'lightcurves/*.csv' files, and check if there are the same amount of NaNs for the untrended, and detrended fluxes.

println()
println()
include("test_nan_ser.jl")
println("#################")
println("Beginning Test 2:")
println("Reading data from 'lightcurves/*.csv', and check if original, and detrended fluxes have the same amount of NaNs")
test_nan_res = test_nan_ser("koi_list.csv")
if(test_nan_res == 0)
    println("Test 2, NaN test, passed!")
else
    println("Test 2 Failed, on ", test_nan_res, " occasions")
end
println("Test 2 completed successfully")
println("#################")

println()
#----------------------------------------------
# Test 3 - Standard Deviation test
# PURPOSE: Read the data from the 'lightcurves/*.csv' files, and check if the standard deviation for the untrended flux is higher than the standard deviation for the detrended flux (then the detrending worked!)

include("test_std_ser.jl")
println("#################")
println("Beginning Test 3:")
println("Reading data from 'lightcurves/*.csv', and checking if STD for original flux is higher than the STD for the detrended the flux")
test_std_ser("koi_list.csv")
println("Test 3 completed successfully")
println("#################")

#println("Length time ", length(time))
#println("Length flux before strip NaNs ", length(flux))
#println("Length origflux before strip NaNs ", length(orig_flux))
#println("Flux count NANS, ", get_num_nan(flux))
#println("OrigFlux count NANS, ", get_num_nan(orig_flux))
#flux_noNan = strip_nan(flux)
#orig_flux_noNan = strip_nan(orig_flux)
#println("Length flux after strip NaNs ", length(flux_noNan))
#println("Length origflux after strip NaNs ", length(orig_flux_noNan))
#dif_noNan = abs(orig_flux_noNan - flux_noNan)
#chi2 = sum(dif_noNan.*dif_noNan)
#orig_flux_std = std(orig_flux_noNan)
#flux_std      = std(flux_noNan)
#println("Original data std: ", orig_flux_std);
#println("Detrended data std: ", flux_std);
#println("Chi 2, ", chi2)



