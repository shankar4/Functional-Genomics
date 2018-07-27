#KEGGREST tutorial
# This is a repeat of a vignette at bioconductor.org
#Ref: https://bioconductor.org/packages/release/bioc/vignettes/KEGGREST/inst/doc/KEGGREST-vignette.html . 
setwd("/home/shankar/Genome/GenomicSystems")
library(KEGGREST)
listDatabases() # use these dbs for further exploration
# can use 3-letter KEGG organism code or a "T number" (Genome ID) in place of dbs
org <- keggList("organism")
head(org)
summary(org) # Org has 4 columns: T.number, organism, species, phylogeny
# org[1,] is for hsa (homosapiens)
# Get complete list of entities that can be queried with KEGGREST
queryables <- c(listDatabases(), org[,1], org[,2])
# Find hsa entries
hsa <- keggList("hsa") # 39453 characters. use head(hsa) to explore
names(hsa) # hsa:id list will be displayed, a total of 39543 entries (or 'characters')


# The first entry is hsa:414324 (Gene ID) - DEFB103A.
# used google to find UniProtKB page for P81534 - protein Beta-defensin 103
# antimicrobially active, highly expressed in skin and tonsils. 
# Apparently, there is another GeneID: 55894 (hsa:55894)
query <- keggGet(c("hsa:414325", "hsa:55894")) # Each has 10 sublists
names(query[[1]]) # A parsed KEGG flat (or text) file
more1 <- hsa[names(hsa)=="hsa:414325"]  # or hsa[[1]]
more2 <- hsa[names(hsa)=="hsa:55894"] # These are defensin beta 103A and 103B proteins
query[[1]]$STRUCTURE  #"PDB: 1KJ6"
query[[2]]$DBLINKS # lists 8 links to NCBI-GeneID, NCBI-ProteinID, Vega, UniProt etc
query[[2]]$AASEQ # Amino Acid Sequence
# width seq
#    67 MRIHYLLFALLFLFLVPVPGHGGIINTLQKYYCRVRGGRCAVLSCLPKEEQIGKCSTRGRKCCRRKK
# another way
keggGet("hsa:55894", "aaseq") # same result as above
dnaseq <- query[[2]]$NTSEQ # DNA Sequence  DNAStringSet from Biostrings package
library(Biostrings)# I think I need this only for string manipulation, not for just displaying???
alphabetFrequency(dnaseq, baseOnly=TRUE)
#       A  C  G  T other
# [1,] 53 43 54 54     0
complseq <- reverseComplement(dnaseq)
AAseq <- translate(dnaseq) # AA sringset
AAseq
# width seq
#    68 MRIHYLLFALLFLFLVPVPGHGGIINTLQKYYCRVRGGRCAVLSCLPKEEQIGKCSTRGRKCCRRKK*
# TAA is the stop codon, coded here with a *, not in the AASEQ given above. 
# hence the 67 vs 68 difference.
#codonseq <- codons(AAseq) - would not convert from AAStringSet and DNAStringSet
dnaseq1 <- dnaseq[[1]] # convert from DNAStringSet to DNAString
codonseq <- codons(dnaseq1) # It works since it is a DNAString, not DNAStringSet
# codons extracts the codons involved in the translation without translating them
# translate reproduces the biological process of RNA translation.

#Get an image
png <- keggGet("hsa:414325", "image") # this does not work, even with : replaced with a 0
# the images are not individual protein 3D shapes
# but pathway. In this case, it is the pathway of E Coli infection
# Ref: http://www.kegg.jp/kegg-bin/search_pathway_text?map=hsa&keyword=05130&mode=1&viewImage=true

png <- keggGet("hsa05130", "image") # this is the tutorial example 
t <- tempfile()
library(png)
writePNG(png, t)
if(interactive()) browseURL(t)
# The above gives a nice mapview - a pathway of E.Coli infection

# Search by Keywords with keggFind()

head(keggFind("genes", c("cholesterol"))) # Tried hypertension, aneurysm - no luck
# 6 entries were returned (hsa#s: 9023, 1583, 10858, 1717, 1718, 3931)
head(keggFind("genes", c("ECM")))
# 22915, 1842, 1893, 960, 23392, 79087
head(keggFind("genes", c("BP"))) # Looks like physiology, not pathology focus
# For the above 'blood pressure' did not work, only BP
# 414325, 80329, 1665, 1646, 29117, 1153










