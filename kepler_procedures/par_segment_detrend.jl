include("get_seg_inds_par.jl")
function par_segment_detrend_at_proc(dtime::DArray,dflux::DArray)
# PURPOSE:
#   Detrends a segment of a give lightcurve with the supplied time and flux, at a proc
#
# CALLING SEQUENCE:
#   par_segment_detrend_at_proc(dtime,time,flux)
#
# INPUTS:
#   dtime        - The total time vector
#   flux        - The total flux vector
#
# OUTPUTS:
#
# NOTES:
#
# MODIFICATION HISTORY:
#   March 29, 2014; by m-wells

	local_time=localpart(dtime);
	local_flux=localpart(dflux);
	seg_inds=get_seg_inds_par(local_time)
	num_seg=size(seg_inds)[1];

	ret_time=zeros(length(local_time));
	ret_flux=zeros(length(local_time));

	for i = 1:num_seg
	    seg_ind=seg_inds[i,:];

    	    seg_indices=seg_ind[1]:1:seg_ind[2];
	    ret_time[seg_indices]=local_time[seg_indices] 
	    
	    ret_flux[seg_indices]=segment_detrend(seg_ind,local_time,local_flux);
	end
	return ret_time, ret_flux
end

function par_segment_detrend(dtime::DArray,dflux::DArray)

	worker_ids=workers();
	ret_array = map(fetch,{ (@spawnat p par_segment_detrend_at_proc(dtime,dflux)) for p in workers() })

	time=ret_array[1][1];
	flux=ret_array[1][2];
	
	for i in 2:nworkers()
		append!(time,ret_array[i][1])
		append!(flux,ret_array[i][2])
	end
	return time,flux
end
