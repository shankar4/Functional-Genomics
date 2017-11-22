# chapter 2 example of C. Gondro's book.
# On Microsatellites. Given simulated datasets as .txt
# Five regions were identified by researchers as QTL
# QTL - Quantitative Trait Locus - a genomic region
# that explains phenotypic differences due to genetic 
# polymorphisms in cattle weight. 
# case-control study - 10 heterozygous sires, each sire
# had 40 offsprings - both F and M.  All sires and offsprings
# genotyped for the five markers and phenotypic measures
# the female parents were neight genotyped or measured.

# Check everything looks fine
# First three lines are 'noise'
getwd()
dir()
sires = read.table("BookCode/chapter2/siredata.txt", header = T, sep = "\t", skip=3)
dim (sires)
prog = read.table("BookCode/chapter2/progdata.txt", header = T, sep = "\t", skip=3)
dim (prog)
print(sires)
head(prog)
summary(sires)
summary(prog)
# m11 is marker 1 and allele 1
# weight of prog is a factor. convert to numeric
prog$weight = as.numeric(as.character(prog$weight))
summary(prog)
#remove NA
prog[is.na(prog$weight),]

prog = prog[!is.na(prog$weight),]
summary(prog$weight)
summary(sires$weight)
plot(prog$weight, main="Weight by animal ID", xlab="Animal ID", ylab = "weight", col = "blue")
# remove the outlier with weight of 480
prog = prog[-which(prog$weight > 400),]
summary(prog$weight)
# use grep to identify missing marker data - names refers to header names. Remove them
index = grep("m", names(prog))
print (index)
missing = numeric()
for (i in 1: length(index)) {
  missing = c(missing, which(prog[, index[i]] == "-"))
}
print(missing)
missingU = unique(missing)
print (missingU)
prog = prog[-missingU,]
summary(prog$m11)
# Note that '-' is still there as a factor level
# remove with this for loop
for (i in 1:length(index)) {
  prog[, index[i]] = factor(prog[, index[i]])
}
summary(prog$m11)
# Find reason for two distinct subplots
# plot weights by sire and sex
boxplot(prog$weight ~ prog$sire, col = 1:length(levels(prog$sire)), main = "Boxplot of weights by sire")
boxplot(prog$weight ~ prog$sex, col = 1:length(levels(prog$sire)), main = "Boxplot of weights by sire")
# there is a clear separation by sex
# note the bimodal nature of the weight, due to gender difference
plot (prog$weight, col = prog$sex, pch=as.numeric(prog$sex), main = "XY plot weight vs animal", 
      xlab = "animal", ylab = "weight")
legend("topleft", levels(prog$sex), col = 1:2, pch=1:2)

# Check for genotype errors
# trying to understand the data. Pick one Sire (say 7) and list alleles for the Sire and offsprings
# These are my steps to understand the nested for loops that the author has
sire7 <- sires[(sires$id == "sire7"),]
print (sire7)
summary(sire7)
indexms = grep("m", names(sires))
print(indexms)
print(sire7[indexms])
#find top alleles
countM1 <- logical()
for (i in indexms[1]: indexms[length(indexms)]) {
countM1 <- c(countM1, sire7[i] == "M1")
}
sum(countM1)

# drop id and weight, the extra columns of prog Not a good idea, but doing it for 
# finding the alllele counts and verifying that there are no discrepancies
# Will try this later on. 

# For now, following the book again here
indexms = grep ("m", names(sires))
#create a 2 column matrix - there are two alleles for each of the markers
indexms = matrix(indexms, nrow=length(indexms)/2, ncol = 2, byrow=T)
print(indexms)

# similarly for prog
# Change with respect to author's code: used indexmp vs indexm, just to be consistent
indexmp = grep("m", names(prog))
indexmp = matrix(indexmp, nrow=length(indexmp)/2, ncol = 2, byrow=T)
print(indexmp)
# The above splits by each marker position. So, now, we know what is the positon entry
# for eaach of the 5 positions

# It is the same m set, but the prog file has sex and id added - so columns are displaced by 2
library(made4)
compatible = matrix(NA, length(sires$id), length(indexms[,1])) #10 x 5 matrix
# To understand this and also to code it right, I executed each of the statements one
# at a time while entering each line. This also helped understand better
# used the print statement to see the final one for id =10 for various one and two loop
# executions. Also, commented out working lines of code to understand the hold part

