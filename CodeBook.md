## Codebook for the Getting and Cleaning Data Course Project

---

This Codebook aims to document the steps of the Course Project (done by the `run_analysis.R` script file) and to describe the result dataset.


### Source data

* Feature description

  `/UCI HAR Dataset/features.txt`

* Activity labels

  `/UCI HAR Dataset/activity_labels.txt`

* Train and test data                                                                 

  `/UCI HAR Dataset/test/.*txt`

  `/UCI HAR Dataset/train/.*txt`
  
  
### Result data variables

The result dataset contains the ID of the subjects, the labels for their activities, and 66 of the original 561 feature vectors. These features are the measurements of the mean and standard deviation of the original measurements. The 66 features are averaged over the subjectIds and the activities. 

* `subjectId` - ids of the subjects
* `activity` - activity labels
* `tBodyAcc-mean()-X`
* `tBodyAcc-mean()-Y`
* `tBodyAcc-mean()-Z`
* `tBodyAcc-std()-X`
* `tBodyAcc-std()-Y`
* `tBodyAcc-std()-Z`
* `tGravityAcc-mean()-X`
* `tGravityAcc-mean()-Y`
* `tGravityAcc-mean()-Z`
* `tGravityAcc-std()-X`
* `tGravityAcc-std()-Y`
* `tGravityAcc-std()-Z`
* `tBodyAccJerk-mean()-X`
* `tBodyAccJerk-mean()-Y`
* `tBodyAccJerk-mean()-Z`
* `tBodyAccJerk-std()-X`
* `tBodyAccJerk-std()-Y`
* `tBodyAccJerk-std()-Z`
* `tBodyGyro-mean()-X`
* `tBodyGyro-mean()-Y`
* `tBodyGyro-mean()-Z`
* `tBodyGyro-std()-X`
* `tBodyGyro-std()-Y`
* `tBodyGyro-std()-Z`
* `tBodyGyroJerk-mean()-X`
* `tBodyGyroJerk-mean()-Y`
* `tBodyGyroJerk-mean()-Z`
* `tBodyGyroJerk-std()-X`
* `tBodyGyroJerk-std()-Y`
* `tBodyGyroJerk-std()-Z`
* `tBodyAccMag-mean()`
* `tBodyAccMag-std()`
* `tGravityAccMag-mean()`
* `tGravityAccMag-std()`
* `tBodyAccJerkMag-mean()`
* `tBodyAccJerkMag-std()`
* `tBodyGyroMag-mean()`
* `tBodyGyroMag-std()`
* `tBodyGyroJerkMag-mean()`
* `tBodyGyroJerkMag-std()`
* `fBodyAcc-mean()-X`
* `fBodyAcc-mean()-Y`
* `fBodyAcc-mean()-Z`
* `fBodyAcc-std()-X`
* `fBodyAcc-std()-Y`
* `fBodyAcc-std()-Z`
* `fBodyAccJerk-mean()-X`
* `fBodyAccJerk-mean()-Y`
* `fBodyAccJerk-mean()-Z`
* `fBodyAccJerk-std()-X`
* `fBodyAccJerk-std()-Y`
* `fBodyAccJerk-std()-Z`
* `fBodyGyro-mean()-X`
* `fBodyGyro-mean()-Y`
* `fBodyGyro-mean()-Z`
* `fBodyGyro-std()-X`
* `fBodyGyro-std()-Y`
* `fBodyGyro-std()-Z`
* `fBodyAccMag-mean()`
* `fBodyAccMag-std()`
* `fBodyBodyAccJerkMag-mean()`
* `fBodyBodyAccJerkMag-std()`
* `fBodyBodyGyroMag-mean()`
* `fBodyBodyGyroMag-std()`
* `fBodyBodyGyroJerkMag-mean()`
* `fBodyBodyGyroJerkMag-std()`


### Steps of the analysis

#### Getting data

As a first step the script downloads the zip that contains the files for the Course Project (unless it is already downloaded) and unzip it to the project's root directory. 

#### Reading data to R

First the script reads the files containing the activity labels and the feature descriptions. It also names their two columns `id` and `name` respectively.

Secondly the script reads all the txt files in the train folder into a list of dataframes, then do the same for the fiels in the test folder as well.

#### Selecting relevant columns and binding them together
In the following steps the script combines the columns together in both the list of the test and train files. At the same time we select the 66 features that contain measurements of the mean and the standard deviation.

#### Merging test and train
In the next step the script simply combines the test and train dataframes from the previous step by row-binding them together. (This step is valid and can be done since there are no intersections between the subjects in the two datasets.)

#### Labeling fields and values
After combining the rows of the test and train dataframes together the script first give meaningful names to the columns using the features.txt file. Then it also lables the values of the activity variable.

#### Aggregating
As a last transformation step the script aggregates the feature variables using the data.table package. As a result the dataframe contains the averages of the 66 feature variables per subject and activity.

#### Writing clean file
Finally we write out the result dataframe to a txt file called `activity_data_clean.txt`