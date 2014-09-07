
## See Readme.md for an analysis of the issue and description of the list of steps taken below.

## 1. Merges the training and the test sets to create one data set.

## The following files will be loaded:
    
## - 'activity_labels.txt': Links the class labels with their activity name.
activityLabels =  read.table("./UCI HAR Dataset/activity_labels.txt")

## - 'train/X_train.txt': Training set.
x_train_set <- read.table("./UCI HAR Dataset/train/x_train.txt")

## - 'train/y_train.txt': Training labels.
y_train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")

## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## - 'test/X_test.txt': Test set.
x_test_set <- read.table("./UCI HAR Dataset/test/x_test.txt")

## - 'test/y_test.txt': Test labels.
y_test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

## - 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Initial consolidation of loaded raw data:

## The one field in y_train_labels will be added to x_train_set as y_labelNumber
x_train_set[,"y_labelNumber"] <- y_train_labels$V1
## The one field in train_subjects will be added to x_train_set as subjectNumber
x_train_set[,"subjectNumber"] <- train_subjects$V1

## The one field in y_test_labels will be added to x_test_set as y_labelNumber
x_test_set[,"y_labelNumber"] <- y_test_labels$V1
## The one field in test_subjects will be added to x_test_set as subjectNumber
x_test_set[,"subjectNumber"] <- test_subjects$V1

## Now merge the training and the test sets to create one data set named data_set_raw
data_set_raw = rbind(x_test_set, x_train_set)

## 3. Uses descriptive activity names to name the activities in the data set

## Add the Activity Label by merging data_set_raw and activityLabels

## Change activity field from V2 to activity
activityLabels[,"activity"] <- activityLabels[,"V2"]
activityLabels[,"V2"] <- NULL

## Add the Activity Label
data_set_raw = merge( data_set_raw, activityLabels, by.x="y_labelNumber", by.y="V1", all=FALSE)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 4. Appropriately labels the data set with descriptive variable names. 

