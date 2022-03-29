# spectral libraries import routine
# imports two pre-processed libraries

# currently works from the preprocessed files, needs to run from the data exported from clarity

import_spec_lib <-function(lib1file, lib1sheet, lib2file, lib2sheet) {
  df.SpecLib_1 <- readxl::read_excel(lib1file,
                                  sheet = lib1sheet,
                                  .name_repair = "universal") 
  df.SpecLib_2 <- readxl::read_excel(lib2file,
                                     sheet = lib2sheet,
                                     .name_repair = "universal") 
  df.SpecLib_bind <- dplyr::bind_rows(df.SpecLib_1, df.SpecLib_2)
  df.SpecLib <- df.SpecLib_bind %>% dplyr::distinct(Spectra, .keep_all = TRUE)
  return(df.SpecLib)
  
}