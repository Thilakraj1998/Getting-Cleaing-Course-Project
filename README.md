---
output:
  html_document: default
  pdf_document: default
---

# **Getting and Cleaning Data Course Project**
**This Repo show to work around a messy Data set and how to clean and re-store it in tidy data set format** 

### **DataSet**
**It has the instructions on how to run analysis on Human Activity recognition dataset.**

**DATASET** : <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

### **Files**
**CODEBOOK.md :** This file contains description about variables used in the 'run_analysis.R' script. and Other task performed for transformation.

**run_analysis.R :**This file consist of Script required to clean and transform the given Dataset to *Tidy Data Set*.

Following Tasks have been performed in the Script : 

* Download and store the file in local/working directory
* Unzip the downloaded file into appropriate directory
* Read the Files and give appropriate column names
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**Result.txt : ** This is the final Tidy data set after going through all the sequences described above to create clean and Tidy dataset for analysis.

**OUTPUT.pdf :** This is pdf file of complete task performed with final tidy dataset ouput