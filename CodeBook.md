# CodeBook

## Introduction
This CodeBook describes the variables, the data, and transformations performed to clean the Human Activity Recognition Using Smartphones dataset.

## Source Data
The original dataset comes from:
- [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Cleaning Steps
1. Merge training and test sets to create one data set.
2. Extract only measurements on the mean and standard deviation.
3. Use descriptive activity names.
4. Appropriately label the dataset with descriptive variable names.
5. Create a tidy dataset with the average of each variable for each subject and activity.

## Variables
- **subject**: Identifier for each participant (1–30).
- **activity**: Activity performed (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
- Other variables: Averaged sensor signals, measured by the smartphone accelerometer and gyroscope.
  - Example: `TimeBodyAccelerometerMeanX` = mean of body acceleration signal in X direction (time domain).
  - Example: `FrequencyBodyGyroscopeSTDZ` = standard deviation of gyroscope signal in Z direction (frequency domain).

## Units
- Accelerometer signals: Standard gravity units (g).
- Gyroscope signals: Radians per second.
- All variables in the final dataset are **averages** per subject and activity.
