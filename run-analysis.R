## GETTING DATA COURSE PROJECT

##Download the dataset file and unzip it into my R working directory

Dataset_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Dataset_url, "Dataset.zip")
unzip("Dataset.zip", exdir = "Dataset")

list.files("dataset") ## To have the list of files present in the dataset

## Read the files
x_test <- read.table("./Dataset/UCI HAR Dataset/test/X_test.txt", sep="", header= F)
y_test <- read.table("./Dataset/UCI HAR Dataset/test/y_test.txt", sep="", header= F)
subject_test <- read.table("./Dataset/UCI HAR Dataset/test/subject_test.txt", sep="", header= F)


x_train <- read.table("./Dataset/UCI HAR Dataset/train/X_train.txt", sep="", header= F)
y_train <- read.table("./Dataset/UCI HAR Dataset/train/y_train.txt", sep="", header= F)
subject_train <- read.table("./Dataset/UCI HAR Dataset/train/subject_train.txt", sep="", header= F)


## Merge the two data sets
x_comb <- rbind(x_test, x_train)

## Read the "features" file
features <- read.table("./Dataset/UCI HAR Dataset/features.txt", sep="", header= F)

## Read the "activity_label" file
activities <- read.table("./Dataset/UCI HAR Dataset/activity_labels.txt")

##Merge the rest of the files
y_comb <- rbind(y_test, y_train)
subject_comb <- rbind(subject_test, subject_train)

## Extract only the columns about the mean and standard deviation measurements
mean_std_col <- grep("mean|std",  features$V2)

x_comb <- x_comb[, mean_std_col]
names(x_comb) <- features[mean_std_col, 2]  ## Rename the columns 
names(x_comb)## check to see if the names changed
names(y_comb) <- "activity"
names(subject_comb) <- "subject"

## Merge all the data into one dataset
final_data1 <- cbind(x_comb, y_comb, subject_comb)

##Make the activity names more descriptive

final_data1$activity[which(final_data1$activity == 1)] <- "Walking"
final_data1$activity[which(final_data1$activity == 2)] <- "Walking upstairs"
final_data1$activity[which(final_data1$activity == 3)] <- "Walking downtairs"
final_data1$activity[which(final_data1$activity == 4)] <- "Sitting"
final_data1$activity[which(final_data1$activity == 5)] <- "Standing"
final_data1$activity[which(final_data1$activity == 6)] <- "Laying"

##Check to make sure the activity names changed in the dataset
head(final_data1)
tail(final_data1)



## Create a second independent tidy file with the average of each variable for each activy and subject

library(plyr)
tidy2 <- aggregate(final_data1, list(activity=final_data1$activity, subject=final_data1$subject), mean)

## Write file in a text format

write.table(tidy2, "tidy2.txt", row.name=FALSE)


