# EXAMPLE APPLICATION FOR THE RECLARIFY CODE PACKAGE
# This programme takes the preprocessed data and exports a matched particle
# dataset as well as a pivottable
#
# https://github.com/UtrechtUniversity/reclarify

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.library("tidyverse")

# load dependencies
library("readxl")
library("pivottabler")
library("dplyr")
library("openxlsx")
library("reclarify")
library("svDialogs")

# set your sample ID, and the input and output file
SampleID <- dlgInput("Please enter Sample ID", default="")$res
InputFile <- file.choose(new = FALSE)
OutputCSV <- paste("output/",SampleID,"_particles.csv",sep="")
OutputXLSX <- paste("output/",SampleID,"_output.xlsx",sep="")

# import our spectral libraries from the reference dataset
df.SpecLib <- import_spec_lib("ref/HereonMPLib.xlsx","HereonMPLib","/ref/MPStarter1_0.xlsx")

# import our LDIR data from the raw folder
df.LDIRData <- read_excel(LDIRFile, sheet = "Particles", .name_repair = "universal") 

# bin and classify data
df.Output <- classify_spectral_data(df.LDIRData, df.SpecLib, HitRate = 0.9)

# output to csv to preserve particle grouping data before pivottable
write.csv(df.Output, OutputCSV, row.names = FALSE)

# create pivot table
# using guidance from http://www.pivottabler.org.uk/

pt <- PivotTable$new()
pt$addData(df.data_categorised) 
pt$addColumnDataGroups("diameter.binned")
pt$addRowDataGroups("Grouping")
PlasticFilter <- PivotFilters$new(pt, variableName="IsPlastic", values=1)
pt$defineCalculation(calculationName="Total", summariseExpression="n()", noDataValue=0)
pt$defineCalculation(calculationName="MPs", summariseExpression="n()", filters=PlasticFilter)
pt$evaluatePivot()
pt$renderPivot()

# create data frame for the summary statistics
df.SummaryStats <- data.frame(Characteristic=c("Sample ID","Total MPs"),
                              Value=c(SampleID, sum(df.data_categorised$IsPlastic == 1)))

# export to excel workbook
# create workbook with current user as the author
wb <- createWorkbook(creator = Sys.getenv("USERNAME"))
# add two worksheets, one for the pivottable, and another for the summary results
addWorksheet(wb, SampleID)
addWorksheet(wb, "Statistics")
# write the pivot table to the first worksheet
pt$writeToExcelWorksheet(wb=wb, wsName=SampleID, 
                         topRowNumber=1, leftMostColumnNumber=1, 
                         applyStyles=TRUE, mapStylesFromCSS=TRUE)
# write the summary statistics data frame to the second worksheet
writeData(wb=wb, "Statistics", df.SummaryStats, startCol = 1, startRow = 1
)

# export the whole file
saveWorkbook(wb, file = OutputXLSX, overwrite = TRUE)