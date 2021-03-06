# Only gets data from mast - no detrending done
#-------------------------------------------------------
using Base.Test
include("rw_functions.jl")
include("client_init.jl")
#-------------------------------------------------------

function koi_get_mastdata(koi_filename::String, testFlag="test_rw",plotFlag="make_plot")
	#NAME:
	#       koi_get_mastdata(koi_filename::String)
	#
	#PURPOSE:
	#       To get lightcurve-data (time, flux, error in flux) using for a given list of KOI objects
        #       (Kepler Objects of Interest) listed in the file `koi_filename`.
        #       Before saving the fetched data, the program 
	#       
	#CALLING SEQUENCE:
	#       koi_get_mastdata(koi_filename::String)  
	#
	#INPUT PARAMETERS:
        #       koi_filename - A string denoting the name of the csv file that contains a list of KOI objects
	#
        #OPTIONAL INPUT:
        #       testFlag = "test_rw"
        #       testFlag = "make_plot"
        # Make these flags something else if you do not want this behaviour
        #
	#OUTPUT PARAMETERS:
	#
	#NOTES:
	#
	#MODIFICATION HISTORY:
	#       Coded by G. K. Stefansson - date 23 April, 2014
	#
        
        koi_list = read_ascii(koi_filename)

        #Check if only one number in each row
        @assert size(koi_list)[2] == 1

        my_kepler_client = client_init()

        for koi_num in koi_list
            println("Getting data for KOI object: ", koi_num)
            time, flux, fluxerr = get_good_lightcurve_quarters(my_kepler_client, koi_num);

            data_write = hcat(time, flux, fluxerr)

            #-----------------------------------------------------------
            # Writing to files
            write_lightcurve_ascii(data_write, string("lightcurves_untrended/", koi_num, ".csv"))

            #-----------------------------------------------------------
            #Testing: Only if testFlag is set
            if (testFlag=="test_rw")
               println("Running Read/Write tests") 
               readpath = string("lightcurves_untrended/", koi_num, ".csv")
               println("Reading data from ", readpath) 
               data_read = read_lightcurve_ascii(readpath)
               @test_approx_eq_eps(data_write,data_read,0.001)
               println(string("ASCII rw float vector passed test for KOI object ", koi_num))
            end
            #-----------------------------------------------------------
            #Testing

            if (plotFlag=="make_plot")
               plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
               ylim(0.995,1.005)
	    end
        end
end
