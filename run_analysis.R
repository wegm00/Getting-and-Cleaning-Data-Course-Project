
#Loading required packages
library(dplyr)
# we need to download the Data

rfilename <- "GCD_Final.zip"

# Checking if archieve exists.
if (!file.exists(rfilename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, rfilename)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(rfilename) 
}

#creating all data frames references

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# STEP 1.  we join test and training data to form one dataset
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
PSubject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(PSubject, y, x)

# STEP 2. now we only need the measurements on the mean and standard deviation for each activity
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# STEP 3. It´s time to change the code of the activity for it´s description
TidyData$code <- activities[TidyData$code, 2]

# STEP 4. Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#Step 5: From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.
FTidyData <- TidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(FTidyData, "TidyData.txt", row.name=FALSE)

