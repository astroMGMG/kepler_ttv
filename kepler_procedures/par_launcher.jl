#using PyPlot;
function par_launcher(koi_filename::String, write_dir::String, num_procs::Int64, plotFlag="make_plot")
        include("set_procs.jl");
        set_procs(num_procs)

        @everywhere using Optim;
        @everywhere include("rw_functions.jl");
        @everywhere include("get_seg_inds.jl");
        @everywhere include("segment_detrend.jl");
        @everywhere include("detrend_models.jl");
        @everywhere include("segment_detrend.jl")
        @everywhere include("par_segment_detrend.jl");

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

            dtime=distribute(time);
            dflux=distribute(flux);
            orig_flux=deepcopy(flux);

            #-----------------------------------------------------------
            #-----------------------------------------------------------
            # Detrending
            time_flux = par_segment_detrend(dtime,dflux)
            #-----------------------------------------------------------

            time=time_flux[1][:];
            flux=time_flux[2][:];

            #-----------------------------------------------------------
            # Writing to files
            data_write = hcat(time, flux, orig_flux, fluxerr)
            write_lightcurve_ascii(data_write, string(write_dir,"/", koi_num, ".csv"))
            println("Successfully wrote detrended data file")
            #-----------------------------------------------------------

            if (plotFlag=="make_plot")
                    plot(time,orig_flux,color="blue",linewidth=0, marker=".",markersize=2)
                    plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
            #	#ylim(0.995,1.005)
            end
	end
end
