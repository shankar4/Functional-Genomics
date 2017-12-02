# This is a tutorial from here:
# https://web.stanford.edu/class/bios221/labs/biostrings/lab_1_biostrings.html
setwd("/home/shankar/Genome/CompGenomics/ch1")
getwd()
library(Biostrings)
sample(LETTERS[c(1,3,7,20)], size = 10, replace=TRUE)
# or Use The following thanks to biostrings
seq <- sample(DNA_ALPHABET[1:4], size =10, replace = TRUE)
seq
# convert character list into a string
seq <- paste(seq, collapse = "")
seq
# Use XString to create different types of strings (B, DNA, RNA, and AA string)
bstring = BString("I am a BString object")
bstring
length(bstring)
dnastring = DNAString("TTGAAAA-CTC-N")
dnastring
# Looks like BString is generic and DNAString is specific
str(dnastring)
slotNames(dnastring)
alphabetFrequency(dnastring)
alphabetFrequency(dnastring, baseOnly = TRUE, as.prob = TRUE)
letterFrequency(dnastring, "A", as.prob = TRUE)
# dnastring$offset  -- does not work
slot(dnastring, "length")
reverseComplement(dnastring)
bstring[3]
dnastring[3:5]
# following is preferred
subseq(bstring, start=3, end=3)
# convert Xstring to a character vector
bChar <- toString(bstring)
bChar[3] # gives NA
length(bChar) # is 1
length(bstring) # is 21
# Comparing Xstrings
bb = subseq(bstring, 3, 6)
bb == BString("am a") # yields TRUE
# cannot compare different types of Xstrings
# Xstring view class - get multiple sequences
view = Views(dnastring, 3:0, 5:8)
view
length(view)
view[4:2]
view[[2]] # extracts that sequence, still a xstring object
view[-3] # to see all but the 3rd
#Xstring set to store several xstring objects together
set = NULL
for (i in 1:4) {
  set = c(set, paste(sample(DNA_ALPHABET[1:4], 10, replace=T), collapse=""))
}
set
length(set)
# Convert to DNAString to use functions
set = DNAStringSet(set)
set
# functions work on each of the Xstrings
reverseComplement(set)
# other functions: alphabetFrequency, width, subseq
# name each XString in the set
names(set) = paste("name", 1:4, sep = "")
names(set)
install.packages("RCurl")
#Exercise
library(RCurl)
library(XML)
# Look the Escherichia coli APEC 01 genome (NC008563). Found in the BSgenome package
# download and install the package data
source("https://bioconductor.org/biocLite.R")
biocLite("BSgenome")
# the above did not work. I needed to go back, invoke R and go through the steps. 
# The reason was complicated. See Github site for documentation. The above steps will ordinarily work
library(BSgenome)

# now repeat for Ecoli
source("https://bioconductor.org/biocLite.R")
biocLite("BSgenome.Ecoli.NCBI.20080805")
require("BSgenome.Ecoli.NCBI.20080805")
eco = Ecoli$NC_008563
summary(eco) # 5082025 long DNAString

# Sample the genome 1000 random views with 50-100 random widths
views1000 = Views(eco, start= sample(length(eco), 1000, replace=T), width = sample(50:100, 1000,
      replace=T))
views100 = Views(eco, start= sample(length(eco), 100, replace=T), width = sample(50:100, 1000,
      replace=T))
alphabetFrequency(views1000, baseOnly=T, as.prob = T, collapse = T)
alphabetFrequency(views1000, baseOnly=T, as.prob = T) # collapse summarizes
# without collapse, it printed 200 and omitted 800 more rows
alphabetFrequency(views100, baseOnly=T, as.prob = T, collapse = T)
alphabetFrequency(eco, baseOnly=T, as.prob = T)
# alphabetFrequency(eco, baseOnly=T, as.prob = T, collapse = T) #- this gives an error msg
# collapse is for views only
# use IRanges to look for subsequences, given a starting point. 
ir1 = IRanges(start=1:10, width=10:1)
str(ir1)
start(ir1)
end(ir1)
width(ir1)
#plot 
library(ggplot2) # install if error message (since it is missing)
plotRanges = function(x, xlim=x, main=deparse(substitute(x)), sep=0.5){
  height = 1
  if (is(xlim, "Ranges"))
    xlim = c(min(start(xlim))-sep, max(end(xlim))+sep)
  bins = disjointBins(IRanges(start(x), end(x)+1))  
  
  plot.new()
  plot.window(xlim, c(0, max(bins) * (height + sep)))
  ybottom = bins * (sep + height) - height
  rect(start(x) - 0.5, ybottom, end(x) + 0.5, ybottom + height, col = "blue")
  title(main)
  axis(1)
}
plotRanges(ir1)

