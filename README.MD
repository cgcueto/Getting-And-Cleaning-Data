#Getting and Cleaning Data: Course Project
##Introduction

This repository contains the work for the course project for the Coursera course "Getting and Cleaning data".

This document describes how the run_analysis.R script works.

##Download
The first step is to download the data from the address provided in the instructions. The script downloads and unzip the data and saves it in a folder called DATA under the working directory

##Open Data
The next step is to open the data into R. All the datasets needed for the project are read using read.table function

##Data Process
Next data is proceseed.
First the Subject is added in a new column to the train and test datasets.
Then a new column with the Activity is added to both datasets.
Both datasets are merged using rbind. Activity and Subject ID are added as columns names.
A new table (m) is created filtering out variables that are not mean or std
Then the Activity are replaced by the names that describe the activity 
Finally, the variable names are changed for others more descriptive

##Tidy Data
From the result of the previous steps a new data table is created (td). It groups the data per Subject and Activity applying mean.
This data is saved as .txt file in the same location where the original data was saved.
