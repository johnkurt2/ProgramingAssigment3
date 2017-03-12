this script is calling by run_analysis() and result will be write to c:/rdata/analyse/tidy.txt

It works this way:
first it call produceTidy
produceTidy first call readAll and then handle mean and call ddply
ReadAll rbind train and test data togther by call readTraindata and readTestdata
readTraindata and readTestdata call readData with parameter 'train' or 'test'
readdata has datatype = dataset as input
this function read files with columnname