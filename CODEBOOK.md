---
output:
  html_document: default
  pdf_document: default
---

# fetching file from internet

this part will fetchs the .zip file from the given link 
then check for existing file or directory 
if doesn't exist it will create the file/directory and download and save 
the .zip file in directory 

#Unzipping 

After saving the file in local directory or working directory 
We need to unzip the given file to extract the files required for
cleaning and analysis in **UCI HAR Dataset**

# Reading 

After UnZipping the file we will read required file using fread() method for faster
reading and set column Name accordingly for appropriate tables
```
feat<-features.txt : this file contains features
activity<-activity_labels.txt : this file contains names of activity
sub_test<-test/subject_test.txt : 
sub_train<-train/subject_train.txt : 
x_test<-test/X_test.txt : features test data
x_train<-train/X_train.txt : features train data 
y_test<-test/Y_test.txt : test data of activity
y_train<-train/Y_train.txt : train data of activity
```
# Merging

Now we will merge test and train dataframe/tables for cleaning process
we will use rbind() and cbind() methods to merge the dataframes

```
mergeX<-x_test and x_train using rbind()
mergeY<-y_test and y_train using rbind()
mergeSub<-sub_test and sub_train using rbind()
mergedD<-mergeSub,mergeX and mergeY using cbind()
```

# Extracting required Measurements

According to question we gone fetching only columns having data set related to 
subject,activity,mean and standard deviation
this subsetting is performed using dplyr packages select() method
with its attributes such as contains() for pattern matching

```
tidydataset is created by subsetting mergeD, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

tidydataset<-mergedD%>%select("subject","code",contains("mean"),contains("std"))
```
here the contains("mean") and contains("std") will fetch all column names which contains mean and std in it.

# Descriptive activity names to name the activities in the data set

we gone use activity dataframe to set activity name in the new  tidydataset
```
tidydataset$code<-activity[tidydataset$code,2]
```
this line will take data in 2 column  of activity data frame that is activityName and assign it to  tidydataset$code column with appropriate code match

# Appropriately labels the data set with descriptive variable names.

for this task we gone use gsub() method to rename/replace new variable name to make it more readable and easy to understand
following are renamed correspondingly
```
"subject"<-"Sub"
All "_" <-"" with nospace
"code"<-"ActivityName"
All "()"<-"" with nospace
All "acc"<-"Accelerometer"
All "gyro"<-"Gyroscope"
All "^t" <-"Time" this rename only if 't' appears in the start of string or column name
All "^f" <-"Frequency" this rename only if 'f' appears in the start of string or column name
All "BodyBody" <-"Body"
All "tBody"<-"TimeBody"
All "Mag"<-"Magnitude"
All "gravity"<-"Gravity"
All "angle"<-"Angle"
All "mean"<-"Mean"
All "std"<-"Std"
All "Freq"<-"Frequency"
All "Frequencyuency"<-"Frequency"

this all are run with ignore.case =TRUE to make user pattern matching much faster
```
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First we will create a new independent tidy data set with the average of each variable for each activity with each subject
we will use pipelining method for this line of code to make it compact and readable
first we will group the dataframe by subject and activityName column of tidydataset
after that we gone use summarise_all() method to summarize all the columns in dataset using mean function once all this is done we gone assign the resulting tidy data set to new variable **ResultTidy**

```
ResultTidy<-tidydataset%>%group_by(Sub,ActivityName)%>%summarise_all(mean)
```

Now writing the new dataset into directory to save it.

```
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
```
in the script part we gone take filename from User and then check for its existance and create it,if the file exists the block will prompt the user to enter new name with file extension. i.e ".txt"

# to create CSV file formate of the tidy data

if you want to save a copy of the tidy data set has a CSV file run following line:

```
write.csv(ResultTidy,"ResultTidy.csv")
```