#This uses ggplot to plot
plotRanges = function(x, xlim=x, main=deparse(substitute(x)), sep=0.5){
  height = 1
  if (is(xlim, "Ranges"))
    xlim = c(min(start(xlim))-sep, max(end(xlim))+sep)
  bins = disjointBins(IRanges(start(x), end(x)+1))  
  
  ybottom = bins*(sep+height) - height
  df = data.frame(ybottom = ybottom, xleft = start(x) -.5, 
                  xright = end(x) + .5, ytop = ybottom + height)
  ggplot(df) + geom_rect(aes(xmax = xright, xmin = xleft, ymax = ytop, ymin = ybottom)) + 
    labs(title = main)
}
# use reduce to get ranges that do not overlap
plotRanges(reduce(ir1))
# Not clear what is the significance at present of this non-overlapping notion. May be to id unique sequences
# per tutorial: the result is a NormalRanges object. 

#CpG islands in real data
# GC content gives GC content as a percentage of the gtenome. Using human Chr8 data. 
# A genomic window is defined as a CpG island if its GC content >50% and observed-to-expected CG ration >0.6.
# Important biomarker - since >65% of gene promoter regions are in CpG islands

source("http://bioconductor.org/biocLite.R")
biocLite("BSgenome.Hsapiens.UCSC.hg19")
require(BSgenome.Hsapiens.UCSC.hg19)
seqChr8 = unmasked(Hsapiens$chr8)
# Now, download the locations of CpG islands from this site: 
# http://web.stanford.edu/class/bios221/data/model-based-cpg-islands-hg19.txt
# I used mozila firefox's saveas opton
cpglocs=read.table("model-based-cpg-islands-hg19.txt",header=T)
# The above gave an error msg that there were more columns than column names.
# I manually went in and removed the header info - on stanford website link address and # of minutes (?)
# Trying again - only column names and column data exist now
cpglocs=read.table("model-based-cpg-islands-hg19.txt",header=T)
# this was the error message: line 65701 did not have 8 elements
# may be end of file notation there. Will remove it now. Yes, there was some characters there.
# next time download directly into Rstudio. Will try that soon after
#Trying again.
cpglocs=read.table("model-based-cpg-islands-hg19.txt",header=T) # Went through this time.
# Going to try to download directly now
url <- "http://web.stanford.edu/class/bios221/data/model-based-cpg-islands-hg19.txt"
download.file(url, "hg19.txt" )
cpglocations=read.table("hg19.txt",header=T) # worked - no problems
summary(cpglocs)
summary(cpglocations) # confirmed both are the same file
cpglocs8 = cpglocs[which(cpglocs[,1] == "chr8"), 2:3] # keep only chromosome 8 CpGs
dim(cpglocs8)
head(cpglocs8)
tail(cpglocs8)
# Form a new matrix that identifies non CpG islands with cpglocs8 start and end base markers
nonilocs8=matrix(0,ncol=2,nrow=2856)
nonilocs8[1,1]=10000
nonilocs8[1,2]=cpglocs8[1,1]-1
nonilocs8[2:2856,1]=cpglocs8[1:2855,2]+1
nonilocs8[2:2855,2]=cpglocs8[2:2855,1]-1
nonilocs8[2856,2]=146304021
# Note the last hardcoded value. It is to the right of the end point of 59815, the last entry.
# I used the following to understand better what is in seqChr8
length(seqChr8) # gives 146364022, one above the # given above
head(seqChr8)
summary(seqChr8)
tail(seqChr8)
class(seqChr8)
view = Views(seqChr8[146364021:146364022])
view # prints out: 'Views on a 2-letter DNAString subject' - so, there is a letter at that '..22' location
view[1] # dud not work
summary(seqChr8)
alphabetFrequency(seqChr8, baseOnly=FALSE) # There are 42.76M As etc. 3.47M Ns. which is what I encountered at the end points
# with the view command above. It printed out the character as N (I think it stands for ANY)
# sublist <- seqChr8[seqChr8 == DNAString("A")]  - does not work.
# summary(sublist)
seqChr8[1000]  # Gives N
seqChr8[1000000] # Gives G
# Tried translate and codon commands
# codons(strChr8) gives error messages: Some tribases contain non-base letters; the length is not a multiple of 3
# tried a subset
codons(seqChr8[1000000:1000098]) # Gives 33 base sets
translate(seqChr8[1000000:1000098])  # Gives this AA sequence: AHAYVHTCGYVYTHAVTHMYIRVHTCTGSHTHT

