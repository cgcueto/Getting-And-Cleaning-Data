#Getting and Cleaning Data: Course Project
##Introduction

This documents explains how the script run_analysis.R works. This script has been developped for the final assignment of the Coursera course "Getting and Cleaning data".

The script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script uses *dplyr*, *data.table* and *downloader* packages.

##Download
The first step is to download the data from the address provided in the instructions. The script downloads and unzips the data and saves it in a folder called DATA under the working directory.

Original data for the project can be found [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Open Data
The next step is to open the data into R. All the datasets needed for the project are read using read.table function. After de data is opened, there are the following datasets available for processing:
* test:  Data Frame containing the test data
* train: Data Frame containing the train data
* vnames: Data Frame containing the names of the 561 variables for test and train data
* alabeltest: Data Frame containing the codes of the activities for the test data
* alabeltrain: Data Frame containing the codes of the activities for the train data
* testS: Data Frame containing the subjects for the test data
* trainS: Data Frame containing the subjects for the train data
* labels: Data Frame containing the descriptive names of the activities

##Data Process
Once all the data needed for the project has been read, the script will process it in order to make it tidy.
First the Subject and Activity are added in two new columns to the train and test datasets.
Both datasets are merged using rbind. The name of the 561 variables are added. Aslso Activity and Subject ID are added as variable  names.
A new table (m) is created filtering out variables that are not mean or std.
Then the Activity column is modified to substitute the code of the activity by its descriptive name. 
Finally, the variable names are changed for others more descriptive.

##Tidy Data
From the result of the previous steps a new data table is created (td). It groups the data per Subject and Activity applying a mean.
This data is saved as .txt file in the same location where the original data was saved.
