setwd ("/home/shankar/Genome/GenomicSystems")
library(httr); library(jsonlite); library(RCurl); library(XML)
url <- "http://rest.kegg.jp"
urlinfo <- paste(url, "info", sep="/")
KeggInfo <- getURL(paste(urlinfo, "kegg", sep="/"))
# Looks like it is either text or xml data
diseases <- getURL(paste(url, "/list/disease", sep=""))
pathways <- getURL(paste(url, "/list/pathway/hsa", sep = ""))
# still to figure out how to separate out the long textual output, I suppose, using grep