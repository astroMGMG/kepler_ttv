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
        #For detrending:
        include("get_good_indices.jl")
        include("get_seg_inds.jl");
        include("segment_detrend.jl");
        include("detrend_models.jl");
        #-------------------------------------------------------
        
        koi_list = read_ascii(koi_filename)

        my_kepler_client = client_init()

        for koi_num in koi_list
            println("Getting data for KOI object: ", koi_num)
            time, flux, fluxerr = get_good_lightcurve_quarters(my_kepler_client, koi_num);

            orig_flux = deepcopy(flux)

            println(length(time))
            println(length(flux))
            println(length(fluxerr))

            #-----------------------------------------------------------
            # Detrending
            # NEED THIS

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

            #Testing
            plot(time,orig_flux,linewidth=2)
            plot(time,flux,color="red")
            ylim(0.99,1.01)
        end

        return
end
