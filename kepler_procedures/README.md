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
