# Getting and Cleaning Data - Course Project

## Overview
This repository contains the work for the final project of the Getting and Cleaning Data course (Johns Hopkins University / Coursera).  
The goal is to demonstrate how to collect, work with, and clean a dataset. The data used are from the accelerometers of the Samsung Galaxy S smartphone (UCI HAR Dataset).

The project outputs a tidy dataset that can be used for later analysis, along with documentation (`CodeBook.md`) and this `README.md` file.

---

## Files in this repository
- **run_analysis.R**: The main R script that processes the raw data step by step.
- **tidy_dataset.txt**: The tidy dataset output required for submission.
- **CodeBook.md**: Explains the variables, the source data, and the transformations performed.
- **README.md**: Explains the project and how everything works.

---

## How the script works

The script `run_analysis.R` performs the following steps:

1. **Download and unzip the dataset**  
   - Checks if the dataset exists in the working directory.  
   - If not, downloads the zip file and unzips it.

2. **Load the data**  
   - Reads feature names (`features.txt`) and activity labels (`activity_labels.txt`).  
   - Loads training and test data separately:  
     - `subject_train.txt`, `X_train.txt`, `y_train.txt`  
     - `subject_test.txt`, `X_test.txt`, `y_test.txt`

3. **Merge the datasets**  
   - Combines training and test data into one dataset (`Merged`).  
   - Includes subject IDs, activity codes, and all sensor measurements.

4. **Extract mean and standard deviation variables**  
   - Uses `grep()` to select only the measurements containing `mean()` or `std()`.  
   - Creates a reduced dataset (`TidyData`) with these variables, plus subject and activity.

5. **Apply descriptive activity names**  
   - Replaces activity codes (1–6) with their descriptive labels (WALKING, SITTING, etc.).

6. **Label the dataset with descriptive variable names**  
   - Renames columns to make them more descriptive (e.g., `tBodyAcc-mean()-X` → `TimeBodyAccelerometerMeanX`).  
   - Removes special characters and expands abbreviations for clarity.

7. **Create a second tidy dataset**  
   - Groups data by subject and activity.  
   - Calculates the **average of each variable** for each subject–activity pair.  
   - Produces the final dataset (`FinalData`).

8. **Save the tidy dataset**  
   - Writes the output to `tidy_dataset.txt` using `write.table()` with `row.name=FALSE`.

---

## How to run the script
1. Download the repo and place it in your R working directory.  
2. Run the script in R with:  

```r
source("run_analysis.R")
