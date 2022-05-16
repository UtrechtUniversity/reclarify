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
  df.loopdata <- dplyr::filter(LDIRData, Quality>=HitRate)
  # Filter again to remove rejected results
  df.loopdata <- dplyr::filter(df.loopdata, Is.Valid=="true")
  # joining the filtered data table with the spectra library
  df.loopdata <- base::merge(df.loopdata, SpecLib, by.x = "Identification", by.y = "Spectra", all.x = TRUE)
  df.loopdata <- dplyr::group_by(df.loopdata, Grouping)
  # binning data by predetermined size classes
  df.loopdata$diameter.binned <- base::cut(df.loopdata$Diameter..µm.,SizeClasses)
  # add IsPlastic flag to enable grouping in table
  df.loopdata$IsPlastic <- base::ifelse(df.loopdata$Grouping!="Natural components",1,0)
  return(df.loopdata)
}