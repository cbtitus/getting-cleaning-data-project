run_analysis <- function(){
        # Note: This function requires the dplyr library
        library(dplyr)
        
        # Assuming "UCI HAR Dataset" directory as unzipped is the working directory
        
        # read in column names from features.txt to "colnames"
        # these are all the variables that were measured
        colnames<-read.table("features.txt",header=F)
        colnames<-colnames$V2

        # do a little cleanup of the variable names to make it easier to read and select columns of interest
        # replace "mean()" with "mean_value"
        colnames<-sub("mean\\(\\)","mean_value",colnames)
        
        # replace "std()" with "std_dev"
        colnames<-sub("std\\(\\)","std_dev",colnames)
        
        # replace "-" with "_"
        colnames<-gsub("-",".",colnames)
        
        # replace "," with "_"
        colnames<-gsub(",","_",colnames)
        
        colnames<-gsub("Gyro","Gyroscope",colnames)
        colnames<-gsub("Acc","Accelerometer",colnames)
        colnames<-gsub("^t","Time",colnames)
        colnames<-gsub("^f","Freq",colnames)

        # read in activity_labels.txt, and name the columns "activity_id" and "activity"
        # this is the map of ids to activity names
        activity_id_labels<-read.table("activity_labels.txt",col.names=c("activity_id","activity"),header=F)

        # first we'll work on the training data
        
        # read in X_train.txt using colnames to name the columns
        # this is the training set of observations of 561 variables
        train_set<-read.table("train/X_train.txt",col.names=colnames,header=F) 
        
        # read in y_train.txt as the activity ids, name the column "activity_id"
        # this is the id of the activity for each observation
        train_activities<-read.table("train/y_train.txt",col.names="activity_id", header=F)
        
        # read in subject_train.txt, name the column "subject_id"
        # this is the subject of each observation
        train_subject_id<-read.table("train/subject_train.txt",col.names="subject_id",header=F)

        #cbind all together
        all_train_set<-cbind(train_subject_id,train_activities,train_set)

        #now, we repeate for the test data

        # read in X_test.txt using colnames to name the columns
        # this is the test set of observations of 561 variables
        test_set<-read.table("test/X_test.txt",col.names=colnames,header=F) 

        # read in y_test.txt as the activity ids, name the column "activity_id"
        # this is the id of the activity for each observation
        test_activities<-read.table("test/y_test.txt",col.names="activity_id", header=F)

        # read in subject_train.txt, name the column "subject_id"
        # this is the subject of each observation
        test_subject_id<-read.table("test/subject_test.txt",col.names="subject_id",header=F)

        #cbind all together
        all_test_set<-cbind(test_subject_id,test_activities,test_set)

        #now rowbind training and test sets together into a combined data set
        all_data_set<-rbind(all_train_set,all_test_set)
    

        # now we can merge activity labels
        all_data_set<-merge(all_data_set,activity_id_labels)

        # create a dataframe table - this requires the dplyr library
        all_data_set<-tbl_df(all_data_set) %>%

        # select subject, activity, and anything that's a mean or std, and drop activity_id
        select(subject_id,activity,grep("mean_value|std_dev",names(all_data_set)),-activity_id) %>%
                # group by the subject_id and the activity, so that we can summarize
                group_by(subject_id,activity) %>%
                        # use the summarize_each function to take the mean of every variable, and summarize by the groups
                       summarize_each(funs(mean))

                        # now we should have data frame that gives the mean of each measurement
                        # that was selected, for each subject_id, and for each activity
                write.table(all_data_set, "tidydata.txt", row.names=FALSE)

}
