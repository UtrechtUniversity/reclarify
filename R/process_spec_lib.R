# spectral libraries csv preprocessing routine

process_spec_lib <-function(file) {
  # load csv
  df.dataset <- utils::read.csv(file) 
  # transpose to put spectral names as columns
  df.dataset <- base::t(df.dataset_raw)
  df.dataset <- df.dataset_raw[, -c(1:ncol(df.dataset_raw))]
  df.dataset <- df.dataset_raw[df.dataset_raw == ".."] <- " "
  return(df.dataset)
}