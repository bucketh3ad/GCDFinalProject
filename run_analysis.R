library(dplyr)

features <- read.table("UCI HAR Dataset/features.txt")

test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt",
                   col.names = features$V2)

train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt",
                    col.names = features$V2)

merged <- rbind(test,train)

meanStdCols <- grep("mean[^F]|std",colnames(test))

meanStdData <- merged[,meanStdCols]

testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")$V1

trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")$V1

labels <- c(testLabels,trainLabels)

lfact <- factor(labels, labels = c("WALKING", "WALKING_UPSTAIRS",
                                   "WALKING_DOWNSTAIRS", "SITTING",
                                   "STANDING", "LAYING"))

meanStdData$Label <- lfact

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")$V1

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")$V1

meanStdData$Subject <- c(subjectTest,subjectTrain)

meanStdData <- mutate(meanStdData, sublab = paste(Subject,Label))

meanhelper <- function(x) {
    colMeans(x[1:66])
}

bysubjlab <- split(meanStdData,meanStdData$sublab)

bysubj <- lapply(bysubjlab,meanhelper)

newframe <- data.frame(matrix(unlist(bysubj), nrow = 180, byrow = T))

colnames(newframe) <- colnames(meanStdData)[1:66]

newframe$sublab <- names(bysubj)

newframe <- mutate(newframe,sublab = strsplit(sublab," "))

newframe$Subject <- lapply(newframe$sublab,first)

newframe$Subject <- as.numeric(newframe$Subject)

newframe$Label <- lapply(newframe$sublab,last)

newframe$Label <- unlist(newframe$Label)

newframe <- select(newframe, -sublab)

write.table(newframe, file = "tidydata.txt",row.names = FALSE)
