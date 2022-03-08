# currently in development
# purpose: search a defined folder, stores all files in an array, and then loops the LDIR data process until all files are processed

# set up dependencies
library(logr)
library(filesstrings)
source("reclarify.R")
tmp <- " \output\temp.log" # this should be file.path with date to reduce errors, but what if the process is run twice in the same day? Maybe include time started

# start logfile
lf <- log_open("\") # is it necessary to define a new folder as logr automatically writes to a log folder anyway

# index folder and return all .xlsx files - setting full.names to FALSE means that the file path isn't stored in this array
# write file names successively to array
# info: https://www.geeksforgeeks.org/read-all-files-in-directory-using-r/
batch <- list.files(path="\raw", pattern="xlsx$", all.files=FALSE, full.names=FALSE)

# check if batch array is empty and quit program if so
if(is_empty(batch) == TRUE){
  log_print("No data files found for processing",
  quit(save="yes",status=0,runLast = TRUE)}

# begin loop (if n in array >= 1, else)
for i in batch 

# check file exists for certainty

if(file.exists("C:/path/to/file/some_file.txt") == TRUE){
  }
  
# feed variables into process

# wait for callback from script

# write confirmation to log and move file to processed folder
log_print("Sample XXXXX processed") # use paste to make this a valid filename 
file.move("C:/path/to/file/some_file.txt", "/processed")
log_print("Raw data file moved to processed directory")

# loop breakout - write failure to log file
log_print("Error in loop")

# else - write no results to log file
log_print("No data files found for processing")

# end loop and close log 
log_print("Batch processing completed sucessfully")   # it would be good to include the number of loops processed
log_close()

