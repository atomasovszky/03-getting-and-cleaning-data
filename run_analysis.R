
# GETTING DATA ----------------------------------------------------------------------------------------------------

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("data.zip")) download.file(url, "data.zip")
unzip("data.zip")
list.files("UCI HAR Dataset/test")



# READING DATA TO R -----------------------------------------------------------------------------------------------

feature_file <- "UCI HAR Dataset/features.txt"
features <- read.table(feature_file)
names(features) <- c("index", "name")
relevant_cols <- features[grepl("mean\\(|std\\(", features$name), ]

activity_file <- "UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(activity_file)
names(activity_labels) <- c("id", "name")

test_files <- list.files("UCI HAR Dataset/test", "txt$", full.names = TRUE)
test_list <- lapply(test_files, function(test_file) {
  read.table(test_file)
})
sapply(test_list, str)


train_files <- list.files("UCI HAR Dataset/train", "txt$", full.names = TRUE)
train_list <- lapply(train_files, function(train_file) {
  read.table(train_file)
})
sapply(train_list, str)


intersect(
  unique(test_list[[1]][[1]]),
  unique(train_list[[1]][[1]])
) # no intersection between the subjects in train and test



# BINDING COLUMNS TOGETHER ----------------------------------------------------------------------------------------

test <- cbind(
  test_list[[1]],
  setNames(test_list[[2]][, relevant_cols$index], relevant_cols$name),
  test_list[[3]]
)

train <- cbind(
  train_list[[1]],
  setNames(train_list[[2]][, relevant_cols$index], relevant_cols$name),
  train_list[[3]]
)



# MERGING TEST AND TRAIN ------------------------------------------------------------------------------------------

data <- rbind(train, test)



# LABELING FIELDS AND VALUES --------------------------------------------------------------------------------------

names(data)[1] <- "subjectId"
names(data)[ncol(data)] <- "activity"

data$activity <- sapply(data$activity, function(activity) {
  activity_labels[activity_labels$id == activity, "name"]
})



# AGGREGATING -----------------------------------------------------------------------------------------------------
library(data.table)
data <- as.data.table(data)
data_aggr <- data[, lapply(.SD, mean, na.rm = T), .(subjectId, activity)]
data_aggr



# WRITING CLEAN FILE ----------------------------------------------------------------------------------------------

write.table(data_aggr, "03-getting-and-cleaning-data_clean-file.txt", row.names = F)
