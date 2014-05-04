#A Kepler lightcurve detrender in serial & parallel
This project was an exercise for our graduate class in scientific computing.
We were interested in taking a serial algorithm and parallelizing it using the Julia programming language.
We implemented a detrending routine for Kepler data.
Detrending removes systematic and stellar variation and allows for transits to be observed without other signals.
Here is a [link](https://docs.google.com/presentation/d/1JA7amOs9jUSS1sviu2E3LiKAmCTDrXjJgWz_Xogk7iE/edit?usp=sharing "Our in class presentation") to the presentation that we gave in class, which provides descriptions on how the serial & algorithms work.

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

#Getting Started with the serial algorithm
Lets run some tests! 

Will need to be in the `kepler_procedures` folder to run these tests.

We perform a series of tests (see `run_tests.jl` for more details). It currently performs three tests:

-  one large regression test (test 1). 

-  and two unit tests (test 2 and 3). 


Within Julia, issue the following command:

>include("run_tests.jl")

This should run tests 1, 2, and 3, for the _serial_ algorithm.
Test 1 will probably print out a long list of _"Exceeded maximum number of iterations"_. 
This is produced from the "Optim" package and can safely be ignored.

The file <code>koi_list.csv</code> contains a list of KOI objects, each object in one row, and the function <code>koi_launcher.jl</code> will read this file to retrieve data from the MAST database (if the `dataFlag==get_mast_data`) for each of these objects.

The retrieved data for a KOI object from MAST will be saved to an individual `.csv` file in `lightcurves_untrended/` and `lightcurves_detrended/`; which contain the _untrended_, and _detrended data_, respectfully. 

The _untrended data_ contains the following data columns (_do not use the **flux_error**, it needs to be fixed_):

**time, untrended_flux, flux_error**. 

The _detrended data_ contains the following data columns (_o not use the **flux_error**, it needs to be fixed_):

**time, detrended_flux, untrended_flux, flux_error**. 

#Getting Started with the parallel algorithm
The parallel algorithm is very similar to the serial one (if you want to know more about it, see our google-docs presentation through this link: LINK).

Navigate to the `benchmark_data/` folder - this folder contains many of our benchmarks. 
There you have the file `par_launcher.jl`. 
This file initializes, and reads the `koi_list.csv` in _that directory_.
`par_launcher()`, takes in the number of Julia processes that it should use.

To get quickly started with this you could do the following after navigating to `benchmarking` within Julia:

> include("benchmark_par_P.jl")

where P is the number of processors (P = 1,2,3,..,9)

Similarly, doing

> include("benchmark_ser.jl")

will benchmark the serial algorithm. 

We show the speedups from these kinds of runs on the Penn State RCC in one of the figures above.

#Directory structure
In this directory, the `kepler_procedures/`

- `benchmarking/` - Benchmarking files. 

- `lightcurves_detrended/` - The detrended data in ".csv" files (see discussion above)

- `lightcurves_untrended/` - The untrended data in ".csv" files (see discussion above) 

- `old_notebooks/` - Possibly depricated ipython notebooks that were used for development.


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
**To install, within Julia issue the following:**

> Pkg.add("Optim")

> Pkg.update()

