using PyPlot;
function par_launcher(num_procs::Int64, plotFlag="make_plot")

	include("set_procs.jl");
	set_procs(num_procs)
	@everywhere using Optim;
	@everywhere include("rw_functions.jl");
	@everywhere include("get_seg_inds.jl");
	@everywhere include("segment_detrend.jl");
	@everywhere include("detrend_models.jl");

	read_data=read_lightcurve_ascii("lightcurves/952.01.csv")
	time=read_data[:,1];
	dtime=distribute(time);
	flux=read_data[:,3];
	dflux=distribute(flux);
	orig_flux=deepcopy(flux);

	@everywhere include("segment_detrend.jl")
	@everywhere include("par_segment_detrend.jl");

	@time time_flux = par_segment_detrend(dtime,dflux)

	time=time_flux[1][:];
	flux=time_flux[2][:];
	if (plotFlag=="make_plot")
               plot(time,orig_flux,color="blue",linewidth=0, marker=".",markersize=2)
               plot(time,flux,color="red",linewidth=0, marker=".", markersize=1)
#               ylim(0.995,1.005)
	end
end
