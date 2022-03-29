# spectral libraries csv preprocessing routine

process_spec_lib <-function(file) {
  # load csv
  df.dataset <- utils::read.csv(file, header=FALSE, row.names=NULL) 
  # transpose to put spectral names as columns
  df.dataset <- base::t(df.dataset)
  # drops all the spectral data to make the data frame leaner
  df.dataset <- df.dataset[, -c(1:ncol(df.dataset_raw))]
  # remove the '(Absorbance)' element as this doesn't show up in clarity exports
  df.dataset <- gsub(" \\(Absorbance)", "", df.dataset)
  # remove the Â that appears before Mu
  df.dataset <- gsub("Â", "", df.dataset)
  # drop first row which contains irrelevant data
  df.dataset <- df.dataset[-1,]
  return(df.dataset)
}