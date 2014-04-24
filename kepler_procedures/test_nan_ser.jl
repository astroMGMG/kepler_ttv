function test_nan_ser(koi_filename::String)
        koi_list = read_ascii(koi_filename)
        num_errors = 0

        for koi_num in koi_list
            println("Reading data from 'lightcurves_detrended/", koi_num, ".csv")
            read_path = string("lightcurves_detrended/", koi_num, ".csv")
            data_read = read_lightcurve_ascii(read_path)
            detr_flux = data_read[:,2]
            orig_flux = data_read[:,3]
            num_nan_orig_flux = get_num_nan(orig_flux)
            num_nan_detr_flux = get_num_nan(detr_flux)
            println("Number of Nans in original flux:  ", get_num_nan(orig_flux))
            println("Number of Nans in detrended flux: ", get_num_nan(detr_flux))
            if (num_nan_orig_flux != num_nan_detr_flux)
                num_errors++
            end
        end

        return num_errors
end
