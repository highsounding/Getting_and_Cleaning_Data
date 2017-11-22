Here are my steps to clean the data:


1. Create build\_full\_data() function to build full tidy data.

	- First, read feature and activity information and store the descriptive names into vectors;  
	- From features vector, extract names containing "mean" and "std", record their index and names;  
	- Read activity and subject value of train set, combine them into single data frame;  
	- Read train set data into a 561 columns data frame, extract data related to "mean" and "std" based on index obtained in previous step to form a 79 columns new data frame;    
	- Combine the new data frame with subject and activity data frame to build the final full data set as project requirement;  
	- Update the column names so that all of them meet the requirement (descriptive, no bracket, all lower, etc.);  
	- Update the activity value to descriptive factors  

2. In the main flow of program, following jobs done:
	- First call build\_full\_data() function to build the tidy full data set;
	- Set double loop to group the full data into small set by different subject and activity;
	- In the 3rd loop, calculate the average value for each measure data, and form a 1-line, 81-columns data frame for each small set;
	- Combine all the small data frame to form a full data set of average value for every combination of subject and available activity;
	- Update the column names and output the average value data set.

Note:  
You can run the script and output tidy data set as following stes:  

1. Unzip the Samsung data set to extract "UCI HAR Dataset";  
2. Put run_analysis.R script in the same parent folder as "UCI HAR Dataset";  
3. In RSdudio, set working directory to "UCI HAR Dataset";  
4. Use source command to run script, then data set would be generated.
