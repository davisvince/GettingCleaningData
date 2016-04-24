# Author:      Vincent Davis
# Created:     20140425

# Purpose: Coursera 'Getting & Cleaning Data' course final project

# Objective: Demonstrate ability to download, manipulate and output data to produce
# a 'tidy' dataset (a dataset ready to for further analysis), complete with a full
# description of all operations conducted on the data from raw to tidy and a codebook
# that details all data within the tidy dataset.  Note that readme (readme.md) and
# codebook (codebook.md) are available in separate files within this same repository.

# Project Description:
# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

#prelim: set the root directory, load required packages, and get data if needed

#set directory here; update to match your root directory:
setwd("D:/Documents/Education/Coursera/Data Science Specialization/GettingCleaningData/")

#we utilize the reshape2 library, so install if not available:
library(reshape2)

#now we download the raw data (zip file), if it does not already exist
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename<-"getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)){
     download.file(URL, filename)
}

#similarly if not already unzipped (directory exists), unzip now
if (!file.exists("UCI HAR Dataset")) { 
     unzip(filename) 
}

#Now on to the merging & cleaning...

#First, we'll want to merge our raw training and test data to have a single set
#load raw training data
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
#load raw test data
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
#now combine raw training and test data
full.data <- rbind(train.data,test.data)

#next, from objective (2), we only want the mean and standard dev
features<-read.table("UCI HAR Dataset/features.txt")

#this gives us two columns - numeric index and labels which should be char type
features[,2]<-as.character(features[,2])

#same process to extract descriptive activities from the raw txt file:
activity.labels<-read.table("UCI HAR Dataset/activity_labels.txt")
activity.labels[,2]<-as.character(activity.labels[,2])

#we use grep to target only the features we want, namely mean and std
target.features<-grep(".*mean.*|.*std.*",features[,2])
#this produces an index of the variables we want; we'll also want the names
target.features.names<-features[target.features,2]

#now we can subset our data to only the desired features:
full.data<-full.data[,target.features]

#later (objective 5) we'll be summarizing on activities and subjects
#we'll need to append that to our dataset

#combine raw training and test activities
train.activities<-read.table("UCI HAR Dataset/train/Y_train.txt")
test.activities<-read.table("UCI HAR Dataset/test/Y_test.txt")
full.activities<-rbind(train.activities,test.activities)

#same process for subjects
train.subjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
test.subjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
full.subjects<-rbind(train.subjects,test.subjects)

#now we can merge our full raw data with the full subjects and activities
full.data<-cbind(full.subjects,full.activities,full.data)

#with our dataset complete, we can focus on descriptive variable names and
#activities, using the labels we loaded earlier

#first, we want to clean up our variable names - removing special characters
#and cleaning up our Mean and Std names
target.features.names<-gsub('[-()]','',target.features.names)#remove specials
target.features.names<-gsub('mean','Mean',target.features.names)#cap mean
target.features.names<-gsub('std','Std',target.features.names)#cap std

#now apply our "clean" variable names
clean.names<-c("Subject","Activity",target.features.names)
colnames(full.data)<-clean.names

#next, apply descriptive activity names (replace numeric indicator with
#label from txt file as factor)
full.data$Activity <- factor(full.data$Activity, levels = activity.labels[,1], labels = activity.labels[,2])


#finally, we create a separate independent dataset from full.data
#which has the average of each variable for each subject & activity
#with 6 distinct activities and 30 subjects, we expect 6*30=180 records

#set subjects as factors to achieve this 
full.data$Subject <- as.factor(full.data$Subject)

#there are lots of ways to achieve this; here we will 'melt' a dataset
#down to unique combinations of subject, activity and features...
melted.full.data <- melt(full.data, id = c("Subject", "Activity"))

#then using this melted format, we dcast on our subject + activity combination
#across all variables (features), applying the mean function
tidy.data <- dcast(melted.full.data, Subject + Activity ~ variable, mean)

#now, we validate this tidy.data against our expected number of records
#we should have 81 columns by 180 records representing the average of each
#variable across all combinations of subject and activity
print(dim(tidy.data))

#We're good to go, now write this tidy.data output as one of our deliverables
write.table(tidy.data, "tidy.data.txt", row.names = FALSE, quote = FALSE,sep='\t')