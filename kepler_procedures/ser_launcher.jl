using Base.Test
using Optim;
function ser_launcher(koi_filename::String, testFlag="test_rw", plotFlag="make_plot")
        # Includes
        #-------------------------------------------------------
        include("rw_functions.jl")
        include("get_good_lightcurve_quarters.jl")
        #For detrending:
        include("get_good_indices.jl")
        include("get_seg_inds.jl");
        include("segment_detrend.jl");
        include("detrend_models.jl");
        #-------------------------------------------------------

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
        #       plotFlag = "make_plot"
        #       dataFlag = "get_mast_data"
        # Make these flags something else if you do not want this behaviour
        #
	#OUTPUT PARAMETERS:
	#NOTES:
	#
	#MODIFICATION HISTORY:
	#       Coded by G. K. Stefansson - date 29 March, 2014
	#       Coded by G. K. Stefansson - date 12 April, 2014
        
        #-----------------------------------------------------------
        # Reading
        koi_list = read_ascii(koi_filename)
        #-----------------------------------------------------------

        #Check if only one number in each row
        @assert size(koi_list)[2] == 1

        for koi_num in koi_list
            println("Reading data for KOI object: ", koi_num);
            readstring = string("lightcurves_untrended/",koi_num,".csv");
            println(readstring);
            read_data = read_lightcurve_ascii(readstring);
            time =read_data[:,1];
            flux=read_data[:,2];
            fluxerr=read_data[:,3];

            orig_flux = deepcopy(flux)

            #-----------------------------------------------------------
            #-----------------------------------------------------------
            # Detrending
            #-----------------------------------------------------------
            seg_inds=get_seg_inds(time);
            num_seg=size(seg_inds)[1];

            for i = 1:num_seg
                seg_ind=seg_inds[i,:];
                segment_detrend!(seg_ind,time,flux);
            end
            #-----------------------------------------------------------

            #-----------------------------------------------------------
            #Writing

            #-----------------------------------------------------------
            # Writing to files
            data_write = hcat(time, flux, orig_flux, fluxerr)
            write_lightcurve_ascii(data_write, string("lightcurves_detrended/", koi_num, ".csv"))
            #-----------------------------------------------------------

            #-----------------------------------------------------------
            #Testing: Only if testFlag is set
            if (testFlag=="test_rw")
               println("Running Read/Write tests") 
               readpath = string("lightcurves_detrended/", koi_num, ".csv")
               println("Reading data from ", readpath) 
               data_read = read_lightcurve_ascii(readpath)
               @test_approx_eq_eps(data_write,data_read,0.001)
               println(string("ASCII rw float vector passed test for KOI object ", koi_num))
            end
            #-----------------------------------------------------------
            #Testing: Only if plotFlag is set
            if (plotFlag=="make_plot")
               plot(time,orig_flux,linewidth=0, marker=".",markersize=1)
               plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
               ylim(0.995,1.005)
	    end
        end

end
