function build_lightcurve 
# Loop over the datasets and read in the data.
time, flux, ferr, quality = [], [], [], []
for lc in lcs:
    with lc.open() as f:
	# The lightcurve data are in the first FITS HDU.
	hdu_data = f[1].data
	time[:append](hdu_data["time"])
	flux[:append](hdu_data["sap_flux"])
	ferr[:append](hdu_data["sap_flux_err"])
	quality[:append](hdu_data["sap_quality"])
