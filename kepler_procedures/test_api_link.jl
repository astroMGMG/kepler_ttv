ERROR: PyError (PyObject_Call) <class 'urllib.error.URLError'>
URLError(gaierror(-2, 'Name or service not known'),)
  File "/usr/lib/python3.4/site-packages/kplr-0.1.10-py3.4.egg/kplr/api.py", line 233, in koi
    .format(float(koi_number)))
  File "/usr/lib/python3.4/site-packages/kplr-0.1.10-py3.4.egg/kplr/api.py", line 221, in kois
    return [KOI(self, k) for k in self.ea_request("cumulative", **params)]
  File "/usr/lib/python3.4/site-packages/kplr-0.1.10-py3.4.egg/kplr/api.py", line 111, in ea_request
    handler = urllib.request.urlopen(r)
  File "/usr/lib/python3.4/urllib/request.py", line 153, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python3.4/urllib/request.py", line 455, in open
    response = self._open(req, data)
  File "/usr/lib/python3.4/urllib/request.py", line 473, in _open
    '_open', req)
  File "/usr/lib/python3.4/urllib/request.py", line 433, in _call_chain
    result = func(*args)
  File "/usr/lib/python3.4/urllib/request.py", line 1261, in http_open
    return self.do_open(http.client.HTTPConnection, req)
  File "/usr/lib/python3.4/urllib/request.py", line 1238, in do_open
    raise URLError(err)

 in pyerr_check at /home/gks/.julia/PyCall/src/exception.jl:58
 in pycall at /home/gks/.julia/PyCall/src/PyCall.jl:85
 in fn at /home/gks/.julia/PyCall/src/conversions.jl:181
 in get_good_lightcurve_quarters at /home/gks/Dropbox/PSU/Courses/astro585/kepler_ttv/kepler_procedures/client_init.jl:43
 in koi_launcher at /home/gks/Dropbox/PSU/Courses/astro585/kepler_ttv/kepler_procedures/koi_launcher.jl:44
 in test_getdata_kplr_ser at /home/gks/Dropbox/PSU/Courses/astro585/kepler_ttv/kepler_procedures/test_getdata_kplr_ser.jl:6
while loading /home/gks/Dropbox/PSU/Courses/astro585/kepler_ttv/kepler_procedures/run_tests.jl, in expression starting on line 18

