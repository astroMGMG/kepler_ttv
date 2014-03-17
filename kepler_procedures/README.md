The kplr package will provide the greatest functionality with the most ease.

This is a python package but can be used within Julia via the package "PyCall".

Example:
	using PyCall
	@pyimport kplr

tried doing:
	@pyimport kplr
	client = kplr.API()
	koi=client.koi(952.01)

	ERROR: client not defined

however the following works in python:
	import kplr
	client = kplr.API()
	koi=client.koi(952.01)


USEFUL NOTES FROM PyCall:
=========================
The biggest diffence from Python is that object attributes/members are accessed with o[:attribute] rather than o.attribute, and you use get(o, key) rather than o[key].
(This is because Julia does not permit overloading the . operator yet.)
See also the section on PyObject below, as well as the pywrap function to create anonymous modules that simulate . access (this is what @pyimport does).
For example, using Biopython we can do:

@pyimport Bio.Seq as s
@pyimport Bio.Alphabet as a
my_dna = s.Seq("AGTACACTGGT", a.generic_dna)
my_dna[:find]("ACT")
whereas in Python the last step would have been my_dna.find("ACT")


JUST TESTED THIS:
julia> koi=client[:koi](952.01)
PyObject <KOI("K00952.01")>

Therefore the kplr package will work within julia!
