function read_lightcurve_ascii(inputname::String)
    #A function that reads the file "inputname" which assumes that the data is arranged in a CSV format
    @assert isfile(inputname)
    return readcsv(inputname)
end

function write_lightcurve_ascii(x::Array, filename::String)
    #A function that writes the array x to a file **filename** in a CSV-file format
    writecsv(filename, x)
end

