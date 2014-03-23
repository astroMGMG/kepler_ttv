function segment_detrend!(seg_ind,time,flux) 
    xpts = time[seg_ind];
    ypts = flux[seg_ind];

    beta, r, J = curve_fit(cubicmodel, xpts, ypts, [1.0, 0.0, 0.0, 0.0]);
    flux[seg_ind]=flux[seg_ind]-cubicmodel(xpts,beta)+1;
end
