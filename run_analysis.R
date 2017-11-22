library(dplyr)

# build the tidy data set
build_full_data <- function(){
    feature <- read.table("features.txt")   # read feature items
    activity <- read.table("activity_labels.txt")   # read descriptive activity names
    mean_or_std_seq <- grep('mean|std',feature$V2)  # extract items related to "mean" or "std" from features
    mean_or_std_names <- feature$V2[mean_or_std_seq]    # get descriptive names for "mean" or "std" features
    mean_or_std_names <- tolower(gsub('\\(|\\)','',mean_or_std_names))  # remove brackets and convert all characters to lower
    
    train_label <- read.table("train/y_train.txt")  # read label info for train set
    train_subject <- read.table("train/subject_train.txt")  # read subject info for train set

    train_temp <- cbind(train_label,train_subject)  # combine activity and subject info into single data frame
    names(train_temp) <- c("activity","subject")    # add descriptive column names
    train_temp[,'activity'] <- activity[train_temp[,'activity'],'V2']   # update activity value to descriptive factors
    
    training_set <- read.table("train/X_train.txt") # read train data set to data frame with 561 columns
    part_training_set <- select(training_set,mean_or_std_seq)   # extract only the columns related to "mean" or "std"
    names(part_training_set) <- mean_or_std_names   # add corresponding feature names for columns
    train <- cbind(train_temp,part_training_set)    # combine all columns into single data frame which contain all info of train set
    
    # similar as above code, just replace "train" with "test" to construct test data frame
    test_label <- read.table("test/y_test.txt")
    test_subject <- read.table("test/subject_test.txt")

    test_temp <- cbind(test_label,test_subject)
    names(test_temp) <- c("activity","subject")
    test_temp[,'activity'] <- activity[test_temp[,'activity'],'V2']
    
    testing_set <- read.table("test/X_test.txt")
    part_testing_set <- select(testing_set,mean_or_std_seq)
    names(part_testing_set) <- mean_or_std_names
    test <- cbind(test_temp,part_testing_set)
    
    
    full_data <- rbind(train,test)  # combine train and test data to build the final full data frame
    ordered_data <- full_data[order(full_data$subject),]    # order data set by subject
    ordered_data
}

final_data <- build_full_data() # call function build_full_data() to build the tidy full data set
average <- NA   # initialize the second data set

for (s in unique(final_data$subject)) {
    for (a in unique(final_data$activity)) {    
        temp <- filter(final_data, subject == s & activity == a)    # use double loop to divide full data into small set based on different subject and activity
        newline <- temp[1,]
        for (i in 3:81) {
            newline[1,i] <- mean(temp[,i])  # use the third loop to calculate average value for each measure data
        }
        if(is.na(average)){
            average <- newline
        }
        else{
            average <- rbind(average,newline)   # one by one put the average data together to build the data frame
        }
    }
}
names(average)[3:81] <- sub('^','avg-', names(average)[3:81])   # add "avg-" prefix for all measure data columns
average