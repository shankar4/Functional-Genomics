setwd("/home/shankar/Genome/Biostar/lec03/SGD")
SGDChar = read.table("SGD_features.tab", header = F, sep = "\t", quote = "", fill=T, stringsAsFactors = FALSE)
SGDFact = read.table("SGD_features.tab", header = F, sep = "\t", fill=T, quote = "")
colnames(SGDChar)= c("Primary SGDID", "Feature Type", "Feature Qualifier", "Feature Name", "Std Gene Name",
                 "Alias", "Parent Feature Name", "Secondary SGDID", "Chromosome", "Start Coord", "Stop Coord",
                 "Strand", "Genetic Position", "Coord Version", "Seq Version", "Description")
colnames(SGDFact)= c("Primary SGDID", "Feature Type", "Feature Qualifier", "Feature Name", "Std Gene Name",
                 "Alias", "Parent Feature Name", "Secondary SGDID", "Chromosome", "Start Coord", "Stop Coord",
                 "Strand", "Genetic Position", "Coord Version", "Seq Version", "Description")
dim(SGDChar)
dim(SGDFact)
SGDChar = data.frame(SGDChar) # All non-numeric columns are characters
SGDFact = data.frame(SGDFact) # All non-numeric columns are factors
# summary of SGDChar, with stringsAsFactors = False
summary(SGDChar)
# summary of SGDFact, with all charracter strings as factors
summary(SGDFact)

lapply(SGDChar, class) # Get classes of the columns.  
# Target a subset of columns to be factors
SGDNew  <- SGDChar
factorlist = c("Feature.Type", "Feature.Name", "Std.Gene.Name", "Parent.Feature.Name" , "Chromosome", "Strand")
for (i in factorlist) {
  SGDNew[, i] = as.factor(SGDNew[, i])
}

lapply(SGDNew,class) # list classes
numlist = c("Start.Coord", "Stop.Coord")
for (i in numlist) {
  SGDNew[, i] = as.integer(SGDNew[, i])
}

lapply(SGDNew,class)
summary(SGDNew)


NAinStart <- SGDNew[is.na(SGDNew$Start.Coord),]
NAinStop <- SGDNew[is.na(SGDNew$Stop.Coord),]
head(rownames(NAinStart)) # list the rownames that have NA for Start Coord
head(rownames(NAinStop))
summary(NAinStart)
summary(NAinStop)

#The above gave the list that includes "2104"  "8708"  "13538" "16390" "16391" "16392"
# Verified that the start and stop coord at 2104 indeed has NAs.

SGDChar[2104, c("Start.Coord", "Stop.Coord")]
SGDFact[2104, c("Start.Coord", "Stop.Coord")]
SGDNew[2104, c("Start.Coord", "Stop.Coord")]

# How many lines match the pattern gene?
#genePattern <- for (i in 1:3) {
#pattern <- grep ("G45", myData[,i])}
#grep("gene", SGDChar, value=FALSE)


# install stringr package
library(stringr)
# see stat545.com/block022_regular_expression.html

pattern <- logical(nrow(SGDChar))
for (i in 1: ncol(SGDChar)){
  pattern <- ((pattern) | (str_detect(SGDChar[,i], "gene")))}
summary(pattern)

# How many lines match the pattern ORF?

ORFcount <- logical(nrow(SGDChar))
for (i in 1: ncol(SGDChar)){
  ORFcount <- ((ORFcount) | (str_detect(SGDChar[,i], "ORF")))
}
summary(ORFcount)

# How many lines match the patrern ORF in the second column?

ORFColumn2 <- str_detect(SGDChar[,2], "ORF")
summary(ORFColumn2)
# or this way to count
sum(ORFColumn2)

#5. Which word of the second column appears 50 times?
# I will use SGDFact for this
summary(SGDFact$Feature.Type)
FeatureTypeCount <- summary(SGDFact$Feature.Type)
sorted <- sort(FeatureTypeCount, decreasing = TRUE)
which.max(sorted)
head(sorted)
which(sorted == 50)

#6 The word Z3_region appears how many times in the second column?
factor(sorted)
sorted["CDS"]
sorted["Z3_region"]

#7 How many features are located in the forward strand?
colnames(SGDFact)
summary(SGDFact$Strand)
# W or Watson is forward
StrandCount <- summary(SGDFact$Strand)
StrandCount["W"]

#8 How many features have no strand information listed?
factor(StrandCount)
StrandCount[1]
labels(StrandCount)
StrandCount[labels(StrandCount) == ""]

#9 gthe standard gene name column listgs each gene name only once
colnames(SGDFact)
GeneNameCount <- summary(SGDFact$Std.Gene.Name)
labels(GeneNameCount)
# Defaul summary will only have 100 entries, with the 100th having "other" as a category
# Increased it to the max length with maxsum parameter
summary(GeneNameCount)
length(GeneNameCount)
GeneNameCount[100]

# Increased it to the max length with maxsum parameter
GeneNameCount <- summary(SGDFact$Std.Gene.Name, maxsum=length(SGDFact$Std.Gene.Name))
labels(GeneNameCount)
summary(GeneNameCount)
length(GeneNameCount)
GeneNameCount[100]
GeneSorted <- sort(GeneNameCount, decreasing = TRUE)
which(GeneSorted > 1)
head(GeneSorted)

#10 More rows have feature types than feature names:
# This is tricky - since some of the types rows have comments, not type labels
# need to subset to only those with one word entries - did not do it
# Reason: There were some comments that were only one word long, achieved with '_' in-between
# Need more complicated reasoning to ferret them out. 

summary(SGDNew$Feature.Type)
summary(SGDNew$Feature.Name)
TypeLogical <-  SGDNew$Feature.Type != ""
sum(TypeLogical)
NameLogical <- SGDNew$Feature.Name != ""
sum(NameLogical)

