getting-cleaning-data-project
=============================

This repository contains the code and codebook for the "Getting and Cleaning Data" Week 4 Project.

Assignment
----------
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This repository
---------------
Within this repository are the following files:  
* run_analysis.R -- the R-script written to process the data for the assignment  
* CodeBook.md -- details about the data, the code, and the steps taken to process the raw data into the tidy data.  
* README.md -- this file  

run_analysis.R
--------------
The tidy data set can be constructed from the raw data using the R-script run_analysis.R, which was created for this assignment.  
### Assumptions and requirements for run_analysis():  

1. The dplyr library is required for the function run_analysis()
2. The raw dataset must be downloaded and unzipped, so that the folder "UCI HAR Dataset" is available
3. The working directory should be set to the folder "UCI HAR Dataset"

### Overview  

When the function run_analysis() is called, the raw data will be read from the working directory and subfolders and operated upon (described in detail in CodeBook.md). A tidy data set will be output back to the working directory as a file named "tidydata.txt", using the write.table() function. There are no parameters required for the script to run properly. Upon completion of the script, tidydata.txt should be able to be read back into R using 

    read.table("tidydata.txt", header=TRUE)
