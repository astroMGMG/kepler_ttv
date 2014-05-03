# First we will need to use the different packages
# - Note: these statements can NOT be within the functions
using PyCall;
using PyPlot;
using Optim;

function client_init()
    # A function that initializes the kplr client-object, and returns it
    # NOTE: Must be connected to the internet!
    @pyimport pyfits;
    @pyimport kplr;
    client = kplr.API()
    return client
end

include("get_good_lightcurve_quarters.jl")
