function get_seg_inds(array::Array)
    #
    # PURPOSE:
    #   Returns a set of evenly spaced indices start and end points that break an array into
    #   segments of  length=sqrt(array). The last segment will be of unequal length if the array
    #   does not have a perfect square number of indices.
    #
    # CALLING SEQUENCE:
    #   result = get_seg_inds(array)
    #
    # INPUTS:
    #   array   - An array over which evenly spaced segments will be determined.
    #
    # OUTPUTS:
    #   result  - A 2-D array contain the start and stop indices for each segment.
    #
    # NOTES:
    #
    # MODIFICATION HISTORY:
    #   March 29, 2014; by m-wells

    
    len=length(array);
    
    # calculate the ideal length of each segment
    segment_length=convert(Uint32,round(sqrt(len)));

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
    # sind=start_indices[end];
    # eind=len;
    seg_ind[num_segments,:]=[start_indices[end],len];
end
