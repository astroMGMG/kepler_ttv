function client_init()
    # A function that initializes the kplr client-object, and returns it
    using PyCall;
    @pyimport pyfits;
    @pyimport kplr;
    client = kplr.API()
    return client
end
