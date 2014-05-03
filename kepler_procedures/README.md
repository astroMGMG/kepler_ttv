#`kepler_procedures`
This project was an exercise for our graduate class in scientific computing.
We were interested in taking a serial algorithm and parallelizing it using the Julia programming language.
We implemented a detrending routine for Kepler data.
Detrending removes systematic and stellar variation and allows for transits to be observed without other signals.

Here we have a plot showing the result of detrending.
![alt text](detrend_vs_untrend.png "The detrended data vs. the trended data")
Notice that the transits are not removed by this process.
Better detrending can be achieved by using a higher order model (currently we use a cubic).

Here we present the performance of parallelization.
![alt text](speedup_rcc.png "The speedup of the parallel code over the serial code")
These results were obtained by using the LionXJ cluster at Penn. State University.
We used Julia's `DArray` (distributed arrays) and `@spawnat` functions to implement our parallelization.

These `kepler_procedures` make use of several other packages.
+ `PyCall` (allows access to Python packages with Julia)
+ `kplr` (Python package that provides useful tools for downloading Kepler lightcurves)
+ `PyFits` (Needed for kplr)
+ `Optim` (Julia package that provides fitting routines)
+ `PyPlot` (Provides plotting functionality by calling Python's `matlibplot`

#Description of a few important files and the directory structure

##Directory structure/Julia files
<code>rw_functions.jl</code>: A set of functions for reading and writing the lightcurve data for files. Currently contains only methods for **ascii** data but will also allow for **hdf5** rountines.

<code>client_init.jl</code>: Loads PyCall, kplr and initializes the MAST API client.

<code>get_good_indices.jl</code>: Functions to work with, and remove NaNs in an array.

<code>segment_detrend.jl</code>: Detrends a segment (applies a cubic fit to the data, and subtracts it.

<code>koi_launcher.jl</code>: The overall wrapper program that reads <code>koi_list.csv</code>, gets data using `kplr`, detrends the data, and saves the output data (time, detrended-flux, and original-flux, flux-error) in the <code>lightcurves/</code>/` detrends  Detrends a segment (applies a cubic fit to the data, and subtracts it.

##Getting Started with the serial algorithm
Lets run some tests! 

Will need to be in the `kepler_procedures` folder to run these tests.

We perform a series of tests (see `run_tests.jl` for more details). It currently performs three tests:

-  one large regression test (test 1). 

-  and two unit tests (test 2 and 3). 


Within Julia, issue the following command:

>include("run_tests.jl")

This should run tests 1,2,3 for the serial algorithm.
Test 1 will probably print out a long list of _"Exceeded maximum number of iterations"_. 
This is produced from the "Optim" package and can safely be ignored.

The file <code>koi_list.csv</code> contains a list of KOI objects, each object in one row, and the function <code>koi_launcher.jl</code> will read this file to retrieve data from the MAST database (if the `dataFlag==get_mast_data`) for each of these objects.

The retrieved data for a KOI object from MAST will be saved to an individual `.csv` file in `lightcurves_untrended` and `lightcurves_detrended/`; which contain the _untrended_, and _detrended data_, respectfully. 

The _untrended data_ contains the following data columns; **time, untrended_flux, flux_error**. Do not use the **flux_error**, it needs to be fixed.

The _detrended data_ contains the following data columns; **time, detrended_flux, untrended_flux, flux_error**. Do not use the **flux_error**, it needs to be fixed.











#An Overview of the Packages used in this Project
##1 - The `kplr` package
The `kplr` package will provide the greatest functionality with the most ease.
This is a python package but can be used within Julia via the package `PyCall`.

####`kplr` Installation instructions
Either:
> pip install kplr 

Or:
>git clone https://github.com/dfm/kplr.git

>cd kplr

>python setup.py install 


##2 - The `PyCall` package
You will need to install <code>PyCall as well</code>

**You do that within Julia:**

> Pkg.add("PyCall")

> Pkg.update()

####Notes for using PyCall in Julia
The biggest diffence from Python is that object attributes/members are accessed with omyObject[:attribute] rather than myObject.attribute, and you use get(myObject, key) rather than myObject[key].
(This is because Julia does not permit overloading the . operator yet.)
See also the section on <code>PyObject</code> below, as well as the pywrap function to create anonymous modules that simulate . access (this is what <code>@pyimport</code> does).

####Short example of how to use the `kplr` package
In Julia, issue the following commands:

>julia> using PyCall
 
>julia> @pyimport pyfits
 
>julia> @pyimport kplr
 
>julia> client = kplr.API()
 
>julia> koi=client[:koi](952.01)

##3 - `PyFits` 
You will also need to install <code>PyFits</code>: _Issue the following commands:_

> git clone https://github.com/spacetelescope/PyFITS.git 

> cd PyFITS

> python setup.py install

And you are all set!

More documentation here: http://dan.iel.fm/kplr/ 

##4 - The `Optim` package

**To install, you do that within Julia:**

> Pkg.add("Optim")

> Pkg.update()

Then within a `.jl` file just include in the beginning of the file:

>using Optim;
