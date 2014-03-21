#The `kplr` package
The kplr package will provide the greatest functionality with the most ease.
This is a python package but can be used within Julia via the package <code>pycall</code>.

###Installation instructions
Either:
> pip install kplr 

Or:
>git clone https://github.com/dfm/kplr.git

>cd kplr

>python setup.py install 

**And then within Julia:**

> Pkg.add("PyCall")

> Pkg.update()

You will also need to install <code>PyFits</code>: _Issue the following commands:_

> git clone https://github.com/spacetelescope/PyFITS.git 

> cd PyFITS

> python setup.py install

And you are all set!

More documentation here: http://dan.iel.fm/kplr/ 

###Using the `kplr` package
In Julia, issue the following commands:

>julia> using PyCall
 
>julia> @pyimport pyfits
 
>julia> @pyimport kplr
 
>julia> client = kplr.API()
 
>julia> koi=client[:koi](952.01)

###Notes for using PyCall in Julia
The biggest diffence from Python is that object attributes/members are accessed with omyObject[:attribute] rather than myObject.attribute, and you use get(myObject, key) rather than myObject[key].
(This is because Julia does not permit overloading the . operator yet.)
See also the section on <code>PyObject</code> below, as well as the pywrap function to create anonymous modules that simulate . access (this is what <code>@pyimport</code> does).

#####Small example
For example, using <code>Biopython</code> we can do:

 >@pyimport Bio.Seq as s

 >@pyimport Bio.Alphabet as a

 >my_dna = s.Seq("AGTACACTGGT", a.generic_dna)

 >my_dna[:find]("ACT")

 >whereas in Python the last step would have been my_dna.find("ACT")

###Function List
<code>build_lightcurve.jl</code>: Builds a lightcurve for all the availible quarters.

<code>client_init.jl</code>: Loads PyCall, kplr and initializes the MAST API client.

<code>get_good_indices.jl</code>: A function that returns the non-NaN indices of an input array.

<code>GettingReading lightcurves.ipynb</code>: An interactive notebook where the 

<code>koi_get_data.jl</code>: A function that receives a **koi** and returns data for a given koi object.

<code>README.md</code>: This **README.md** file.

<code>rw_functions.jl</code>: A set of functions for reading and writing the lightcurve data for files. Currently contains only methods for **ascii** data but will also allow for **hdf5** rountines.
