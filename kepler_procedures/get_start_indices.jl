function get_start_indices(array::Array)
    #return a set of evenly spaced indices that break up an
    #array into pieces of length sqrt(array)
    len=length(array);
    indices=linspace(1,len,len);
    segment_length=convert(Uint32,round(sqrt(len)));
    start_indices=1:segment_length:(len-(len%segment_length));
    return start_indices
end
