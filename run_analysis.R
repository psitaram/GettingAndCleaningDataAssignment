# Merging data
X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
All_Subjects <- rbind(subject_train, subject_test)
All_Data <- cbind(All_Subjects, Y_data, X_data)

# Extracting mean and SD
MeanSD <- All_Data %>% select(subject, code, contains("mean"), contains("std"))

# Descriptive activity names
names(MeanSD)[2] = "activity"
MeanSD$activity<-activities[MeanSD$activity,2]

# Descriptive variable names
names(MeanSD)<-gsub("Acc", "Accelerometer", names(MeanSD))
names(MeanSD)<-gsub("gravity", "Gravity", names(MeanSD))
names(MeanSD)<-gsub("Gyro", "Gyroscope", names(MeanSD))
names(MeanSD)<-gsub("BodyBody", "Body", names(MeanSD))
names(MeanSD)<-gsub("Mag", "Magnitude", names(MeanSD))
names(MeanSD)<-gsub("^t", "Time", names(MeanSD))
names(MeanSD)<-gsub("^f", "Frequency", names(MeanSD))
names(MeanSD)<-gsub("angle", "Angle", names(MeanSD))

# Generating second dataset with average
SecondData <- MeanSD %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(SecondData, "SecondData.txt", row.name=FALSE)
