function koi_luncher(koi_filename::String)
	#NAME:
	#       koi_luncher(koi_filename::String)
	#
	#PURPOSE:
	#       To get lightcurve-data (time, flux, error in flux) using for a given list of KOI objects
        #       (Kepler Objects of Interest) listed in the file `koi_filename`.
        #       Before saving the fetched data, the program 
	#       
	#
	#CALLING SEQUENCE:
	#       koi_luncher(koi_filename::String)  
	#
	#INPUT PARAMETERS:
        #       koi_filename - A string denoting the name of the csv file that contains a list of KOI objects
	#
	#OUTPUT PARAMETERS:
	#
	#NOTES:
        #       Need to add Detrending part
	#
	#MODIFICATION HISTORY:
	#       Coded by G. K. Stefansson - date 29 March, 2014
	#

        # Includes
        #-------------------------------------------------------
        include("rw_functions.jl")
        include("client_init.jl")
        include("get_good_indices.jl")
        #-------------------------------------------------------
        
        koi_list = read_ascii(koi_filename)

        my_kepler_client = client_init()

        for koi_num in koi_list
            println("Getting data for KOI object: ", koi_num)
            time, flux, fluxerr = get_good_lightcurve_quarters(my_kepler_client, 952.01);

            data_write = hcat(time, flux, fluxerr)

            println(length(time))
            println(length(flux))
            println(length(fluxerr))

            #-----------------------------------------------------------
            # Detrending
            # NEED THIS

            #-----------------------------------------------------------
            # Writing to files
            write_lightcurve_ascii(data_write, string("lightcurves/", koi_num, ".csv"))

        end

        return
end
