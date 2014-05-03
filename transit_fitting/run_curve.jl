@everywhere include("curve_fitting.jl")

timed=@elapsed multiple(10)
print(timed)
#filen=open("RCC_test_1.txt","w")
#writecsv(filen,timed)
#close(filen)
