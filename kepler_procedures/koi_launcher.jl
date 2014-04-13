# Includes
#-------------------------------------------------------
include("rw_functions.jl")
include("client_init.jl")
#For detrending:
include("get_good_indices.jl")
include("get_seg_inds.jl");
include("segment_detrend.jl");
include("detrend_models.jl");
#-------------------------------------------------------

function koi_launcher(koi_filename::String, testFlag="test")
	#NAME:
	#       koi_launcher(koi_filename::String)
	#
	#PURPOSE:
	#       To get lightcurve-data (time, flux, error in flux) using for a given list of KOI objects
        #       (Kepler Objects of Interest) listed in the file `koi_filename`.
        #       Before saving the fetched data, the program 
	#       
	#CALLING SEQUENCE:
	#       koi_launcher(koi_filename::String)  
	#
	#INPUT PARAMETERS:
        #       koi_filename - A string denoting the name of the csv file that contains a list of KOI objects
	#
        #OPTIONAL INPUT:
        #       testFlag = "test"
        #
	#OUTPUT PARAMETERS:
	#
	#NOTES:
	#
	#MODIFICATION HISTORY:
	#       Coded by G. K. Stefansson - date 29 March, 2014
	#
        
        koi_list = read_ascii(koi_filename)

        my_kepler_client = client_init()

        for koi_num in koi_list
            println("Getting data for KOI object: ", koi_num)
            time, flux, fluxerr = get_good_lightcurve_quarters(my_kepler_client, koi_num);

            orig_flux = deepcopy(flux)

            #-----------------------------------------------------------
            # Detrending

            seg_inds=get_seg_inds(time);
            num_seg=size(seg_inds)[1];

            for i = 1:num_seg
                seg_ind=seg_inds[i,:];
                segment_detrend!(seg_ind,time,flux);
            end

            #-----------------------------------------------------------
            #Testing: Only if testFlag is set
            if (testFlag=="test")
                println("Length time ", length(time))
                println("Length flux before strip NaNs ", length(flux))
                println("Length origflux before strip NaNs ", length(orig_flux))
                println("Flux count NANS, ", get_num_nan(flux))
                println("OrigFlux count NANS, ", get_num_nan(orig_flux))
                flux_noNan = strip_nan(flux)
                orig_flux_noNan = strip_nan(orig_flux)
                println("Length flux after strip NaNs ", length(flux_noNan))
                println("Length origflux after strip NaNs ", length(orig_flux_noNan))
                dif_noNan = abs(orig_flux_noNan - flux_noNan)
                chi2 = sum(dif_noNan.*dif_noNan)
                orig_flux_std = std(orig_flux_noNan)
                flux_std      = std(flux_noNan)
                println("Original data std: ", orig_flux_std);
                println("Detrended data std: ", flux_std);
                println("Chi 2, ", chi2)
            end
            #-----------------------------------------------------------

            data_write = hcat(time, flux, orig_flux, fluxerr)

            #-----------------------------------------------------------
            # Writing to files
            write_lightcurve_ascii(data_write, string("lightcurves/", koi_num, ".csv"))

            #Testing
            #plot(time,orig_flux,linewidth=0, marker=".",markersize=1)
            #plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
            #ylim(0.995,1.005)
            #xlim(800,1200)
        end
end
