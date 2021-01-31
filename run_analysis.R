## Getting and Cleaning Data Course Project
library(stringr)
library(dplyr)


# Get the feature vector for column names
feature_file <- read.delim2("/Users/thejt/Desktop/MOOC/r_cleaning/features.txt", header = FALSE, stringsAsFactors = FALSE)
feature_file <- as.data.frame(str_split_fixed(feature_file$V1," +",str_count(feature_file[1,1], " +")+1))
feature_list <- as.data.frame(feature_file$V2)
feature_list[] <- lapply(feature_list, as.character)
  colnames(feature_list) <- c("x")
new_names    <- as.data.frame(c("activity", "subject"))
  colnames(new_names) <- c("x")
new_names    <- rbind(new_names, feature_list)
new_names[]  <- lapply(new_names, as.character)

download_folder <- "/Users/thejt/Desktop/MOOC/r_cleaning/download_folder/"
files <- list.files(download_folder)

#1. Merge the training and test sets to create one data set.
  # - Download and split columns, remove .txt from variable names, change to lower case names
for(i in 1:length(files)){
read_file <- read.delim2(paste(download_folder, files[i], sep = ""), header = FALSE)
read_file <- as.data.frame(str_split_fixed(read_file$V1," +",str_count(read_file[1,1], " +")+1))
assign(gsub(".txt","",tolower(files[i])), read_file) 
}
  # - Add the study subject to the training and testing frame
x_train$V1  <- subject_train$V1
x_test$V1   <- subject_test$V1
  # - Add the activity to the training and testing frame
train_frame     <- cbind(y_train, x_train)
test_frame      <- cbind(y_test,  x_test)
  # - Combine to make the full data set and convert to numeric
full_frame      <- rbind(train_frame, test_frame)
full_frame   <- as.data.frame(lapply(full_frame, function(x) as.numeric(as.character(x))))
  
  # - Name the columns
for(i in 1:ncol(full_frame)){
  names(full_frame)[i] <- new_names[i,1]
}
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

means   <-  grep("mean", colnames(full_frame))
stdevs  <-  grep("std", colnames(full_frame))
means_frame <- full_frame[, means]
stdevs_frame <- full_frame[, stdevs]
means_stdevs_frame <- as.data.frame(cbind(full_frame[,1:2],means_frame, stdevs_frame))
means_stdevs_frame <- as.data.frame(lapply(means_stdevs_frame, function(x) as.numeric(as.character(x))))

## 5. Create an average of each variable dataset.  (Activity & Subject)
mean_feature_list <- as.data.frame(feature_file$V2)
mean_feature_list[] <- lapply(mean_feature_list, as.character)
colnames(mean_feature_list) <- c("x")

activity_subject_average <- aggregate(means_stdevs_frame[,3:ncol(means_stdevs_frame)], list(means_stdevs_frame$activity,means_stdevs_frame$subject), mean)
  colnames(activity_subject_average)[1:2] <- c("activity","subject")
  colnames(activity_subject_average) <- tolower(colnames(activity_subject_average))


write.table(activity_average, file = "/Users/thejt/Desktop/MOOC/r_cleaning/download_folder/tidy_data.txt", row.name=FALSE)