# Ensure that the most common alleles in offsprings (prog data)
# match with the sire alleles
for (j in 1:length(indexms[,1])){
  for (i in 1:length(sires$id)) {
    indexs = which(prog$sire == sires$id[i])
    #indexs is a subset specific to one sire id - 37 to 40 entries
    # list alleles of offspringfs for each sire, factor and sum them across factors
    # Take the top two
    sirealleles = sires[i, indexms[j,]]
    sirealleles = c(as.character(sirealleles[,1]), as.character(sirealleles[,2]))
    
    hold = prog[indexs, indexmp[j,]] # hold a ~40 x 2 matrix for each sire id
    hold = factor(c(as.character(hold[,1]), as.character(hold[,2]))) # collapse into one D array
    holdsorted = sort(summary(hold), decreasing = T)  
    # sort changes summary(hold) as hold has changed
    # So, added holdsorted. Try summary(hold) and sumary(holdsorted) to see the difference
    topalleles = names(holdsorted) [1:2]
    #check for compatibility of offspring top markers vs sire's markers for alleles
    compatible[i,j] = length(comparelists(sirealleles, topalleles) $Set.Dif)
    # skipped the steps for printing results out for one iteration
  }
}

print(compatible)
# the matrix has zeros - so, no inconsistency between sire and offspring genotypes. 
# Now, the flip question: Are there any offspring that might be incorrectly genotyped?
# For this, compare the alleles of each offspring with those of the sires - at least one allele
# must  be the same. There could  be mutation, but more likely a genotyping error
# Code is similar, but now focused on the 397 rows of prog.
compatible = matrix(NA, length(prog$id), length(indexms[,1])) #397 x 5 matrix
# To understand this and also to code it right, I executed each of the statements one
# at a time while entering each line. This also helped understand better
# used the print statement to see the final one for id =10 for various one and two loop
# executions. Also, commented out working lines of code to understand the hold part
for (j in 1:length(indexms[,1])){
  for (i in 1:length(sires$id)) {
    indexs = which(prog$sire == sires$id[i])
    #indexs is a subset specific to one sire id - 37 to 40 entries
    sirealleles = sires[i, indexms[j,]]
    sirealleles = c(as.character(sirealleles[,1]), as.character(sirealleles[,2]))
    for (k in 1: length(indexs)) {
    # I was able to run a single loop by setting i, j, and K in the console and running the 
    # relevant lines without commenting out other lines. 
    hold = prog[indexs[k], indexmp[j,]] # hold a ~40 x 2 matrix for each sire id
    progalleles = (c(as.character(hold[,1]), as.character(hold[,2]))) # collapse into one D array
    #holdsorted = sort(summary(hold), decreasing = T) # sort changes summary(hold) as hold has changed
    # So, added holdsorted. Try summary(hold) and sumary(holdsorted) to see the difference
     
    #check for compatibility of offspring top markers vs sire's markers for alleles
    compatible[indexs[k],j] = length(comparelists(sirealleles, progalleles) $intersect)
    # if you chose i, j, k = 1, you chose the one that was a mismatch! You get a zero
    # skipped the steps for printing results out for one iteration
    }
  }
}

print(compatible) # should give 1 or 2. A 0 is bad. 
summary (compatible) # this will not give meaningful results. so, factor
compatible = data.frame(compatible)
for (i in 1: length(compatible[1,])) {
  compatible[,i] = factor(as.character(compatible[,i]))
}
cat ("\n Summary of alleles in common between sires and offspring \n")
summary(compatible)
# one prog animal has no corresponding alleles of its sire in marker position 1
# remove the animal from the list, though there are matches for other marker positions.
index = which(compatible[, ] == 0)
print(index)
print(prog[index,])
prog = prog[-index,]
dim(prog)

# plot freq plot for genotypes and alleles
# summarize the count data for alleles
# First work through for marker 1 only
alleles = summary(factor(c(as.character(prog$m11), as.character(prog$m12))))
print(alleles)

alleles = alleles/sum(alleles)
print(alleles)

# now for genotyrpes
hold = data.frame(m11 = as.character(prog$m11), m12 = as.character(prog$m12))
hold[,1]= as.character(hold[,1])
hold[,2]= as.character(hold[,2])
sorted = character()
# the following for loop switches columns 1 and 2 so that AB is the same as BA
for (i in 1:length(hold[,1])){
  sorted = rbind(sorted, sort(as.character(hold[i,])))
}
genotypes = paste(as.character(sorted[,1]), as.character(sorted[,2]), sep="_")
genotypes = summary(factor(genotypes))
print(genotypes)

genotypes = genotypes/sum(genotypes)
print(genotypes)

# split.screen and screen helps place more than one image in a single plot area
split.screen(c(2,1))
screen(1)
barplot(sort(alleles, decreasing = T), col=1:11, main = "Barplot of allele frequencies")
screen(2)
barplot(sort(genotypes, decreasing=T), col=1:11, main = "Barplot of genotype frequencies")
close.screen(all=T)
dev.print(file="images/animalgenotype.pdf", device = pdf, width = 8, height = 8)

