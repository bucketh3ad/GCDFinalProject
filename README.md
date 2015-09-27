"run_analysis.R"

This script loads and cleans data from the Human Activity Recognition Using Smartphones data set using the following steps:

1. Load the test and train sets with features names, and merge them together

2. Use grep to reduce the columns to only the mean and sum features

3. Load the test and train labels and merge them

4. Create a factor for the labels, and add it to the data as Label.

5. Merge the subjects from test and train, and add it to the data as Subject.

6. Merge Subject and Label into sublab, and use it to split the data.

7. Take the column means of the split data set

8. Create a new data frame using the column means

9. Split sublab back into Subject and Label, with the approprite data types, and drop it from the new data frame.

10. Use write.table to export the new data frame as a text file.


