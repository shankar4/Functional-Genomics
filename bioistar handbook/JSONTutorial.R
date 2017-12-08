setwd("/home/shankar/Genome/Biostar/ontology")
getwd()

# Get familiar with a tutorial that uses a NY state JSON dataset
# Here is the link: 
# http://zevross.com/blog/2015/02/12/using-r-to-download-and-parse-json-an-example-using-data-from-an-open-data-portal/
# I used for loops to achieve what the author achieved with apply()
# Also, I used Mozilla Firefox to review the JSON file, not a text editor; much easier to interpret
# Also, I used jsonlite, rather than JSONIO that the author used. See more below
library(jsonlite)
# Also reaad an article on jsonlite by Ooms, 2014 to understand better how to use the package
# jsonlite paper uses testthat dataset useful to learn. Not used here
# library(testthat)
# Df in R uses column based storage. Jsonlite maps dfs by default to an array of records
# The article helped get a better feel for JSON object and JSON vector

# Get the NY City data
library(curl)
url2 <- "https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD"
foodMarketsRaw <- fromJSON(url2, simplifyVector = FALSE) # FALSE option downloads faster
download.file(url2, "markets.json")
# Look at the file in a text editor (did not do). 
# I opened it in Mozilla
# Under columns, there are entries listed as 0 to 22. The item numbered 13 is "dba_name"
# Lots of metadata at the start. Data starts on line 1229 - per tha author of the tutorial. I did not check that.
# Explored in "Environments" in RStudio. There are two major elements: meta and data. can't see data - but it is there!
# but eventually, I downloaded the JSON as a .JSON file and opened it in Mozilla. See the download instruction above.

str(foodMarketsRaw)
summary(foodMarketsRaw) # gives the labels for the two: meta and data
foodMarkets <- foodMarketsRaw[['data']]
summary(foodMarkets) # prints out a long list
str(foodMarkets) # gives the hierarchy info - lists within lists
# Explore in 'Environment' - Lists of 23 items. 
# refer to meta - list of 37. field names: id, name, attribution, etc. 
# scroll down - locate $columns: list of 23
summary(foodMarkets) # Let us explore the first record
foodMarkets[[1]]
length(foodMarkets[[1]]) # 23 items of info
# Going back to meta to find the keys
foodMarketKeys <- foodMarketsRaw[['meta']]
summary(foodMarketKeys) # 37 entries
str(foodMarketKeys) #
foodMarketKeys[[1]][[1]] # corresponds to the id field or view
foodMarketKeys[[1]]$description
foodMarketKeys[[1]]$columns # list of items for each of 23 shops
foodMarkets[[1]] # details of the first entry; first entry is the id
# checking through foodMarkets shows a list of 22 items and a sublist of 5
foodMarkets[[1]][23] # has lat and long info
#drop it for now before building a data frame
Markets <- foodMarkets[[1]][-23]
for (i in 1:length(foodMarkets)) {Markets[[i]]<- foodMarkets[[i]][-23]}
summary(Markets)
Names <- c("NULL")
for (i in 1:length(foodMarkets)) {Names[[i]]<- foodMarkets[[i]][14]}
length(Names)
Names[[1]]
Names[1]
markets.df <- data.frame(matrix(unlist(Markets), nrow= length(Markets), byrow=TRUE), stringsAsFactors=FALSE)
# 8th entries of NULL got removed. Not sure why.
# corresponds to (as read from the Mozilla rendering of the JSON file): ":meta" - I suppose no meta data at this level
markets.df[1,13] # business name
#extract column names from meta
columnNames <- foodMarketKeys[['view']][['columns']]
dfnames <- c('NULL')
for (i in 1: length(columnNames)) {dfnames[i] <- columnNames[[i]]$name}
Markets.names <- dfnames[-c(8,23)] # remove the metadata and location entries. Tried to do by name, did not work
# verified they are alighned
Markets.names[13]
markets.df[1,13]
colnames(markets.df) <- Markets.names
# Now DF is complete, but for the location data
location <- c('NULL')
for (i in 1:length(foodMarkets)) {location[[i]]<- foodMarkets[[i]][23]}
# find positions of lat and long
length(columnNames[[23]]) # 12 entries
columnNames[[23]][11:12] # format and subColumnTypes, [1] was sid
columnNames[[23]][12]$subColumnTypes[2:3] # Lat and Long

lat <- c('NULL')
long <- c('NULL') # Entry 14 has null and null for lat and long. 
# We thus need a bit more complicated code for this
for (i in 1:length(location)) {
  val <- location[[i]][[1]][[2]]
  if (!is.null(val)) lat[i]<- val
      else lat[i] <- NA}
for (i in 1:length(location)) {
  val <- location[[i]][[1]][[3]]
  if (!is.null(val)) long[i]<- val
  else long[i] <- NA}
location.info <- data.frame(cbind(lat, long))
colnames(location.info)<- c("lattitude", "longitude")
head(location.info)
#for (i in 1:length(location)) {long[i]<- location[[i]][[1]][[3]]} -- this will not work as the 14th entry is NULL, NULL
# for lat and long. 
head(location.info)
length(location.info)
# verified both same row numbers of 29113
dim(location.info) # 2 columns
dim(markets.df) # 21 columns

NYMarkets <- cbind(markets.df, location.info)
dim(NYMarkets) # 29113 23



 
