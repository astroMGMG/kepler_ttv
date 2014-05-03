function segment_detrend!(seg_inds,time,flux) 
#
# PURPOSE:
#   Detrends a segment of a give lightcurve (in place) with the supplied time and flux.
#
# CALLING SEQUENCE:
#   segment_detrend!(seg_inds,time,flux)
#
# INPUTS:
#   seg_inds    - A duple
#   time        - The total time vector
#   flux        - The total flux vector
#
# OUTPUTS:
#
# NOTES:
#
# MODIFICATION HISTORY:
#   March 29, 2014; by m-wells

    seg_indices=seg_inds[1]:1:seg_inds[2];
    xpts = time[seg_indices];
    ypts = flux[seg_indices];

    beta, r, J = curve_fit(cubicmodel, xpts, ypts, [1.0, 0.0, 0.0, 0.0]);
    flux[seg_indices]=flux[seg_indices]./cubicmodel(xpts,beta);
end

function segment_detrend(seg_inds,time,flux) 
#
# PURPOSE:
#   Detrends a segment of a give lightcurve with the supplied time and flux.
#
# CALLING SEQUENCE:
#   segment_detrend!(seg_inds,time,flux)
#
# INPUTS:
#   seg_inds    - A tuple, containing the starting, and ending points of the segment
#   time        - The total time vector
#   flux        - The total flux vector
#
# OUTPUTS:
#
# NOTES:
#
# MODIFICATION HISTORY:
#   March 29, 2014; by m-wells

    seg_indices=seg_inds[1]:1:seg_inds[2];
    xpts = time[seg_indices];
    ypts = flux[seg_indices];

    beta, r, J = curve_fit(cubicmodel, xpts, ypts, [1.0, 0.0, 0.0, 0.0]);
    retval=flux[seg_indices]./cubicmodel(xpts,beta);
    return retval
end