# make a new dataframe with a single column for each marker position, with one column instead
# of two in prog. new column name = 'markers'
allgeno = NULL
for (i in 1: length(indexmp[,1])) {
  hold = data.frame(prog[indexmp[i,]])
  hold[,1]= as.character(hold[,1])
  hold[,2]= as.character(hold[,2])
  sorted = character()
  for (i in 1:length(hold[,1])) {
    sorted = rbind(sorted,sort(as.character(hold[i,])))
  }
  # indices are now 1 to 396, instead of up to 400, with some, such as 1, missing.
  genotypes = paste(as.character(sorted[,1]), as.character(sorted[,2]), sep = "_")
  allgeno = cbind(allgeno, genotypes)
}
colnames(allgeno)= c("M1", "M2", "M3", "M4", "M5")
markers = data.frame(prog[,1:4], allgeno)
head(markers)
# This is cleaned data that will be usesd in analysis
# save to the same folder where you have the original .txt data
write.table(markers, "BookCode/chapter2/cleandata.txt", quote=F, sep="\t", row.names=F)

# Analysis starts here
# Fit a linear model
results = lm(weight~M1, data=markers)
class(results)
summary(results)
# corr coeff r is almost zero - poor correlation
# use plot and screen to observe graphically the same
plot(predict(results), residuals(results), main = "Residuals vs fitted values", xlab = "Fitted weight", 
     ylab = "residuals", col = "blue")
split.screen(c(2,1))
screen(1)
qqnorm(predict(results), col="blue")
screen(2)
qqnorm(residuals(results), col="blue", main = "")
close.screen(all=T)

# To make sense out of these plots, I plotted for rnorm
#ref: U of Virginia library: Research Data Services + Sciences
y <- qnorm(seq(0.01, 0.99, 0.01))
qqnorm(y)
# The above gives a straght line, not an almost flat horizontal line as with our example

# Now try anova
anova(results)
# Marker M1 is not significant for explaining weight. Sex may need to be considered
summary(lm(weight~ sex + M1, data=markers))
# Intercept and sex have high t values. Males are 45.58 Kg heavier from the Coefficients list
# Rsquared is high at 0.8325
anova(lm(weight~ sex + M1, data=markers))
# sex has a very high F value from anova data
# Include sire now
summary(lm(weight~sex+sire+M1, data=markers))
#both sex and sire have large influences. Rsq is not 0.89
# sire levels are with respect to sire1, the base level. Thus sire9 has the largest p value and 
# lowest weight difference from sire1. P values do not tell us how much of the variation is
# explained by the sires.
# use anova for that.Build models, store them as mobjects and then compare with anova
model1 = lm(weight~sex+sire+M1, data=markers) # df = 395- 1 (due to sex)- 17(due to M1)
model2 = lm(weight~sex+M1, data=markers)
model3 = lm(weight~M1, data=markers)
anova(model1, model2)
# F value of 27 indicates that sire has significant effect
anova(model2, model3)
# sex is also key - F value is 1776. RSs goes up substantially.
model4 = lm(weight ~1, data = markers)
anova(model3, model4)
# the above confirms that model3 with M1 is not useful.
# sex can also be checked
anova(model2, model4) # highly significant F vakye
# Are there interactions? - do with *
# How about an individual sire? ... Better to compare for all sires
summary(lm(weight ~ sex + M1, data=markers[which(prog$sire =="sire1"),]))
# repeat for all markers, for M5 - there is significance
summary(lm(weight~sex+sire+M5, data=markers))
# The first five M5 markers(denoted with M5 prefix and then the variation of M1_M2, etc)
# are not significant. All have M1. Note also that these comparisons are with respect
# to M1_M1 homozygote. 
# used markers[which(markers$M5 =="M1_M1"),] -- there are 13 such prog animals
# so, that is the baseline
# Author's conclusion: The candidate gene in linkage with marker 5 is a potential suspect for
# having an effect and influencing weight in cattle. Animals which carry allele M1 from marker 5
# show an additional weight gain of ~14kg in relation to other animals (the negative coeffs
# of other marker variations, such as M5M2_M2 etc)
# check M5 effect - of course, you need to do for all markers - as we did for M1 earlier
anova(lm(weight~sex+sire+M5, data=markers))
# unlike other markers, M5 has a high value of F. 
# if we fitted the markers first, rather than  sex ands ire, all markers may appear significant
# order is important in anova.
# One  can also check for all markers at the same time with type=3. F values will be slightly lower
# like this: It runs anova multiple times with a different order. Note the use of 'car' library
library(car)
Anova(lm(weight~sex+sire+M1+M2+M3+M4+M5, data=markers), type=3)
# nlme provides linear mixed effects model. Compare with only fixed effects with
# a mixed effects model with sire as random
library(nlme)
linear=coefficients(lm(weight~sex+sire+M5, data=markers))[c(1,2,12:28)]
random = fixef(lme(weight~sex+M5, random=~1|sire, data=markers))
linear=data.frame(effect=names(linear),fixed=linear)
random=data.frame(effect=names(random), random=random)
comparison=merge(linear,random, by="effect")
comparison=data.frame(comparison, difference = comparison$fixed - comparison$random)
print(comparison)
# the nlme part of the code works. Yet to understand what it does. 
















