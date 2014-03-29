function segment_detrend!(seg_inds,time,flux) 
#
# PURPOSE:
#   Detrends a segment of a give lightcurve with the supplied time and flux.
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
#
# NOTES:
#
#
# MODIFICATION HISTORY:
#   March 29, 2014; by m-wells

    seg_indices=seg_inds[1]:1:seg_inds[2];
    xpts = time[seg_indices];
    ypts = flux[seg_indices];

    beta, r, J = curve_fit(cubicmodel, xpts, ypts, [1.0, 0.0, 0.0, 0.0]);
    flux[seg_indices]=flux[seg_indices]-cubicmodel(xpts,beta)+1;
end
