# DataScience_Samsung_Project
The run_analysis.R file located in this repository is an R script designed to collect, manipulate and clean the raw data obtained during the Samsung Galaxy Smartphone study. 
The first 3 lines of the script allow to download , unzip and save the files into the working directory. The data are available here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Then,the files are loaded in the R console using the read.table command.
The next step is to merge the following files : x_test.txt, x_train.txt, y_test.txt, y_train.txt, subject_test.txt and subject_train.txt  using rbind().
The features.txt and activity_label.txt files are read in order to extract the measuremements on the mean and standard deviation(using the "grep" function) and to match the activity names with their corresponding numbers in the merged dataset.
Activities names are changed using the "which" function to be more descriptive. At this point we have a first processed dataset which is called "final_data1".
Based on this first processed dataset, a second tidy dataset(tidy2) is created with the "aggregate" function to calculate the mean of each variable for each activity and each subject.
Finally, the tidy file is saved as a text file.

