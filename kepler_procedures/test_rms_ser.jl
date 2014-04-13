# Big regression test
function rms_test_ser()

    #Try running the KOI_luncher on a file with 4 koi objects, each in one row
    #This takes a while in serial

    #Note that we are using the "test" keyword
    koi_launcher("koi_list.csv", "test");
end