# I will explore some memory and performance issues before I get back to the tutorial

memory.size() # apparently it is Windows-specific
gc() # garbage collection also gives info on memory usage
# it gave info as #0.43 GB between Ncells and VCells. OK for now, 
# But will remove the original chromosome file when no longer needed

# Back to the Stanford U tutorial
# Create DNAStringSets that contain the islands and non-islands
seqChr8Islands = DNAStringSet(seqChr8, start=cpglocs8[,1], end=cpglocs8[,2])
seqChr8NonIslands = DNAStringSet(seqChr8, start=nonilocs8[,1], end=nonilocs8[,2])

# Visualize the CG frequencies in both

freqIslands = vcountPattern("CG", seqChr8Islands) / width(seqChr8Islands)
freqNonIslands = vcountPattern("CG", seqChr8NonIslands) / width(seqChr8NonIslands)
freqCombined = rbind(data.frame(freq = freqIslands, type = "islands"), 
                     data.frame(freq = freqNonIslands, type = "non-islands"))
b <- seq(0, 0.25, length = 50)
hist(freqNonIslands, col = rgb(0, 0, 1, 0.5), xlim = c(0, 0.25), breaks = b, 
     main = "Frequencies of CG Digrams")
hist(freqIslands, col = rgb(1, 0, 0, 0.5), add = T, breaks = b)
legend("topright", c("in NonIsland regions", "in Island regions"), fill = c(rgb(0, 0, 1, 0.5), rgb(1, 0, 0, 0.5)))
# width() shows that the nonislands are typically much wider. So, the plot is a bit ambiguous
# CpG island, by definition, occurs at or near a transcription start site of a gene
# use ggplot
ggplot(freqCombined) + 
  geom_histogram(aes(fill = type, x = freq), alpha = .7, position = "identity", 
                 binwidth = .005) + 
  labs(title = "Frequency of CG digrams")
# ggplot plot similar
# Now on to GC content of Staph
# First some housekeeping - I will remove the large files. 
rm(seqChr8, seqChr8Islands, seqChr8NonIslands, eco)
gc() # No change in the memory footprint.
# Another call to gc() after a few minutes showed reduction to 0.3 GB.

# Tutorial continued here
url <- "https://web.stanford.edu/class/bios221/data/staphsequence.ffn.txt"
download.file(url, "staph.txt" )
  
staph = readDNAStringSet("staph.txt", "fasta")
staph[1:3]
letterFrequency(staph[[1]], letters="ACGT", OR=0) # Gives ACGT content in the first string
letterFrequency(staph[[10]], letters="ACGT", OR=0) # checked that it is different Vs 1
# average GC content in a window of 100 bases
GCstaph = data.frame(ID=names(staph), GC=rowSums(alphabetFrequency(staph)[, c(2,3)]/width(staph))*100)

window = 100
# compute the GC content in a sliding window (as a fraction) for a sequence no. 364
gc = rowSums(letterFrequencyInSlidingView(staph[[364]], window, c("G", "C")))/window
plot(gc, type = 'l')

# smooth
plot(1:length(gc), gc)
lines(lowess(x = 1:length(gc), y= gc, f = 0.10), col = 12, lwd = 2)
# end of the tutorial


