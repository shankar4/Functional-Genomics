Chapter 1: "First Look at a Genome Sequence Statistics". Exercises here give accession numbers for accessing data at Genbank at 
https://www.ncbi.nlm.nih.gov/ . Entrez seems to be the programming interface. Here is the PDF for that: 
https://www.ncbi.nlm.nih.gov/books/NBK25501/ . First learning the tool. On May 1, 2018, NCBI will begin enforcing the use of new API keys for E-utility calls. Please see Chapter 2 for more details. Currently it uses SOAP for web service.

See http://www.vikram-baliga.com/blog/2016/1/23/using-r-to-download-genbank-sequences. The author discusses the use of "ape" package with simple intuitive commands for accessing  GenBank. Instead of building up strings for Entrez, I will use this package. Even BioStrings seems to have been superseded by ape. Also, the new DNABin format may be different. Still need to understand. 

Two other references for Biostrings: https://www.bioconductor.org/help/course-materials/2011/BioC2011/LabStuff/BiostringsBSgenomeOverview.pdf and https://kasperdanielhansen.github.io/genbioconductor/html/Biostrings.html
