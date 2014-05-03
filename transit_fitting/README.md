## <code>curve_fitting.jl</code> Description

This is the Julia File which contains all the functions needed to perform a basic fit to a periodic transit. Curve fitting fits a transit widtdh, transit depth, and period between transits. 

This .jl file stands as our to-date draft of functional functions. It is the output of functions built and tested in python notebooks. Subsequent changes will either manifest as new fully functional .jl files, or replacement functions in curve_fitting.jl.

#Description of Functions

<code>write_file_binary</code>
Writes an array or real numbers to a binary file

<code>read_file_binary</code>
Reads a binary file into array. Currently it reads binary files containing only time and normalized flux. Will need modification to add in uncertainty, and non-normalized flux. 

Binary files were chosen for reading and writing because it is much faster to access a binary file than an ASCII file.

<code> lagrange_deriv</code>

Takes the Lagrangian Derivative of the flux. The Lagrange derivative is a quadratic derivative. The derivative of the flux will average out to zero for non transits, and give a non zero bump for ingress (negative slope) and egress(positive slope). 

<code>create_marker</code>

Reads in the flux array, flux derivative array, and standard deviations and searches for threshold events in both. This currently assumes a flux normalized to 1, and looks for events that are 1.5 times larger than the deviation. This function returns a marker file, where 0 indicates no transit, 0.5 indicates transit beginning and end, and 1 indicates in transit. 

<code>transit_width</code>
Uses the marker file to find the transit width of each transit

<code>transit_depth</code>

Uses the marker file to find the depth of each transit

<code>transit_period</code>

Uses the marker file to find the time between each transit

<code>fit_curve</code>

Uses all other functions to find a model curve based on average transit width, transit depth, and period. 

<code> multiple </code>

Spawns multiple curve fitting functions. For use on Multiple Processors. 
Currently, this is roughly an O(n) problem. Lagrange derivatives work through each element of an array individually. Each element of a marker file is also examined individually. This also shows in scaling with problem size. Order 1,000,000 arrays still work relatively quickly

##Current Speedup and Parallelization

#Speedup

#Choice of Binary over CSV

Chose binary because during profiling, a lot of time was being spent in file i/o. Binary is orders of magnitude faster than CSV.

#<push!>

Instantiating arrays and using push! was much faster than creating empty arrays and concatenating into them. 

#Parallelization

#@spawn
Spawning is done in two parts. First, withing curve fitting, finding width, depth, and period are all spawned. This however shows no real speedup over maintaining them all as a single process. The second spawning is done in <code>multiples</code> where the curve fitting for each light curve is sent to its own processor. 

#Future parallelization
One possible place this can be sped up is anywhere that reads an array. The arrays can be broken into pieces and each piece worked on by an array, then the result stitched together. This is something to be considered in the future.


##Testing

The Testing directory shows our efforts at speeding up the performance of our code.

##Future

This curve fitting function is incomplete. The ultimate goal is to find TTVs, and while this is a start, it has it's issues. 

One possible future is that error flags are added, and this is used as the quick first step in finding test periods for an interative period finder. The period finder then finds a period, and we can use that to get width and depth. TTvs can then be found through a process that moves back and forth.

