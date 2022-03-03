## reclarify | automated categorisation and processing of LDIR particle data

Last updated: 03-MAR-2022

### Purpose
The purpose of this code is to automate the grouping of polymer analysis data from the Agilent Clarity software into polymer classes and then bin the resultant data by defined size groups to produce an overview of size and type.
The methodology is derived from the LDIR Polymer Analysis spreadsheet produced by [Ole Klein](https://www.hereon.de/institutes/coastal_environmental_chemistry/inorganic_environmental_chemistry/team/098593/index.php.de) at the Helmholtz-Zentrum Hereon

### Author
This code is written by [Joey O'Dell](https://github.com/joey4247) in R using publicly-available code snippets.

### Copyright
No rights are reserverd by the author and the code is in the public domain [Licence: CC0](https://creativecommons.org/share-your-work/public-domain/cc0/)

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

### Refreshing Spectral Libraries
The spectral libraries were exported last on 8th February 2022. Should there be substantial changes since then, you need to refresh the data held here.
Unfortuantely there is no automated method for pulling data from the Clarity spectral libraries, these need to be exported manually to a CSV.
You will need to:
*	Transform the data using t(x) in R to flip the data table
*	Character Â will be inserted next to Mu (µ) as part of the export process - you can simply remove any occurrence of Â (i.e. find 'Â' and replace with ''). Sometimes Mu will be removed entirely.
*	The LDIR exports the spectra type as well as name, e.g. 'X (Rel. Absorbance)'. Check what is exported in your library and remove this, but check that you have no removed any other punctuation as some spectra names contain such marks.
*	The code is written as such that if you add new spectra names, it will automatically include them, and will remove duplicates. Check manually that you have not given the same spectra two different classes in your spreadsheets.
*	Save them with the same name in the */ref* folder and the script will automatically evaluate them each time it runs. 
