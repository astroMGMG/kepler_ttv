function test_std_ser(koi_filename::String)
    #See description in "run_tests.jl"
        koi_list = read_ascii(koi_filename)

        num_errors = 0

        for koi_num in koi_list
            println("Reading data from 'lightcurves_detrended/", koi_num, ".csv")
            read_path = string("lightcurves_detrended/", koi_num, ".csv")
            data_read = read_lightcurve_ascii(read_path)
            detr_flux = data_read[:,2]
            orig_flux = data_read[:,3]
            println("Stripping ", get_num_nan(orig_flux), " NaNs from data")
            num_nan_orig_flux = get_num_nan(orig_flux)
            num_nan_detr_flux = get_num_nan(detr_flux)
            std_orig_flux = std(strip_nan(orig_flux))
            std_detr_flux = std(strip_nan(detr_flux))
            println("STD untrended flux: ", std_orig_flux )
            println("STD detrended flux: ", std_detr_flux )
            if (num_nan_orig_flux != num_nan_detr_flux)
                num_errors++
            end
        end

        return num_errors
end
