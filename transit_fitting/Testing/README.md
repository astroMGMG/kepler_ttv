##Performance Testing

The notebook file <code>Comparison_tests.ipynb</code> contains plots and text describing the performance of our code, both serial and parallel. It uses the three .jl files listed in here for comparison. The final version of our code which was run on the RCC network is in the previous directory, as <code>curve_fitting.jl</code/>.

##Description of Files

#<code>curve_fitting_old.jl</code>

This is our original serial code. It is designed to read in an ASCII file, output a fitted light curve, and plot the fitted curve over the original data. Note that the plotting has been commented out for all these files, as here we are only concerned about run time, and Julia does not like plotting when using multiple processors.

#<code>curve_fitting_speed.jl</code>

An optimized version of the original serial code. We have replaced reading in ASCII files with binary files, and replaced concatenating variables with Julia's push! command. This greatly sped up the process.

#<code>curve_fitting_parallel.jl</code>

The parallelized version of our code. <code>@spawn</code> statements were added when finding the width, depth, and period of the light curve.

#<code>test_csv_huge_1.csv</code> and <code>test_binary_huge_1.dat</code>

Sample data files used for benchmarking. Note that the ipython notebook will have our functions read in 10 of these files. Only one file of each has been supplied due to the large file size, but the other 9 files used were identical.