##Load the data.table and dplyr library packages
library(data.table)
library(dplyr)

##Open file with measurement data column names
measure_dt <- fread("features.txt")

##Open files with Subject information and combine them
subject_dt <- rbind(fread("test/subject_test.txt"),fread("train/subject_train.txt"))

##Open files with activity information and combine them
y_dt <- rbind(fread("test/y_test.txt"),fread("train/y_train.txt"))

##Open files with measurement data and combine them
x_dt <- rbind(fread("test/X_test.txt"),fread("train/X_train.txt"))

##Combine three test tables to create test data set
main_dt <- cbind(subject_dt,y_dt,x_dt)

##Apply column names to data table
names(main_dt) <- c("Subject","Activity",measure_dt[[2]])

##Create subset of data with only mean and std dev data columns
     ##First create a list of column names containing mean()
mean_cols <- grep("mean()",names(main_dt))
     ##Second create a list of column names containing std()
std_cols <- grep("std()",names(main_dt))
     ##Third create an ordered list including the Subject, Activity, mean and std columns
all_cols <- sort(c(1,2,mean_cols,std_cols))
mean_and_std_dt <- select(main_dt,all_cols)

##Open file with activity names
activity_dt <- fread("activity_labels.txt")
##Apply column name
names(activity_dt) <- c("Activity.Number","Activity")

##Merge mean_and_std_dt with activity_dt
mean_and_std_dt <- merge(activity_dt,mean_and_std_dt,by.x = "Activity.Number", by.y = "Activity")
mean_and_std_dt$Activity.Number <- NULL

##Create a summary table by Activity and Subject with the mean value of each data variable
summary_dt <- mean_and_std_dt %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
##Arrange by Activity and Subject
summary_dt <- arrange(summary_dt, Activity, Subject)

##Create file containing summary table
write.table(summary_dt,file = "tidy_data.txt",row.names = FALSE)
