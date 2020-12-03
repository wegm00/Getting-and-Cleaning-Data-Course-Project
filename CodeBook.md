# Data Introduction
* This project will use six data files, which are x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt, they can be found inside the downloaded zip file, namely **UCI HAR Dataset**.
* This zip file is downloaded in the current working directory
* The features.txt contains the correct variable name, which corresponds to each column of x_train.txt and x_test.txt.  explanation of each feature is in the features_info.txt.
* The activity_labels.txt contains the descriptive names for each activity which corresponds to each number in the y_train.txt and y_test.txt.
* The README.txt contains a global description of all the process of how  the experiment was developed.

# Modifing Data
* Merges the training and the test sets to create one data set. 
  + x is created by merging x_train and x_test
  + y is created by merging y_train and y_test
  + PSubject is created by merging subject_train and subject_test
  + finally we create Merged_data with Psubject, y and X
* Extracts only the measurements on the mean and standard deviation for each measurement.
  + TidyData comes from subsetting Merged_Data, with columns subject, code and the measurements on the mean and standard deviation.
* Uses descriptive activity names to name the activities in the data set
  + TidyData.code is replaced with its respective description from *activities* file
* Appropriately labels the data set with descriptive variable names.
  + Abbreviation were replaced by the full names using gsub function
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  + FtidyData comes from the means of each variable for each activity and each subject, after grouped by subject and activity. and finally is written to TidyData.txt file.
