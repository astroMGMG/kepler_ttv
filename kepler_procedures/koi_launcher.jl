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

function koi_launcher(koi_filename::String, testFlag="test_rw", plotFlag="make_plot")
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
        #       testFlag = "test_rw"
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

            data_write = hcat(time, flux, orig_flux, fluxerr)

            #-----------------------------------------------------------
            # Writing to files
            write_lightcurve_ascii(data_write, string("lightcurves/", koi_num, ".csv"))

            #-----------------------------------------------------------
            #Testing: Only if testFlag is set
            if (testFlag=="test_rw")
               println("Running Read/Write tests") 
               readpath = string("lightcurves/", koi_num, ".csv")
               println("Reading data from ", readpath) 
               data_read = read_lightcurve_ascii(readpath)
               @test_approx_eq_eps(data_write,data_read,0.001)
               println(string("ASCII rw float vector passed test for KOI object ", koi_num))

            end
            #-----------------------------------------------------------
            #Testing

            if (plotFlag=="make_plot")
		    plot(time,orig_flux,linewidth=0, marker=".",markersize=1)
		    plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
		    ylim(0.995,1.005)
		    xlim(800,1200)
		end
        end
end
