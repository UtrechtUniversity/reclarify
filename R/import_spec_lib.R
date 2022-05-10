#' Import Spec Lib
#'
#' This function takes two excel spreadsheets with the spectral library output
#' that has already been processed and combines them into one library
#' It relies on data being preprocesesd by the earlier steps.
#'
#' @param lib1file Path to the first processed library as XLSX
#' @param lib1sheet The excel sheet name to pick the data from
#' @param lib2file Path to the second processed library as XLSX
#' @param lib2sheet The excel sheet name to pick the data from
#' @return A data frame containing a single particle library
#' @export

import_spec_lib <-function(lib1file, lib1sheet, lib2file, lib2sheet) {
  df.SpecLib_1 <- readxl::read_excel(lib1file,
                                  sheet = lib1sheet,
                                  .name_repair = "universal") 
  df.SpecLib_2 <- readxl::read_excel(lib2file,
                                     sheet = lib2sheet,
                                     .name_repair = "universal") 
  df.SpecLib_bind <- dplyr::bind_rows(df.SpecLib_1, df.SpecLib_2)
  df.SpecLib <- dplyr::distinct(df.SpecLib_bind, .keep_all = TRUE)
  return(df.SpecLib)
  
}