function get_good_indices(array::Array)
	ind=[]
	for i=1:length(array)
		if !isnan(array[i])
			ind=[ind,i]
		end
	end
	return ind
end