data_set <- as.data.frame( list( subject = data_set_raw$subjectNumber, activity = data_set_raw$activity, 
                                 timeDomainBodyAccelXmean = data_set_raw$V1, timeDomainBodyAccelYmean = data_set_raw$V2, 
                                 timeDomainBodyAccelZmean = data_set_raw$V3, timeDomainGravityAccelXmean = data_set_raw$V41, 
                                 timeDomainGravityAccelYmean = data_set_raw$V42, timeDomainGravityAccelZmean = data_set_raw$V43, 
                                 timeDomainBodyAccelJerkXmean = data_set_raw$V81, timeDomainBodyAccelJerkYmean = data_set_raw$V82, 
                                 timeDomainBodyAccelJerkZmean = data_set_raw$V83, timeDomainBodyGyroXmean = data_set_raw$V121, 
                                 timeDomainBodyGyroYmean = data_set_raw$V122, timeDomainBodyGyroZmean = data_set_raw$V123, 
                                 timeDomainBodyGyroJerkXmean = data_set_raw$V161, timeDomainBodyGyroJerkYmean = data_set_raw$V162, 
                                 timeDomainBodyGyroJerkZmean = data_set_raw$V163, timeDomainBodyAccelMagmean = data_set_raw$V201, 
                                 timeDomainGravityAccelMagmean = data_set_raw$V214, timeDomainBodyAccelJerkMagmean = data_set_raw$V227, 
                                 timeDomainBodyGyroMagmean = data_set_raw$V240, timeDomainBodyGyroJerkMagmean = data_set_raw$V253, 
                                 freqDomainBodyAccelXmean = data_set_raw$V266, freqDomainBodyAccelYmean = data_set_raw$V267, 
                                 freqDomainBodyAccelZmean = data_set_raw$V268, freqDomainBodyAccelXmeanFreq = data_set_raw$V294, 
                                 freqDomainBodyAccelYmeanFreq = data_set_raw$V295, freqDomainBodyAccelZmeanFreq = data_set_raw$V296, 
                                 freqDomainBodyAccelJerkXmean = data_set_raw$V345, freqDomainBodyAccelJerkYmean = data_set_raw$V346, 
                                 freqDomainBodyAccelJerkZmean = data_set_raw$V347, freqDomainBodyAccelJerkXmeanFreq = data_set_raw$V373, 
                                 freqDomainBodyAccelJerkYmeanFreq = data_set_raw$V374, freqDomainBodyAccelJerkZmeanFreq = data_set_raw$V375, 
                                 freqDomainBodyGyroXmean = data_set_raw$V424, freqDomainBodyGyroYmean = data_set_raw$V425, 
                                 freqDomainBodyGyroZmean = data_set_raw$V426, freqDomainBodyGyroXmeanFreq = data_set_raw$V452, 
                                 freqDomainBodyGyroYmeanFreq = data_set_raw$V453, freqDomainBodyGyroZmeanFreq = data_set_raw$V454, 
                                 freqDomainBodyAccelMagmean = data_set_raw$V503, freqDomainBodyAccelMagmeanFreq = data_set_raw$V513, 
                                 freqDomainBodyBodyBodyAccelJerkMagmean = data_set_raw$V516, freqDomainBodyBodyAccelJerkMagmeanFreq = data_set_raw$V526, 
                                 freqDomainBodyBodyGyroMagmean = data_set_raw$V529, freqDomainBodyBodyGyroMagmeanFreq = data_set_raw$V539, 
                                 freqDomainBodyBodyGyroJerkMagmean = data_set_raw$V542, freqDomainBodyBodyGyroJerkMagmeanFreq = data_set_raw$V552, 
                                 timeDomainBodyAccelXstd = data_set_raw$V4, timeDomainBodyAccelYstd = data_set_raw$V5, 
                                 timeDomainBodyAccelZstd = data_set_raw$V6, timeDomainGravityAccelXstd = data_set_raw$V44, 
                                 timeDomainGravityAccelYstd = data_set_raw$V45, timeDomainGravityAccelZstd = data_set_raw$V46, 
                                 timeDomainBodyAccelJerkXstd = data_set_raw$V84, timeDomainBodyAccelJerkYstd = data_set_raw$V85, 
                                 timeDomainBodyAccelJerkZstd = data_set_raw$V86, timeDomainBodyGyroXstd = data_set_raw$V124, 
                                 timeDomainBodyGyroYstd = data_set_raw$V125, timeDomainBodyGyroZstd = data_set_raw$V126, 
                                 timeDomainBodyGyroJerkXstd = data_set_raw$V164, timeDomainBodyGyroJerkYstd = data_set_raw$V165, 
                                 timeDomainBodyGyroJerkZstd = data_set_raw$V166, timeDomainBodyAccelMagstd = data_set_raw$V202, 
                                 timeDomainGravityAccelMagstd = data_set_raw$V215, timeDomainBodyAccelJerkMagstd = data_set_raw$V228, 
                                 timeDomainBodyGyroMagstd = data_set_raw$V241, timeDomainBodyGyroJerkMagstd = data_set_raw$V254, 
                                 freqDomainBodyAccelXstd = data_set_raw$V269, freqDomainBodyAccelYstd = data_set_raw$V270, 
                                 freqDomainBodyAccelZstd = data_set_raw$V271, freqDomainBodyAccelJerkXstd = data_set_raw$V348, 
                                 freqDomainBodyAccelJerkYstd = data_set_raw$V349, freqDomainBodyAccelJerkZstd = data_set_raw$V350, 
                                 freqDomainBodyGyroXstd = data_set_raw$V427, freqDomainBodyGyroYstd = data_set_raw$V428, 
                                 freqDomainBodyGyroZstd = data_set_raw$V429, freqDomainBodyAccelMagstd = data_set_raw$V504, 
                                 freqDomainBodyBodyAccelJerkMagstd = data_set_raw$V517, freqDomainBodyBodyGyroMagstd = data_set_raw$V530, 
                                 freqDomainBodyBodyGyroJerkMagstd = data_set_raw$V543) )

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## For the tidy set, I will produce a set of 180 records with each record having all the means for 
## each activity and each subject.

suppressWarnings(data_set_summary <- aggregate(data_set, by=(list(data_set$subject, data_set$activity)), FUN="mean") )

## I have suppressed warnings due to aggregate() trying to apply mean to the activity character column

## some tidying of the set
data_set_summary$activity <- data_set_summary$Group.2
data_set_summary$Group.2 <- NULL   ## No longer need Group.2
data_set_summary$subject <- data_set_summary$Group.1
data_set_summary$Group.1 <- NULL   ## No longer need Group.1

## Finally write the data_set_summary to a file named data_set_summary.txt

## Text file created with write.table() using row.name=FALSE

write.table(data_set_summary, "./data_set_summary.txt", row.name=FALSE)

        
                                                                                           