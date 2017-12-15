setwd("/home/shankar/Genome/CompGenomics/Ch1")
getwd()
# Exercise 1 of Chapter1  of Cristianini book
# Download from GenBank the complete genomic sequence of Bacteriophase lambda, accession number NC_001416 and analyze its
# GC content with various sizes of window size
# using "ape"
library("ape")
acc.nb <- "NC_001416"
phage <- read.GenBank(acc.nb)
summary(phage) # length: 48502
class(phage) #DNAbin
str(phage)

library(Biostrings)
library(ggplot2)

# The following two lines from V. Baliga for his more complex example. 
# URL: http://www.vikram-baliga.com/blog/2016/1/23/using-r-to-download-genbank-sequences
# the DNAbin has four subfields. Exploring
name <- data.frame(species=attr(phage, "species"), accs=names(phage))
names(phage) <- attr(phage, "species")
names(phage)
species(phage) # this does not work; but the above two lines do
help(DNAbin) # it is a binary format, a bit level coding scheme
description <- attr(phage, "description")
description
phage # Gives base composition
print(phage, 15, 6)  # 6 decimal points, spread out
print(head(phage), 15, 6)


# Convert to df
data <- data.frame(as.character(phage[names(phage)])) # has 48502 DNA characters
summary(data) # Gives actg composition
data[1:20,] # first 20 characters
print(data[1:5,], 15, 6) # 

# Convert to FastA
write.dna(phage, "phage.fasta", format="fasta")
# read back 
phage.fa <- read.dna("phage.fasta", format = "fasta")
summary(phage.fa) # gives a long printout - they are stored as 1 character vectors
phage.fa[48501] # they are designated as V48501 etc, with V for vector lavbel. Drop the label in accessing
phage.fa[1, 90:100]# gices a summary for 11 characters

# convet to characters from phage DNAbin format
phage_char <- as.character(phage) # takes time to convert vs data.frame operation above, perhaps the read operation
summary(phage_char) # 48502 characters
names(phage_char) # gives name of the list
phage_char[[1]][100] # gives one character, C

# will use Biostring
# Ref: Biostrings: List with DNASrring does not unlist
pch <- unlist(phage_char)
pch[[1]] # gives the first letter
dna <- DNAStringSet(pch) # efficient way to move unlisted charactger seq to DNAString of biostring
dna_st <- unlist(dna) #DNA string sequence
view = Views(dna_st, start=3:0, end= 5:8) # exploring with help from Stanford U's Biostring tutorial
view # Gives 4 strings of widths 3,5,7,9.
alphabetFrequency(dna_st, baseOnly=T, as.prob = T) # yields ACGT probabilities
# sample the genome by generating 1000 random views of random widths (50-100)
views1000 = Views(dna_st, start = sample(length(dna_st),1000, replace=T), width = sample(50:100, 1000, replace=T))
alphabetFrequency(views1000, baseOnly=T, as.prob = T, collapse=T) 
# Result:  A         C         G         T     other 
#        0.2537393 0.2328820 0.2649373 0.2484414 0.0000000 
matchPattern("GC", dna_st) # returns view objects - 3615 views
countPattern("GC", dna_st) # returns the count of 3615
vmatchPattern("GC", views1000)# not supported yet
mp <- matchPattern("GC", dna_st)
mp[1] # gives start and end of 2, 4 for GC
length(mp) # 3615
GCcontent <- countPattern("GC", dna_st)/(length(dna_st)-1) # one less as we are dealing with pairs
# gives 0.0745
lf <- letterFrequencyInSlidingView(dna_st, view.width = 50, letters = "GC", as.prob = T)
plot(lf) # there is a sswitch to a lower GC content around an index of 23,000 (position also same, since
# shift by default is 0). Ending content is the same as the start. Does it mean it is circular?
length(views1000)
subject(views1000) #48502 characters
subject(views1000)[1] # 1st letter, G
start(views1000[1])# start loc of 1st object, 35185
start(views1000)[1] # same as above
start(views1000)[1:10]# 10 of these
width(views1000)[1:10]# 10 of these
width(views1000[1:10])3 #10 widths
subject(views1000[1:10]) # 10 is ignored
names(views1000) # Null
end(views1000)[51] # this is 48531 and 'out of bounds' - see below. 

# The following code works fine for a limited range, A bit later, it has been generalized
st <- DNAString(); cnt <- numeric()
for (i in 52: 60){
  st <- views1000[[i]]
  GCCont[i] <- countPattern("GC", st) / length(st)
}
# at present, the above loop works fine, but for object 51. Reason: it is 'out of limits.' 
# I found that at position 48531 there is a '[' symbol. Not an allowed symbol.
# apparently it is embedded to imply 'out of limits' - that is, it can start before the
# first letter of the subject and/or end after its last letter. Also, the actual length of
# phage is 48502. This is confirmed with 'dna' df.
# I checked 51 with views1000[51]. Result is given below:
# start   end width
# [1] 48458 48531    74 [TCATTATCACTTTACGGGTCCTTTCCGGTGATCCGACAGGTTACG  
# It starts within limits, but goes beyond the upper limit.
# so, need a way to remove such views and then continue
st <- DNAString(); cnt <- numeric()
for (i in 1: length(views1000)){ if (end(views1000[i]) < length(dna_st)){
    st <- views1000[[i]]
    GCCont[i] <- countPattern("GC", st) / length(st)
  }
}
# A minor mistake - the if should have checked against length +1, not length.
length (GCCont)
summary(GCCont)
# results:
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.00000 0.05000 0.07246 0.07464 0.09627 0.20339       5 
# there were 5 NAs
# missing <- GCCont[is.na(GCCont)]

missing <- which(is.na(GCCont))
missing # yields 51 122 331 805 913
# Now back to analyzing GC Content
GCcount <- GCCont[-missing]

ln <- length(views1000); 
stCnt <- numeric()
for (i in 1:ln) {
  if (!(i %in%  missing)) {
    obj <- start(views1000[i])
    stCnt[i] <- obj
    #print(i)
  }
}
summary(stCnt) # gives 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#  5   12240   24963   24705   36368   48413       5 
head(stCnt); stCnt[1:10]
stCnt <- stCnt[-missing]
plot(stCnt, GCcount)
dt <- lm(GCcount ~ stCnt)
dt
abline(dt) # The line shows that higher the stCnt, the lower is the GCcount

## An example from the reference manual for ape
data("woodmouse")
woodmouse
x <- as.character(woodmouse)
x[, 1:20]
dim(x)  # 15 x 965

# The woodmouse data is from the abe package

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
