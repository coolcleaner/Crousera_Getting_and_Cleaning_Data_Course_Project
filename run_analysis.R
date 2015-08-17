# loading library
library(dplyr)

#loading raw data from txt files
x_train_raw = read.table("train/X_train.txt")
y_train_raw = read.table("train/y_train.txt")
subject_train_raw = read.table("train/subject_train.txt")
x_test_raw = read.table("test/X_test.txt")
y_test_raw = read.table("test/y_test.txt")
subject_test_raw = read.table("test/subject_test.txt")
feature_raw = read.table("features.txt")
activity_label_raw = read.table("activity_labels.txt")

## Requirement 1: Merges the training and the test sets to create one data set. ##
x_train_test = rbind(x_train_raw, x_test_raw) 
y_train_test = rbind(y_train_raw, y_test_raw) 
subject_train_test = rbind(subject_train_raw, subject_test_raw) 

## Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement. ##
mean_std_index = grep("(mean|std)\\(", feature_raw[,2])
x_train_test_mean_std<-x_train_test[, mean_std_index]


## Requirement 3: Uses descriptive activity names to name the activities in the data set ##
y_train_test_label<-data.frame(activity_label_raw[y_train_test[,1],2])


## Requirement 4: Appropriately labels the data set with descriptive variable names. ##
names(x_train_test_mean_std)<-feature_raw[mean_std_index,2]
names(y_train_test_label)<-"Activity"
names(subject_train_test)<-"Subject"


## Requirement 5: From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.
data_set<-cbind(x_train_test_mean_std, y_train_test_label, subject_train_test)
tidy_data<-group_by(data_set, Subject, Activity) %>%
    summarise_each(funs(mean))%>%
    as.data.frame()

write.table(tidy_data,"tidy_data.txt", row.names = FALSE)

