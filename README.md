Searching for TTVs in the Kepler data. Astro 585 semester project.


#Reading Material
The /paper directory has some useful papers.

A short description of them follows


#What are Transit Timing Variations?
Another quantity that can be measured is the midtime of the transit. By comparing
this value to the midtimes of previously measured transits, any variability in the period can
be constrained. These variations, called Transit Timing Variations or TTV, would indicate
the presence of a perturbing body in the system (Holman & Murray, 2005). For instance,
another planet in the system or a large moon around the planet could be detected. Upper
constraints on the mass of such a perturbing object can be made (C. V. Morley).

##A few assumptions




#Installation instructions

Either:
>> pip install kplr 

Or:
>>git clone https://github.com/dfm/kplr.git
>>cd kplr
>>python setup.py install 

And then within Julia:

Pkg.add("PyCall")

Pkg.update()

And you are all set!



##Installing `kplr`
Go to Github, and search for kplr in Julia
