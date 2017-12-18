# Getting and Cleaning Data - Project 1

## Introduction

The objective of this project was to prepare a tidy data set from smartphone accelerometer data collected by UCI. This document describes the variables, the data, and transformations performed to clean the data.

### Part 1: Merging training and test data sets
Straightforward merging of data frames. The accelerometer data is represented by `X`, whereas the activity is represented by `y`. In addition, the `subject` data, which contains information about the source of the data, was imported.

At this point, all columns lack descriptive names. Since the `y` and `subject` each consist of only one column, the names were manually defined here.

### Part 2: Extract only the features to do with mean and/or standard deviation
The names of the features used as columns in the `X` data are listed in `features.txt`. This is read in as a data frame. These feature names include a string containing the kind of statistic applied, followed by brackets, e.g. `tBodyAcc-mean()-X`. A regular expression was applied to pick only the columns that contained the strings `mean(` or `std(`. Columns that did not meet this criteria were dropped from the `X` data.

### Part 3: Give descriptive names to activities
The activity names and their corresponding numbers were listed in `activity_labels.txt`. This was used add a column containing the name of the activity to the `y` data frame.

### Part 4: Appropriately label the data set with descriptive names
The feature names had already been determined in Part 2, so here the `X` column names were updated accordingly. The `X`, `subject` and `Y` data are merged and saved as `merged_data.txt`.

### Part 5: Create a second, independent data set with average for each activity and subject
The `dplyr` library was used to group the data by `subject` and `activity_name` and calculate an average for each column. The data is saved as `merged_data_summarised.txt`.