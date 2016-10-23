# Peer Graded Assignment

# Review criteria

# The submitted data set is tidy.
# The Github repo contains the required scripts.
# GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all 
#   the variables and summaries calculated, along with units, and any other relevant information.
# The README that explains the analysis files is clear and understandable.
# The work submitted for this project is the work of the student who submitted it.

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 4
# You will be required to submit: 
#   1) a tidy data set as described below, 
#   2) a link to a Github repository with your script for performing the analysis, and 
#   3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up 
#     the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.

library(reshape2)

setwd('/home/dpejcoch/Documents/Coursera/DataCleaningR/Project')

# download file from server
if (!file.exists("UCI HAR Dataset")) { 
  f <- file.path(getwd(), "data.zip")
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = f,
              method = "curl")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip ("data.zip", exdir = "./")
}

# load activity labels
f1 <- file.path(getwd(), "UCI HAR Dataset", "activity_labels.txt")
activities <- read.table(f1, header = FALSE)
activity_labels <- as.character(activities[,2])

# load features labels
f2 <- file.path(getwd(), "UCI HAR Dataset", "features.txt")
features <- read.table(f2, header = FALSE)
features_labels <- as.character(features[,2])

# load train data
f3 <- file.path(getwd(), "UCI HAR Dataset/train", "X_train.txt")
train_data <- read.table(f3)

f4 <- file.path(getwd(), "UCI HAR Dataset/train", "y_train.txt")
train_activities <- read.table(f4)

f5 <- file.path(getwd(), "UCI HAR Dataset/train", "subject_train.txt")
train_subject <- read.table(f5)


# load test data
f6 <- file.path(getwd(), "UCI HAR Dataset/test", "X_test.txt")
test_data <- read.table(f6)

f7 <- file.path(getwd(), "UCI HAR Dataset/test", "y_test.txt")
test_activities <- read.table(f7)

f8 <- file.path(getwd(), "UCI HAR Dataset/test", "subject_test.txt")
test_subject <- read.table(f8)

# You should create one R script called run_analysis.R that does the following:

# Step1: Merges the training and the test sets to create one data set.

train_data <- cbind(train_data, train_activities, train_subject)

test_data <- cbind(test_data, test_activities, test_subject)

merged_data <- rbind(train_data, test_data)

# Step2: Extracts only the measurements on the mean and standard deviation for each measurement.

restricted_features <- grep(".*mean.*|.*std.*", features_labels)
restricted <- c(restricted_features, length(features_labels)+1, length(features_labels)+2)

merged_data <- merged_data[restricted]

# Step3: Uses descriptive activity names to name the activities in the data set

restricted_features_names <- features[restricted_features,2]

# Standardize a little bit names
restricted_features_names = gsub('-mean', 'mean', restricted_features_names)
restricted_features_names = gsub('-std', 'std', restricted_features_names)
restricted_features_names <- gsub('[-()]', '', restricted_features_names)
restricted_features_names <- tolower(restricted_features_names)

# Step4: Appropriately labels the data set with descriptive variable names.

colnames(merged_data) <- c(restricted_features_names, "activity", "subject")

# Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

merged_data$activity <- factor(merged_data$activity, levels = activities[,1], labels = activities[,2])
merged_data$subject <- as.factor(merged_data$subject)

merged_data_melted <- melt(merged_data, id = c("subject", "activity"))
merged_data_mean <- dcast(merged_data_melted, subject + activity ~ variable, mean)

# create final data set and store in work directory
f9 <- file.path(getwd(),"tidy.txt")
write.table(merged_data_mean, f9, row.names = FALSE, quote = FALSE)

# dump variable names for codebook
meta <- names(merged_data_mean)
f10 <- file.path(getwd(),"codebook.txt")
write.table(meta, f10, row.names = FALSE, quote = FALSE)

