setwd("/home/shankar/Genome/CompGenomics/Ch1")
getwd()
# Exercise 1 of Chapter1  of Cristianini book
# Download from GenBank the complete genomic sequence of Bacteriophase lambda, accession number NC_001416 and analyze its
# GC content with various sizes of window size
# use "ape"
library("ape")
acc.nb <- "NC_001416"
phage <- read.GenBank(acc.nb)
summary(phase) # length: 48502
class(phage)
str(phage)

# The following two lines not needed for this example - But was needed by V. Baliga for his
# more complex example. URL: http://www.vikram-baliga.com/blog/2016/1/23/using-r-to-download-genbank-sequences
name <- data.frame(species=attr(phage, "species"), accs=names(phage))
names(phage) <- attr(phage, "species")

# Convert to FastA
write.dna(phage, "phage.fasta", format="fasta")
attr(phage)
library(Biostrings)
library(ggplot2)
# Exploring

names(phage)
summary(phage)
help(DNAbin) # it is a binary format, a bit level coding scheme
phage
print(phage, 15, 6)  # 6 decimal points, spread out
print(head(phage), 15, 6)
print(phage[1:5,], 15, 6) # Error message. 
phage.fa <- read.dna("phage.fasta", format = "fasta")
summary(phage.fa) # gives a long printout
phage.fa[1, 90:100]# gices a summary for 11 characters
phage_char <- as.character(phage)
summary(phage_char) # 48502 characters
phage_char[1:20] #Prints out all of the data - not sure why. X below is well restricted
# will now use BioStrings package

# Will read phage without defaults - the two DNABin data of phage and woodhouse are different
phage1 <- read.GenBank(acc.nb, seq.names = acc.nb, species.names = TRUE, as.character = FALSE)
phage1_char <- as.character(phage1)
phage1_char[1:20]
length(phage1_char)
phage_seq <- sapply(phage1_char, paste, collapse="") # has all the DNA characters in one place
# can't convert directly from DNABin to seq - that will give decimal #s.
alphabetFrequency(phage_seq)# gives error message. Makes sense.
alphabetFrequency(phage.fa) # this is seen as DNA Bin
base.freq(phage)# works 
# Looks like I do not need BioSrings at all. ape will do all the operations with DNABin, hopefully more efficiently
GC.content(phage) # Gives as 0.4985774
# figure out how to put windows






data("woodmouse")
woodmouse
x <- as.character(woodmouse)
x[, 1:20]
dim(x)  # 15 x 965

# in the steps below, not all are working for my phage data
# The woodmouse data is taken from somewhere else
# I think my phage1 is raw DNAbin like the woodmouse data - this is not true.
print(woodmouse$No305, 15, 6)
Labels(woodhouse)
namaes(woodmouse)
summary(woodmouse)
woodmousedf <- as.data.frame(woodmouse)
class(woodmouse)
x <- woodmouse[1:2, 1:5]
x
print(x[1], 15, 6)
print(x, 15, 6)
x <- as.character(x[1])
x
x <- woodmouse[1:2, 1:5]
x
x[1]
write.dna(x, "x.fasta", format="fasta")
write.dna(woodmouse, "woodmouse.fasta", format="fasta")
woodmouse_fasta <- read.dna("woodmouse.fasta", format = "sequential")
woodmouse_fasta <- read.dna("woodmouse.fasta", format = "fasta")
woodmouse[1:2,]
woodmouse_fasta[1:2,]
write_dna(woodmouse, "woodmouse.txt", format="sequential")
write.dna(woodmouse, "woodmouse.txt", format="sequential")
woodmouse_seq <- read.dna("woodmouse.txt", format = "sequential")
woodmouse_seq[1:2,]
str(woodmouse_seq[1])
woodmouse_seq
wm1 <- as.character(woodmouse_seq[[1]])
wm1
woodmouse_seq[[1]]
