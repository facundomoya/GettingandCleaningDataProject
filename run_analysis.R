# run_analysis.R
# Getting and Cleaning Data - Course Project
# Author: [Your Name]

# 1. Download and unzip dataset if it does not already exist
filename <- "dataset.zip"
if (!file.exists(filename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # On some systems you may want method = "auto" instead of "curl"
  download.file(fileURL, filename, method = "auto")
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# 2. Load the data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")   # do not force col.names here
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# NOTE: x_train/x_test were read without explicit col.names to avoid name-mismatch issues.
# We'll rely on column order (indices) when extracting mean/std columns.

# 3. Merge training and test datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged <- cbind(Subject, Y, X)

# 4. Extract only the measurements on the mean and standard deviation
#    Use numeric indices to avoid mismatch if column names were altered by read.table.
selected_feature_indices <- grep("mean\\(\\)|std\\(\\)", features$functions)  # indices relative to features
# In Merged, the X columns start at position 3, so add 2 to map to Merged columns
columns_to_keep <- c(1, 2, 2 + selected_feature_indices)
TidyData <- Merged[, columns_to_keep]

# 5. Replace activity codes with descriptive names
#    Use numeric indexing on the second column (activity codes)
TidyData[, 2] <- activities[TidyData[, 2], 2]

# 6. Label the dataset with descriptive variable names
names(TidyData)[1] <- "subject"
names(TidyData)[2] <- "activity"

# Assign the original feature names to the measurement columns (optional, clearer)
measurement_names <- features$functions[selected_feature_indices]
names(TidyData)[3:ncol(TidyData)] <- measurement_names

# Make names more descriptive / R-friendly
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData) <- gsub("BodyBody", "Body", names(TidyData))
names(TidyData) <- gsub("Mag", "Magnitude", names(TidyData))
names(TidyData) <- gsub("^t", "Time", names(TidyData))
names(TidyData) <- gsub("^f", "Frequency", names(TidyData))
names(TidyData) <- gsub("tBody", "TimeBody", names(TidyData))
names(TidyData) <- gsub("-mean\\(\\)", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-std\\(\\)", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("-freq\\(\\)", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData) <- gsub("angle", "Angle", names(TidyData))
names(TidyData) <- gsub("gravity", "Gravity", names(TidyData))
# remove remaining parentheses and dashes just in case
names(TidyData) <- gsub("[()\\-]", "", names(TidyData))

# 7. Create a second tidy dataset with the average of each variable for each activity and each subject
library(dplyr)
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise(across(.cols = where(is.numeric), .fns = mean), .groups = "drop")

# 8. Save the final tidy dataset as a .txt file
write.table(FinalData, "tidy_dataset.txt", row.name = FALSE)
