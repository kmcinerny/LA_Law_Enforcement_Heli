# Data Cleaning Workflow
Within the data-cleaning folder, there are a number of R files. Currently, I run the functions in these files in a particular order, because data within them depend on the previous file's functions. If someone can help suggest a workflow and file naming structure so that it is possible to run any of the functions at any time, please do!! 

I could also use advice on whether to copy/paste the function several times within a file to clean separate months of data, or whether to just replace the file name for a different month after I've written the new, cleaner csv file for each respective month.

In the meantime, please see below for the order by which I processed the files:

 ### 1. Write CSV with flight ID
    
    info: This creates unique IDs for each flight based on its group of positions
    
    file name: posM.YY_df.csv or posMM.YY_df.csv
    
    example: pos5.20_df.csv or pos10.19_df.csv

### 2. Select columns and mutate to PST
    ### info: 
    Original dataset in UTC, so this function converts it
    ### file name: 
    same as #1

### 3. Find outliers (& comment out mutate to PST line)
    ## info: 
    This creates a new variable that identifies whether a certain position is an outlier or not, based on the ascension/descension rate between it and the neighborhoring positions. Included a UTC-PST conversion, but because that would only exist within the function, we decided to create a separate, prior step for this time conversion.
    ### file name example: 
    pos5.20_outliers.csv

### 4. Exclude outliers
    ### info: 
    This removes the outliers we identified in the prior file from the dataset.

### 5. Spatial join
    info: 
    This is when we turn to QGIS to perform a spatial join between the position data and the LA County neighborhood file.
    ### file name example: pos5.20_hood.csv
