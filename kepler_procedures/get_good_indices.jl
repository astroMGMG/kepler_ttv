function get_good_indices(array::Array)
    ind_good = find(val->!isnan(val), array)
    return ind_good
end

function get_nan_indices(array::Array)
    ind_nan = find(val->isnan(val), array)
    return ind_nan
end

function get_num_nan(array::Array)
    ind_nan = get_nan_indices(array)
    num = length(ind_nan)
    return num
end

function get_num_good(array::Array)
    ind_good = get_good_indices(array)
    num = length(ind_good)
    return num
end

function strip_nan(array::Array)
    ind = get_good_indices(array)
    return array[ind]
end
