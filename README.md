# Getting-and-Cleaning-Data-Project
This project takes the original data files from "Human Activity Recognition Using Smartphones Dataset" and creates a compiled data set.  Along with the compiled data set, a summary data set is created and saved to a text file.
## Step 1:  Loading data into R
The following files are read into R as data tables:

  features.txt - This file contains the names of the variables in the data set.
  
  activity_labels.txt - This file contains the descriptive name sof the Activities in the data set.
  
  test/subject_test.txt - This file contains the information on the Subjects in the Test data set.
  
  test/y_test.txt - This file contains the information on the Activities in the Test data set.
  
  test/X_test.txt - This file contains all of the measurement data in the Test data set.
  
  train/subject_train.txt - This file contains the information on the Subjects in the Train data set.
  
  train/y_train.txt - This file contains the information on the Activities in the Train data set.
  
  train/X_train.txt - This file contains all of the measurement data in the Train data set.
## Step 2:  Merging the Train and Test data sets
The data tables containing the Test and Train information are combined into aggregate data tables using rbind.  This gives three data tables with the subject, y, and X data for both groups.
## Step 3:  Merging the Subject, Y and X data sets
The data tables created in Step 2 are merged using the cbind function to create the compiled data set.
## Step 4:  Naming the columns
The columns for the compiled data set are assigned by using the names() function and assigning the values of "Subject", "Activity", and the vector of measurement names from the features.txt file.
## Step 5:  Subsetting by Means and Std columns
A list of column names that contain the string "mean()" is created using the grep function.  Similarly, a list of column names that contain the string "std()" is created.  A sorted list of columns including the "Subject", "Activity", mean and std is usecd to select the columns for a new subset of the data.
## Step 6:  Merging the Activity Names
The list of activity names from the activity_labels.txt is merged into the subset data set matching the number of the activity in each data table.
## Step 7:  Summarizing the data set
The subset data table is grouped by Activity and Subject and then the summarize_each function is used to calculate the mean of each column.  The result is the tidy data set that gives the mean measurements of each variable for each Activity and Subject.  The resulting data set is saved to the working directory.
