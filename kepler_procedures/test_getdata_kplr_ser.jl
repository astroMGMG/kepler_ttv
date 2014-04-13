# Big regression test
function test_getdata_kplr_ser()
    #Try running the KOI_luncher on a file with 3 koi objects, each in one row
    #This takes a while in serial
    #Note that we are using the "test_rw" keyword
    koi_launcher("koi_list.csv", "test_rw");
end
