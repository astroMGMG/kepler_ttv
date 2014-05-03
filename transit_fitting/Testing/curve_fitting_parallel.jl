function write_file_binary(x::Array,name)
    #Write an array of real numbers to a file. Format is binary
    filen=open(name,"w")
    write(filen,x)
    close(filen)
end

function read_file_binary(name)
    #Read a binary file and output to the command line
    file=open(name,"r")
    a=Float64[]
    i=0
    while eof(file) == false
        rfile=read(file,Float64)
        push!(a,rfile)
    end
    
    close(file)
    l=length(a)
    half=l/2
    time=a[1:half]
    flux=a[l/2+1:l]
    return time,flux
end


#Use to find the derivative

@everywhere function lagrange_deriv(time::Array,flux::Array)
    @assert (length(time)==length(flux))
    dy=zeros(length(time))

#  dy =  @parallel 
for i in 2:(length(flux)-1)
        y0 =flux[i-1]
        y1 =flux[i]
        y2 =flux[i+1]
        x0 =time[i-1]
        x1 =time[i]
        x2 =time[i+1]
        x01 = x0-x1
        x02 = x0-x2
        x12 = x1-x2
        dy[i] = y0*x12/(x01*x02) + y1*(1/x12-1/x01) - y2*x01/(x02*x12)
    end
    return dy
end


#Creates marker file. File=0 for no event, -1 for event, -0.5 for ingress/egress
function create_marker(df::Array,stddev_f::Float64,stddev_df::Float64,flux::Array)
    marker=zeros(length(df))
    for i in 1:(length(df)) #Assume f is normalized to 1
        if (abs(1-flux[i]) < (1.5*stddev_f)) && (abs(df[i]) < (1.5*stddev_df))
            marker[i]=0
        end
        if abs(1-flux[i]) > 1.5*stddev_f && abs(df[i]) < 1.5*stddev_df
            marker[i]=-1
        end
        if abs(1-flux[i]) > 1.5*stddev_f && abs(df[i]) > 1.5*stddev_df
            marker[i]=-0.5
        end
    end
    return marker
end

#Finds width of transit events. Output is a vector
function transit_width(marker::Array)
    width=Float64[]

    l=length(marker)
    for i in 2:length(marker)
        if marker[i] + marker[i-1] == -0.5
#            width=[width,i]
	     push!(width,i)
        end
    end
    width2=Float64[]
    for i in 2:2:length(width)-1
#        width2=[width2,width[i]-width[i-1]]
	 width2=push!(width2,width[i]-width[i-1])
    end
    return width2
end


#Finds period of transit events. Output is a vector
function transit_period(marker::Array)
        width=Float64[]

        l=length(marker)
        for i in 2:length(marker)
            if marker[i] + marker[i-1] == -0.5
#                width=[width,i]
		 push!(width,i)
            end
        end
        period=Float64[]
        for i in 2:2:length(width)-1
#            period=[period,width[i+1]-width[i-1]]
	     push!(period,width[i+1]-width[i-1])
        end
    return period
end

#Finds depth of transit events. Output is a vector
function transit_depth(marker::Array,flux::Array)
    depth=Float64[];
    for i in 1:length(marker)
        if marker[i] == -1.0
#            depth=[depth,flux[i]]
	     push!(depth,flux[i])
        end
    end
    return depth
end

#Wrapper function that finds transit parameters and plots fitted curve over data.
function fit_curve(filename::String)
    light_curve=read_file_binary(filename)
    time=light_curve[1]
    flux=light_curve[2]
    df=lagrange_deriv(time,flux)
    stddev_f=std(flux)
    stddev_df=std(df)

    marker=create_marker(df,stddev_f,stddev_df,flux)

    #width=mean(transit_width(marker))
    #period=mean(transit_period(marker))
    #depth=mean(transit_depth(marker,flux))


    ref_width=@spawn(transit_width(marker))
    ref_period=@spawn(transit_period(marker))
    ref_depth=@spawn(transit_depth(marker,flux))

    width = mean(fetch(ref_width))
    period = mean(fetch(ref_period))
    depth = mean(fetch(ref_depth))

    model_curve=zeros(length(marker))
    for i in 1:length(marker)
        if marker[i] == 0
            #Assume flux is normalized to 1
            model_curve[i]=1
        else
            model_curve[i]=depth
        end
    end
  #  period_marker=linspace(1,period,period)
  #  period_repeat=period_marker
  #  for i in 1:iceil(length(time)/period)-1
  #      append!(period_repeat,period_marker)
  #  end

    #Plot for 3 transit events
    #plot(model_curve[1:iceil(3*period)])
    #plot(flux[1:iceil(3*period)])
    return model_curve
end

#Parallelize across processors
function multiple(n::Int)
    for j in 1:n
        file = fit_curve("test_huge_binary_$j.dat")
        write_file_binary(file,"output_$j.dat")
    end
end