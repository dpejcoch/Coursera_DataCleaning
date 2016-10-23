# Coursera: Getting and Cleaning Data Course Project (October 2016)

This is the course project for the Getting and Cleaning Data Coursera course.

## Requested steps provided by `run_analysis.R` script:

1. Download data from the repository and unzip downloaded file
2. Load data into R
3. Add activity and subject identifiers to traning and test data
3. Union training and test sets into single file
4. Restrict merged data to only the measurements on the mean and standard deviation for each measurement (+ activity and subject id).
5. Label restricted data using values from features.txt file
6. Standardize labels so they correspond to best practices
7. Appropriately label the data set with descriptive variable names (us labels for restricted data + add labless for activity and subject identifiers)
8. From the data set in step 4, create a second, independent tidy data set with group means of each variable by subject and activity
9. Export the result file to tidy.txt
10. Export column labels for the codebook

## Data sources:

* Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Metadata: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Results: 
* Tidy data set: `tidy.txt`
* Codebook: `Codebook.md`
* R code: `run_analysis.R`

## Citation requirements for source data:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
