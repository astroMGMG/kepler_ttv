function get_good_lightcurve_quarters(client, koi_name)
    #
    # PURPOSE:
    #       A function that gets all of the good light curve quarters for a given
    #       kplr object, with name `koi.name`. It returns an array of time, and flux, and fluxerrors
    #
    # CALLING SEQUENCE:
    #       time, flux, fluxerr = get_good_lightcurve_quarters(client, koi_name)
    #
    # INPUTS:
    #       client    - A kplr.api client; the output of client_init()
    #       koi_name  - A koi number
    #
    # OUTPUTS:
    #       time      - A floating point array, containing the times 
    #       flux      - A floating point array, containing the measured fluxes
    #       fluxerr   - A floating point array, containing the flux-errors - NOTE this is unscaled!
    #
    # NOTES:
    #       The flux errors are not scaled; this doesn't hurt at this point, as we never use them.
    #       - Originally the idea was to use them as weights for the cubic fitting.
    #
    # MODIFICATION HISTORY:
    #       March 22, 2014; by gummiks
    #       March 23, 2014; by gummiks - note errors are not scaled yet
    #       May   3,  2014; by gummiks - extra note on FLuxerrors
    #

    time,pdcsap_flux,pdcsap_flux_err = [],[],[];
    println("Initializing koi...")
    koi = client[:koi](koi_name)
    println("Getting lightcurves...")
    lcs = koi[:get_light_curves](short_cadence=false)

    #iterate over each lightcurve
    iter = 0
    for lc in lcs
        println("Adding lightcurve quarter ", iter, )
        iter = iter+1;
        #open the lightcurve file for reading
        hdu = lc[:open]();
        
        #this hdu contains the data
        hdu_bintable = hdu[2];
        hdu_bintable_data=hdu_bintable[:data];
        
        #------------------------------------------------------------
        #RETRIEVE DATA
        #------------------------------------------------------------

        #Time
        time_temp=get(hdu_bintable_data, "time");
        time_temp=convert(Array{Float64,1}, time_temp);
        
        #Flux - pdcsap_flux
        pdcsap_flux_temp=get(hdu_bintable_data, "pdcsap_flux");
        pdcsap_flux_temp=convert(Array{Float64,1}, pdcsap_flux_temp);

        #Flux - pdcsap_flux_err
        pdcsap_flux_err_temp=get(hdu_bintable_data, "pdcsap_flux_err");
        pdcsap_flux_err_temp=convert(Array{Float64,1}, pdcsap_flux_err_temp);

        sap_quality_temp=get(hdu_bintable_data, "sap_quality")
        sap_quality_temp=convert(Array{Float64,1}, sap_quality_temp);
        
        idx_good = find(x -> x==0, sap_quality_temp)
        time_temp=time_temp[idx_good];
        pdcsap_flux_temp=pdcsap_flux_temp[idx_good];
        pdcsap_flux_err_temp=pdcsap_flux_err_temp[idx_good];

        ##normalize each quarter
        pdcsap_flux_temp=pdcsap_flux_temp/mean(pdcsap_flux_temp);
        
        #build up the combined arrays
        time=[time,time_temp];
        pdcsap_flux=[pdcsap_flux,pdcsap_flux_temp];
        pdcsap_flux_err = [pdcsap_flux_err,pdcsap_flux_err_temp];

        @assert length(time) == length(pdcsap_flux)
        @assert length(time) == length(pdcsap_flux_err)
    end

    println("All lightcurve quarters added")

    return (time, pdcsap_flux, pdcsap_flux_err)
end

