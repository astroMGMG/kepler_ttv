# First we will need to use the different packages
# - Note: these statements can NOT be within the functions
using PyCall;

function client_init()
    # A function that initializes the kplr client-object, and returns it
    @pyimport pyfits;
    @pyimport kplr;
    client = kplr.API()
    return client
end

function get_good_lightcurve_quarters(client, koi_name)
    #
    # PURPOSE:
    #       A function that gets all of the good light curve quarters for a given
    #       kplr object, with name `koi.name`. It returns an array of time, and flux
    #
    # CALLING SEQUENCE:
    #       time, flux = get_good_lightcurve_quarters(client, koi_name)
    #
    # INPUTS:
    #       client    - A kplr.api client; the output of client_init()
    #       koi_name  - A koi number
    #
    # OUTPUTS:
    #       time      - A floating point array, containing the times 
    #       flux      - A floating point array, containing the measured fluxes
    #
    # NOTES:
    #       Need to add ferr, and quality, and only look at the good quality ones
    #
    # MODIFICATION HISTORY:
    #       March 22, 2014; by gummiks
    #

    time,flux,ferr,quality = [],[];
    koi = client[:koi](koi_name)
    lcs = koi[:get_light_curves](short_cadence=false)
    #iterate over each lightcurve
    for lc in lcs
        #open the lightcurve file for reading
        hdu = lc[:open]();
        
        #this hdu contains the data
        hdu_bintable = hdu[2];
        
        #hdu_image = hdu[3];
        
        hdu_bintable_data=hdu_bintable[:data];
        
        #retrieve the time
        timetemp=get(hdu_bintable_data, "time");
        timetemp=convert(Array{Float64,1}, timetemp);
        
        #retrieve the flux
        fluxtemp=get(hdu_bintable_data, "pdcsap_flux");
        fluxtemp=convert(Array{Float64,1}, fluxtemp);
        
        #strip out bad data
        ind=get_good_indices(fluxtemp);
        timetemp=timetemp[ind];
        fluxtemp=fluxtemp[ind];
        
        #normalize each quarter
        fluxtemp=fluxtemp/mean(fluxtemp);
        
        #build up the combined arrays
        time=[time,timetemp];
        flux=[flux,fluxtemp];

        return(time, flux)
    end

end

