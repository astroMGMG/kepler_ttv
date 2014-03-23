
function read_file(name)
    file=readcsv(name)
    time=file[:,1];
    flux=file[:,2];
    uncertainty=file[:,3]
    return time,flux,uncertainy
end

function lagrange_deriv(time::Array,flux::Array)
    @assert (length(time)=length(flux))

    for i in 2:(length(flux)-1)
        y0 =flux(i-1)
        y1 =flux(i)
        y2 =flux(i+1)
        x0 =time(i-1)
        x1 =time(i)
        x2 =time(i+1)
        x01 = x0-x1
        x02 = x0-x2
        x12 = x1-x2
        dy = y0*x12/(x01*x02) + y1(1/x12-1/x01) - y2*x01/(x02*x12)
    end
    return dy
end


