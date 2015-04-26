## Getting in the Test Data
        ## because we're planning to read in text tables without columns
        ## I am reading in 'features.txt' to use features$V2 as a character vector
        ## with the column names
                features <- read.table("features.txt")
        ## reading in the data from the test data set
                X.test <- read.table("test/X_test.txt")
                subject.test <- read.table("test/subject_test.txt")
                labels.test <- read.table("test/y_test.txt")
        ## name the X.test data using features
                colnames(X.test) <- features$V2
        ## add the subject id numbers and activity labels to the main X.test data table
                X.test$subject.id <- subject.test$V1
                X.test$activity.labels <- labels.test$V1
        ## creating a 'data.set' variable to prepare for the merge
                X.test$data.set <- "test"
## Getting in the Training Data
        ## this is the same process with 'train' replacing 'test'
                X.train <- read.table("train/X_train.txt")
                subject.train <- read.table("train/subject_train.txt")
                labels.train <- read.table("train/y_train.txt")
                colnames(X.train) <- features$V2
                X.train$subject.id <- subject.train$V1
                X.train$activity.labels <- labels.train$V1
                X.train$data.set <- "train"
## Merging test and train into one dataframe
        ##creating a merged dataframe using rbind
        merged.data <- rbind(X.test,X.train)
                ## Change 'Activities' column to use descriptive variable names
                ## read in activity labels
                labels <- read.table("activity_labels.txt")
                merged.data$activity.names <- labels$V2[merged.data$activity.labels]
## Selecting mean and standard deviation columns
        ## create a vector of column names
        col.names <- names(merged.data)
        ## select the relevant columns
        few.cols <- c(grep("mean",col.names), grep("std",col.names), "562", "565")
        ## subset merged data using the desired columns
        mean.std.merged <- merged.data[,as.numeric(few.cols)]

## Create a new dataframe which shows the means and standard devations of
## each variable by activity and subject
        ## load dplyr package
        install.packages("dplyr")
        library(dplyr)
        ## split dataset by activity
        tidy.data <- mean.std.merged %>% group_by(activity.names, subject.id) %>% summarise_each(funs(mean))        ## create data frame that finds column means by data
## print to text file
        write.table(tidy.data, file="tidydata.txt", row.names=FALSE)
## N.B.: Must read back in using header=TRUE, like so: read.table("tidydata.txt", header=TRUE)
