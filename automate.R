# currently in development
# as requested in https://github.com/joey4247/reclarify/issues/3
# purpose: search a defined folder, stores all files in an array, and then loops the LDIR data process until all files are processed

# set up dependencies
library(logr)
library(filesstrings)
source("reclarify.R")

# set up unique folders for this day (assuming script run once per 24hr)
runfolder <- paste0("processed/",as.Date(Sys.time(), sep = ""))
log.tmp <- paste0(workingdir,"/temp.log", sep = "")
dir.create(runfolder)

# start logfile
lf <- log_open(log.tmp, logdir = FALSE) 

# index folder and return all .xlsx files - setting full.names to FALSE means that the file path isn't stored in this array
# write file names successively to array
# info: https://www.geeksforgeeks.org/read-all-files-in-directory-using-r/
batch <- list.files(path="raw/", pattern="xlsx$", all.files=FALSE, full.names=FALSE)

# check if batch array is empty and quit program if so
if(length(batch) == 0){
  put("No data files found for processing",
  quit(save="yes",status=0,runLast = TRUE))}

# begin loop (if n in array >= 1, else)
for (i in batch)
  {
  sep(paste("Input file:", batch))
  
# check file exists for certainty, if it's been moved since the folder was indexed then it skips the file

if(file.exists(paste0("raw/",batch,sep="")) == FALSE){
  put("File moved from folder after indexing, skipping to next file")
  next}
  
# feed variables into process

# wait for callback from script

# write confirmation to log and move file to processed folder
put(paste(batch, "processed successfully, results saved to output folder."))
file.move(paste0("raw/", batch), "/processed")
put("Raw data file moved to processed directory successfully")

# end 'for' loop from line 30
}

# loop breakout - write failure to log file
put("Error in loop, exiting")

# might be wise here to add a catch-all/mudtrap

# end loop and close log 
put("Automated processing run complete")
log_close()

