# spectral data sorting and classification routine

classify_spectral_data <-function(input, library, output, sizeclasses, sizelabels) {
  df.data_step1 <- dplyr::filter(df.LDIRData, Quality>=0.8)
  # Filter again to remove rejected results
  df.data_filtered <- dplyr::filter(df.data_step1, Is.Valid=="true")
  # joining the filtered data table with the spectra library
  df.data_joined <- merge(df.data_filtered, df.SpecLib, by.x = "Identification", by.y = "Spectra", all.x = TRUE)
  df.data_joined %>% group_by(Grouping)
  
  # binning data by predetermined size classes
  df.data_binned <- df.data_joined %>% mutate(diameter.binned = cut(Diameter..μm., breaks=SizeClasses))
  
  # add IsPlastic flag to enable grouping in table
  df.data_categorised <- df.data_binned %>% mutate(IsPlastic = ifelse(Grouping!="Natural components",1,0))
  return(df.SpecLib)
  
}

# defaults to set up, can be overridden

SizeClasses <- c(0,10,50,100,200,500,900)
SizeTags <- c("(0,10]", "(10,50]", "(50,100]", "(100,200]", "(200,500]", "(500,900]")