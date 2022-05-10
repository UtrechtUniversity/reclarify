#' Classify Spectral Data
#'
#' This function inspects a pre-loaded library, and then removes any particles
#' with a match lower than 0.8, and/or that have been rejected in the sorting
#' sheet. It relies on data being preprocesesd by the earlier steps.
#'
#' @param LDIRData Data frame containing LDIR particle analysis data
#' @param SpecLib Data frame containing spectral family mappings
#' @param HitRate Quality rate lower bound as decimal
#' @param SizeClasses Array of integers for size binning
#' @return Input dataset classified by polymer family and identified as plastic or not
#' @export

classify_spectral_data <-function(LDIRData, SpecLib, HitRate = 0.8, SizeClasses = c(0,10,50,100,200,500,900)) {
  # remove values below hit rate
  LDIRData <- dplyr::filter(LDIRData, Quality>=HitRate)
  # Filter again to remove rejected results
  LDIRData <- dplyr::filter(LDIRData, Is.Valid=="true")
  # joining the filtered data table with the spectra library
  LDIRData <- base::merge(LDIRData, SpecLib, by.x = "Identification", by.y = "Spectra", all.x = TRUE)
  LDIRData %>% dplyr::group_by(Grouping)
  # binning data by predetermined size classes
  LDIRData <- LDIRData %>% dplyr::mutate(diameter.binned = cut(paste0("Diameter..","\u00B5","m"), breaks=SizeClasses))
  # add IsPlastic flag to enable grouping in table
  LDIRData <- LDIRData %>% dplyr::mutate(IsPlastic = ifelse(Grouping!="Natural components",1,0))
  return(LDIRData)
}