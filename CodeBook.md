## Variables Containing Raw Data
* x_train_raw: data frame read from "train/X_train.txt".
* y_train_raw: data frame read from "train/y_train.txt".
* subject_train_raw = data frame read from "train/subject_train.txt".
* x_test_raw: data frame read from "test/X_test.txt".
* y_test_raw: data frame read from "test/y_test.txt".
* subject_test_raw = data frame read from "test/subject_test.txt".
* feature_raw: data frame read from features.txt"。
* activity_label_raw = data frame read from "activity_labels.txt".

## Requirement 1: Merges the training and the test sets to create one data set
Use `rbind()` to combine the train data and the test data. 
```
x_train_test = rbind(x_train_raw, x_test_raw) 
y_train_test = rbind(y_train_raw, y_test_raw) 
subject_train_test = rbind(subject_train_raw, subject_test_raw) 
```

## Requirement 2: Extracts only the measurements on the mean and standard deviation for each measurement
```
mean_std_index = grep("(mean|std)\\(", feature_raw[,2])
x_train_test_mean_std<-x_train_test[, mean_std_index]
```
`grep("(mean|std)\\(", feature_raw[,2])` returns the indices of the features whose name contain `mean(` or `std(`. Thus `x_train_test_mean_std` only contains the measurements (columns) on mean and standard deviation. 

## Requirement 3: Uses descriptive activity names to name the activities in the data set
Mapping the activity indices to meaningful labels by using `activity_label_raw`.
```
y_train_test_label<-data.frame(activity_label_raw[y_train_test[,1],2])
```

## Requirement 4: Appropriately labels the data set with descriptive variable names. 
names(x_train_test_mean_std)<-feature_raw[mean_std_index,2]
names(y_train_test_label)<-"Activity"
names(subject_train_test)<-"Subject"





