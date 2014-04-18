function get_seg_inds_par(array)
    len=length(array);
    
    # calculate the ideal length of each segment
    segment_length=convert(Uint32,round(sqrt(len*nworkers())))

    # calculate the starting indices of each segment
    start_indices=1:segment_length:(len-(len%segment_length));

    # get number segments
    num_segments=length(start_indices);

    # initialize the seg_inds array
    seg_inds=zeros(Int64,(num_segments,2))

    # build up the ranges of each segment (obtain sind and eind)
    for i=1:num_segments-1
        #start index
        sind=start_indices[i];
        #end index
        eind=start_indices[i+1]-1;
        #save these to seg_inds
        seg_inds[i,:]=[sind,eind];
    end

    #need to handle the last segment
    seg_inds[num_segments,:]=[start_indices[end],len];

    return seg_inds
end
