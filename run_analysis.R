library("dplyr")
library("data.table")
library("downloader")

############################################################################################################
##                                DOWNLOAD AND UNZIP DATA                                                 ##
############################################################################################################

if (!file.exists("./DATA")){
        dir.create("DATA")
}
if (!file.exists("./DATA/dataset.zip")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download(fileUrl, dest="./DATA/dataset.zip", mode="wb") 
        unzip("./DATA/dataset.zip",exdir = "./DATA")        
}

############################################################################################################
##                                      READ DATA                                                         ##
############################################################################################################

##Read data sets
test <- read.table("./DATA/UCI HAR Dataset/test/X_test.txt")
train <- read.table("./DATA/UCI HAR Dataset/train/X_train.txt")
##Read variable names , subject  and activity labels
vnames <- read.table("./DATA/UCI HAR Dataset/features.txt")
alabeltest <- read.table ("./DATA/UCI HAR Dataset/test/y_test.txt")
alabeltrain <- read.table ("./DATA/UCI HAR Dataset/train/y_train.txt")
testS <- read.table("./DATA/UCI HAR Dataset/test/subject_test.txt")
trainS <- read.table("./DATA/UCI HAR Dataset/train/subject_train.txt")
labels <- read.table("./DATA/UCI HAR Dataset/activity_labels.txt")


############################################################################################################
##                                   PROCESS DATA                                                         ##
############################################################################################################

##Adds the column identifying the subject
test <- cbind(test , testS)
train <- cbind(train , trainS)

##Add the column identifying the activity
test <- cbind(test , alabeltest)
train <- cbind(train , alabeltrain)

##Merge the two data sets
m<-rbind(test,train)

##Change the names of the variables
names(m) <- c(as.character(vnames[,2]),"Subject ID","Activity")

##Extract only the measurements on the mean and standard deviation for each measurement
m<-m[,grep("mean|std|Subject ID|Activity",names(m))]

##Replace Activity Column with descriptive names
m$Activity <- labels[m$Activity,2]

##Use readible variable names
names(m) <- gsub("^t", "Time", names(m))
names(m) <- gsub("^f", "Frequency", names(m))
names(m) <- gsub("Acc", "Accelerometer", names(m))
names(m) <- gsub("Gyro", "Gyroscope", names(m))
names(m) <- gsub("Mag", "Magnitude", names(m))
names(m) <- gsub("BodyBody", "Body", names(m))
names(m) <- gsub("[()]", "", names(m))


############################################################################################################
##                                     CREATE DATASET 2 AND WRITE                                         ##
############################################################################################################

##Aggregate all columns except Subject and Activity, group by subject and activity applying mean
td <- aggregate(m[,1:79],list(m$`Subject ID`,m$Activity),mean)
td <- rename(td, Subject = Group.1 , Activity = Group.2)

##Write new dataset
write.table(td, "./DATA/UCI HAR Dataset/TidyData.txt",row.names = FALSE)


