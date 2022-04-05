## reclarify | automated categorisation and processing of LDIR particle data

Last updated: 03-MAR-2022

### Purpose
The purpose of this code is to automate the grouping of polymer analysis data from the Agilent Clarity software into polymer classes and then bin the resultant data by defined size groups to produce an overview of size and type.
The methodology is derived from the LDIR Polymer Analysis spreadsheet produced by [Ole Klein](https://www.hereon.de/institutes/coastal_environmental_chemistry/inorganic_environmental_chemistry/team/098593/index.php.de) at the Helmholtz-Zentrum Hereon

### Author
This code is written by [Joey O'Dell](https://github.com/joey4247) in R using publicly-available code snippets.

### Copyright
No rights are reserverd by the author and the code is in the public domain [Licence: GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)

### How-To
0.	(First time only)  Check in the text for the letter *Â* which sometimes crops up randomly, if this appears in your script you can remove it.
	Check that you have the following libraries installed in your environment:
	
	`install.packages("tidyverse")`
	`install.packages("readxl")`
	`install.packages("pivottabler")`
	`install.packages("dplyr")`
	`install.packages("openxlsx")`
 
1.	Store the output from the LDIR as an XLSX in folder `/raw` with the file name being sample ID (ex: S_01_02.xlsx). Do not change the worksheet names.
2.	Check the spectral libraries at `/ref` and either add new spectra, or see comment below on refreshing libraries
3.	From around line 12 onwards you will find the variables, following the comments enter your sample ID, weight, and percent analysed.
4.	Line 16 and 17 control the size classification for your output, if you wish to amend this ensure to follow the binning label format of (x,y] and note that they are coterminous groups
5.	Run the code! The pivot table evaluation can take a few moments, don't worry. Your output will be deposited at `/output/<SampleID>.xlsx`
