---
title: "Getting and Cleaning Data | Codebook"
author: "Vincent Davis"
date: "April 24, 2016"
output: html_document
---

Author:      Vincent Davis
Created:     20140425

Purpose: This codebook provide information about the data within the tida.data.txt file which was produced as a result of downloading the raw data
within the archive located at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After unzipping this file, the following archive was created:
UCI HAR Dataset

This archive includes multiple files that are relevant to and used in the development of the tidy data set (tidy.data.txt) that resulted from the procedure in run_analysis.R (which is fully described in readme.MD).

#Relevant files include:
UCI HAR Dataset/train/X_train.txt: Test set variable data.
UCI HAR Dataset/train/Y_train.txt: Test set activity data.
UCI HAR Dataset/test/X_test.txt: Test set variable data.
UCI HAR Dataset/test/Y_test.txt: Test set activity data.
UCI HAR Dataset/features.txt: labels describing all variables.
UCI HAR Dataset/activity_labels.txt: labels describing all activities.
UCI HAR Dataset/train/subject_train.txt: subject identifier for train data.
UCI HAR Dataset/test/subject_test.txt: subject identifier for test data.

#Description of the train/test data variables (features)
The specific variables used in the train and test data are described below, taken from the "features_info.txt" file which is part of the raw zip file archive:

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

#The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Finally, it should be noted that for this exercise, only the mean() and std() (Mean value and Stardard deviation) estimates were kept.  This yielded 79 variables.

Further, these variables were ultimately summarized by taking the average of each variable's mean and stardard deviation across each subject and activity, producing the data in the "tidy.data.txt" file located in this same repository.  Collapsing the average value for each mean and std variable across 30 subjects and 6 activities produced 6 * 30 = 180 summarzied records in tidy.data.txt.