# EXAMPLE APPLICATION FOR THE RECLARIFY CODE PACKAGE
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

# load your dependencies

library("readxl")
library("pivottabler")
library("dplyr")
library("openxlsx")
library("reclarify")

# set your sample ID, and the input and output file
SampleID <- "Sample1"
InputFile <- paste("raw/",SampleID,".xlsx",sep="")
OutputFile <- paste("output/",SampleID,"_output.csv",sep="")

# import our spectral libraries from the reference dataset
df.SpecLib <- import_spec_lib("ref/HereonMPLib.xlsx","HereonMPLib","/ref/MPStarter1_0.xlsx")

# import our LDIR data from the raw folder
df.LDIRData <- read_excel(LDIRFile, sheet = "Particles", .name_repair = "universal") 

# bin and classify data
df.Output <- classify_spectral_data(df.LDIRData, df.SpecLib, HitRate = 0.9)

# output to csv
write.csv(df.Output, OutputFile, row.names = FALSE)