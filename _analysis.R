library(dplyr)

# 1. Merge training and test data sets.

df_X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
df_X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
df_X <- rbind(df_X_train, df_X_test)

df_y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names='activity_value')
df_y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names='activity_value')
df_y <- rbind(df_y_train, df_y_test)

df_subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names='subject')
df_subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names='subject')
df_subject <- rbind(df_subject_train, df_subject_test)


# 2. Extract only the features to do with mean and/or standard deviation

df_features <- read.table("UCI HAR Dataset/features.txt",
                          col.names=c('index', 'feature_name'))
feature_indexes <- grepl('mean\\(|std\\(', df_features$feature_name)
df_X <- df_X[, feature_indexes]
df_features <- df_features[feature_indexes, ]


# 3. Give descriptive names to activities

df_activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                            col.names=c('index', 'activity_name'))

get_activity_name <- function(activity_names, activity_number){
  return(activity_names[activity_number])
}

df_y$activity_name <- sapply(df_y$activity_value, get_activity_name,
                             activity_names=df_activities$activity_name)


# 4. Appropriately label the dataset with descriptive variable names

names(df_X) <- df_features$feature_name
df <- cbind(df_X, df_subject, select(df_y, activity_name))
write.csv(df, "merged_data.txt", row.names=FALSE)


# 5. Create a second, independent data set with average for each activity and subject.
g <- group_by(df, subject, activity_name)
df_summarised <- summarise_all(g, mean)
write.csv(df_summarised, "merged_data_summarised.txt", row.names=FALSE)

# A plot, just because...
# library(ggplot2)
# t <- ggplot(df_summarised, aes(x=subject, y=`tBodyAcc-mean()-X`))
# t + geom_line() + facet_wrap(~ activity_name)
