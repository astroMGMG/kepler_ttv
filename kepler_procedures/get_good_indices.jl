#Some functions to work with NaNs in Julia;
#Gudmundur - May 3rd, 2014

function get_good_indices(array::Array)
    # Returns the non-NaN indices of `array`
    ind_good = find(val->!isnan(val), array)
    return ind_good
end

function get_nan_indices(array::Array)
    # Returns the NaN indices of `array`
    ind_nan = find(val->isnan(val), array)
    return ind_nan
end

function get_num_nan(array::Array)
    # Returns the number of NaNs in `array`
    ind_nan = get_nan_indices(array)
    num = length(ind_nan)
    return num
end

function get_num_good(array::Array)
    # Returns the number of non-NaN elements in `array`
    ind_good = get_good_indices(array)
    num = length(ind_good)
    return num
end

function strip_nan(array::Array)
    # Strips `array` of NaN elements. If NaNs are present, the length
    # of the returned array will be shorter!
    ind = get_good_indices(array)
    return array[ind]
end
