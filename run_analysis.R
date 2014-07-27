

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","data.zip")
#unzip("data.zip")



trainData<-read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/train/subject_train.txt")

#Column bind the all of the train data
trainData<-cbind(trainData,read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/train/X_train.txt"),read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/train/y_train.txt"))




#Change the names of the columns to make them readable
colnames(trainData)<-c("Subject","Measure","Activity")



testData<-read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/test/subject_test.txt")
testData<-cbind(testData,read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/test/X_test.txt"),read.csv("C:/Users/Dawit/Documents/CourseProject/UCI HAR Dataset/test/y_test.txt"))

colnames(testData)<-c("Subject","Measure","Activity")


testData[,2]<-as.numeric(testData[,2])
trainData[,2]<-as.numeric(trainData[,2])


#Merge the datasets together
mergedData<-rbind(trainData,testData)

#Turn activity varaible into a factor variable
mergedData$Activity<-as.factor(mergedData$Activity)

#Group the activity variable
mergedData$Activity<-factor(mergedData$Activity,levels=c(1,2,3,4,5,6),labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

#This is the dataset
head(mergedData)

#PART 2
data<-aggregate(mergedData,by=list(mergedData$Subject,mergedData$Activity),mean,na.rm=T)

#Delete the columns that I do not need
data[,3]<-NULL
data[,4]<-NULL


#Change the variable names
colnames(data)<-c("SUBJECT","ACTIVITY","MEAN_MEASUREMENT")

#This is the dataset for part 2
write.csv(data,"TidyData.csv")