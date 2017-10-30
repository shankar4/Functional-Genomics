getwd()
dir()
source("BookCode/chapter1/Sc1.r")
ls()
readLines("BookCode/chapter1/Sc1.r", n=5)
mydata = read.table("BookCode/chapter1/snps.txt", header=T, sep="\t")
View(mydata)
dim(mydata)
print(mydata[2,3])
print(mydata$allele2[3])
print(mydata$allele2[2])
names(mydata)
colnames(mydata)
rownames(mydata)
mydata[1:5, 1:2]
indices = c(1,7,6,3)
print(mydata[indices,])
print(mydata$name[indices])
pheno = read.table("BookCode/chapter1/animals.txt", header=T, sep="\t")
print(pheno)
print(pheno$id)
class(pheno$id)
class(pheno$weight)
phenowrong = read.table("BookCode/chapter1/animals2.txt", header=T, sep="\t")
print(phenowrong)
class(phenowrong$weight)
phenoright = read.table("BookCode/chapter1/animals2.txt", header=T, sep="\t", na.strings = "*")
print(phenoright)
class(phenoright$weight)

# missing values may not be listed as NA, but with different terms
# such as missing, *, - , etc
# either first convert as given above
# or convert factor to character and then to numeric as below
phenowrong$weight = as.numeric(as.character(phenowrong$weight))
class(phenowrong$weight)
alldata = cbind(mydata, pheno)
print(head(alldata))
# name and id seem similar. 
alldata = alldata[, -1] # drop the name identifier
#reorder with id first
alldata = alldata[,c(3,4,1,2)]
print(alldata)
alldata = alldata[order(alldata$weight, decreasing = T),]
print(alldata)
summary(alldata)
min(alldata$weight, na.rm = T)
# max(alldata$allele1) - can't do this for factors
#other commands - mean, median, quantile.
factor(alldata$allele1)
sd(alldata$weight, na.rm = T)
var(alldata$weight, na.rm = T)
barplot(c(summary(alldata$allele1)), main ="allele1 counts", col= c(1,2,3))
barplot(c(summary(alldata$allele1), summary(alldata$allele2)), main ="allele1 counts", col= c(1,2,3))
palette()
pooled = c(as.character(alldata$allele1), as.character(alldata$allele2))
pooled = summary(factor(pooled))
barplot(pooled, main = "Pooled allele counts", col = c(4,5,6))
legend("topleft", c("-", "A", "B"), fil =4:6)
# the following would give wrong answer - you will get factor value as per book
head(c(alldata$allele1, alldata$allele2))
#correct way is as follows
head(c(as.character(alldata$allele1), as.character(alldata$allele2)))
summary(c(as.character(alldata$allele1), as.character(alldata$allele2)))    
boxplot(alldata$weight, col="blue", main = "Weights for all animals")
boxplot(alldata$weight ~ alldata$allele1, col=2:4, main= "weights by allele classes")
plot(density(alldata$weight, na.rm = T), main="Density plot of weights", col = "blue")
plot(sort(alldata$weight), col="blue", main="Sorted weights", xlab = "animal", ylab = "Weight")
lines(sort(alldata$weight), col='red')
plot(alldata$weight ~ alldata$allele1, col=c(4:6), main="Sorted weights", xlab = "allele1", ylab = "Weight")
write.table(alldata, "BookCode/chapter1/alldata.txt", quote=F, row.names=F, sep = "\t")
#save programmatically the plots
plot(density(alldata$weight, na.rm = T), main="Density plot of weights", col= 4)
dev.print(file="BookCode/chapter1/density2.pdf", device=pdf, width=10, height=10)