# Cleaning_Final
Final assignment for R Getting and Cleaning Data

Info regarding the dataset is available from the UCI Machine Learning Repository:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script run_analysis.R imports the data from a folder:  download_folder on the users computer
In the download loop the stringr package is utilized to split the data by spaces.  gsub is also used to remove the .txt from the data frame names

The study subject (participant number) is added to the testing and training data frames.  The training and testing sets are combined. [full_frame]

Since only the mean and standard deviations are needed, the relevant columns are extracted from [full_frame] and those elements are bound to form [means_stdevs_frame]

Next the averages are calculated for each column in [means_stdevs_frame] by a group of "activity" and "subject" to form the tidy data set
