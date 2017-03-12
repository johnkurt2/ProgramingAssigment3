run_analysis<-function() {
  library("plyr")
  
  columnNumbers <- c(1:543)
  
  columnNames <- c("body.acc.mean.x", "body.acc.mean.y", "body.acc.mean.z", "body.acc.std.x", "body.acc.std.y", "body.acc.std.z", 
                   "gravity.acc.mean.z", "gravity.acc.mean.y", "gravity.acc.mean.z", "gravity.acc.std.x", "gravity.acc.std.y", "gravity.acc.std.z", 
                   "body.acc.jerk.mean.x", "body.acc.jerk.mean.y", "body.acc.jerk.mean.z", "body.acc.jerk.std.x", "body.acc.jerk.std.y", "body.acc.jerk.std.z", 
                   "body.gyro.mean.x", "body.gyro.mean.y", "body.gyro.mean.z", "body.gyro.std.x", "body.gyro.std.y", "body.gyro.std.z", "body.gyro.jerk.mean.x", 
                   "body.gyro.jerk.mean.y", "body.gyro.jerk.mean.z", "body.gyro.jerk.std.x", "body.gyro.jerk.std.y", "body.gyro.jerk.std.z", "body.acc.mag.mean",
                   "body.acc.mag.std", "gravity.acc.mag.mean", "gravity.acc.mag.std", "body.acc.jerk.mag.mean", "body.acc.jerk.mag.std", "body.gyro.mag.mean", 
                   "body.gyro.mag.std", "body.gyro.jerk.mag.mean", "body.gyro.jerk.mag.std", "f.body.acc.mean.x", "f.body.acc.mean.y", "f.body.acc.mean.z", 
                   "f.body.acc.std.x", "f.body.acc.std.y", "f.body.acc.std.z", "f.body.acc.jerk.mean.x", "f.body.acc.jerk.mean.y", "f.body.acc.jerk.mean.z",
                   "f.body.acc.jerk.std.x", "f.body.acc.jerk.std.y", "f.body.acc.jerk.std.z", "f.body.gyro.mean.x", "f.body.gyro.mean.y", "f.body.gyro.mean.z",
                   "f.body.gyro.std.x", "f.body.gyro.std.y", "f.body.gyro.std.z", "f.body.acc.mag.mean", "f.body.acc.mag.std", "f.body.body.acc.jerk.mag.mean", 
                   "f.body.body.acc.jerk.mag.std", "f.body.body.gyro.mag.mean", "f.body.body.gyro.mag.std", "f.body.body.gyro.jerk.mag.mean", 
                   "f.body.body.gyro.jerk.mag.std")
  maxRows <- -1
  
  activityLabels <- read.table( "C:/rdata/analyse/activity_labels.txt", stringsAsFactors=FALSE )
  
  readData <- function( dataType ) {
    # read datafile from datatype = environment test or train
    
    xPath <- paste0("C:/rdata/analyse/", dataType, "/X_", dataType, ".txt")
    yPath <- paste0("C:/rdata/analyse/", dataType, "/Y_", dataType, ".txt")
    subjectPath <- paste0("C:/rdata/analyse/", dataType, "/subject_", dataType, ".txt")
    fullData <- read.table(xPath, sep="", stringsAsFactors=FALSE, nrows=maxRows)[,columnNumbers]
    yData <- read.table(yPath, nrows=maxRows,col.names=c("number"))
    subjectData <- read.table(subjectPath, nrows=maxRows,col.names=c("subject"))
    colnames(fullData) <- columnNames
    fullData$activity <- activityLabels[yData$number,2]
    fullData$subject <- subjectData$subject
    fullData
  }    
  readTrainData <- function() {
    # read train data
    readData("train")
  }
  readTestData <- function() {
    # read test data
    readData("test")
  }
  readAll <- function() {
    # merge train data and test data
    rbind(readTrainData(), readTestData())
  }
  produceTidy <- function() {
    all <- readAll()
    process <- function (rows) {
      colMeans(rows[,1:66])
    }
    ddply( all, .(activity, subject), process )
  }
  # generate tidy dataset
  tidy <- produceTidy()
  # write tidy dataset to disc
  write.table(tidy, "c:/rdata/analyse/tidy.txt", sep=",")

}