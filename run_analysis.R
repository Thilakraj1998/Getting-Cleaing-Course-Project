#package
library(data.table)
library(tidyr)
library(dplyr)
#file
zipfileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(file.exists("data")){
    download.file(zipfileurl,destfile = "./data/dataset.zip")
} else {
    dir.create("data")
    download.file(zipfileurl,destfile = "./data/dataset.zip")
}
#unzipping and reading files
unzip("./data/dataset.zip")
#reading and storing
feat<-fread("./UCI HAR Dataset/features.txt",col.names = c("no","func"))
activity<-fread("./UCI HAR Dataset/activity_labels.txt",col.names = c("act_code","activity"))
sub_test<-fread("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
sub_train<-fread("./UCI HAR Dataset/train/subject_train.txt",col.names = "subject")
x_test<-fread("./UCI HAR Dataset/test/X_test.txt",col.names = feat$func)
x_train<-fread("./UCI HAR Dataset/train/X_train.txt",col.names = feat$func)
y_test<-fread("./UCI HAR Dataset/test/Y_test.txt",col.names = "code" )
y_train<-fread("./UCI HAR Dataset/train/Y_train.txt",col.names  ="code")
#merging tables
mergeX<-rbind(x_test,x_train)
mergeY<-rbind(y_test,y_train)
mergeSub<-rbind(sub_test,sub_train)
mergedD<-cbind(mergeSub,mergeX,mergeY)
#only measurments extracted
tidydataset<-mergedD%>%select("subject","code",contains("mean"),contains("std"))
#fetching activity names from activity data table to new tidy data set column 
#to replace numbers of code to activity names
tidydataset$code<-activity[tidydataset$code,2]
#renaming column/variable name
names(tidydataset)<-gsub("subject","Sub",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("-","",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("code","ActivityName",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("\\()","",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("acc","Accelerometer",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("gyro","Gyroscope",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("^t","Time",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("^f","Frequency",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("BodyBody","Body",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("tBody","TimeBody",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("Mag","Magnitude",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("gravity","Gravity",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("angle","Angle",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("mean","Mean",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("std","Std",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("Freq","Frequency",names(tidydataset),ignore.case = T)
names(tidydataset)<-gsub("Frequencyuency","Frequency",names(tidydataset),ignore.case = T)
#final
ResultTidy<-tidydataset%>%group_by(Sub,ActivityName)%>%summarise_all(mean)
#writing into directory
fileName<-readline(prompt="Enter FileNames with .txt extension: ")
if(file.exists(fileName)){
    message("File already exists")
    newFileName<-readline(prompt="Enter FileNames : ")
    write.table(ResultTidy,newFileName,row.names = F)
    message("File Created")
}else{
    write.table(ResultTidy,fileName,row.names = F)
    message("File Created")
}
#to create CSV file formate of the tidy data
write.csv(ResultTidy,"ResultTidy.csv")
