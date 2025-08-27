# Getting and Cleaning Data - Course Project

## Overview
This repository contains the work for the final project of the Getting and Cleaning Data course (Johns Hopkins University / Coursera).

The goal is to demonstrate how to collect, work with, and clean a dataset. The data used are from the accelerometers of the Samsung Galaxy S smartphone.

## Files
- **run_analysis.R**: The R script that processes the raw data.
- **tidy_dataset.txt**: The tidy dataset output required for submission.
- **CodeBook.md**: Explains the variables and transformations performed.
- **README.md**: Explains the project and how everything works.

## How to Run
1. Download the dataset and place it in your working directory.
2. Run `source("run_analysis.R")` in R.
3. The script will generate `tidy_dataset.txt` in the working directory.

## Output
The final tidy dataset contains the average of each variable for each activity and each subject (30 subjects × 6 activities).
