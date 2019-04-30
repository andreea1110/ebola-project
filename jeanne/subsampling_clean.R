library(seqinr)
library(stringr)
library(graphics)

#It takes some seconds to read the file, as it is quite large.
setwd("C:/Users/Jeanne/Documents/ETH/Bayesian_Phylo/Ebola") #current directory
data <- read.fasta("ebov_WestAfrica_2014-2015.fasta",forceDNAtolower = F) #by default in FASTA files, > is the separator
nmes <- names(data)
lgth <- length(data)

#Number of different locations
extended_names <- strsplit(nmes, split='|',fixed=TRUE)
matrix_names <- t(matrix(unlist(extended_names), ncol=length(extended_names)))
headers <- data.frame(matrix_names[,1],matrix_names[,2],matrix_names[,3],matrix_names[,4],matrix_names[,5],matrix_names[,6])
names(headers) <- c("epidemics","ID1","ID2","countries","locations","dates")
nb_locations <- length(unique(headers$locations))
locations <- unique(headers$locations)

#Occurences of each location - Not vectorized
occurence_locations <- data.frame(locations,rep(Inf,nb_locations)) #has to be a data frame because in a matrix, all elements have to be of the same mode
names(occurence_locations) <- c("locations","occurences")
for (i in 1:nb_locations) {
  occurence_locations[i,2]<-  sum(headers$locations == locations[i])
}

#Alphabetical order of locations
alph_locations <- occurence_locations[order(occurence_locations[,1]),]
#Decreasing order of locations
decr_locations <-occurence_locations[order(occurence_locations[,2],decreasing = T),]

#Countries
nb_countries <- length(unique(headers$countries))
countries <- unique(headers$countries)
occurence_countries <- data.frame(countries,rep(Inf,nb_countries))
names(occurence_countries) <- c("countries","occurences")
for (i in 1:nb_countries) {
  occurence_countries[i,2]<-  sum(headers$countries == countries[i])
}

#Luckily, only 2 samples out of the lgth = 1610 have no attributed countries.

#Sort sequences through time
nb_dates <- length(unique(headers$dates))
dates <- unique(headers$dates)
occurence_dates <- data.frame(dates,rep(Inf,nb_dates)) #has to be a data frame because in a matrix, all elements have to be of the same mode
names(occurence_dates) <- c("dates","occurences")
for (i in 1:nb_dates) { #!!! Not vectorised.
  occurence_dates[i,2]<-  sum(headers$dates == dates[i])
}
occurence_dates$dates = as.Date(occurence_dates$dates)
time_range <- range(occurence_dates$dates)#vector, hence:
min_date <- time_range[1]
max_date <- time_range[2]
span <-difftime(max_date,min_date,units="days") #or weeks, but not years. If you want in years, just divide difftime(dates) by 365
#!!! The number of days are actually span + 1
incr_dates <-occurence_dates[order(occurence_dates$dates),]

calendar <- seq(min_date,to=max_date,by='days')
all_dates <- data.frame(calendar,rep(0,span+1))
names(all_dates) <- c("dates","occurences")

count<-1
for (i in 1:span) {
  if (all_dates$dates[i] == incr_dates$dates[count]) {
    all_dates$occurences[i] <- incr_dates$occurences[count]
    count<-count+1
  }
}

all_dates$occurences[span+1] <-incr_dates$occurences[count]

#1 location > samples through date
montserrado_sequences<-data[str_detect(names(data),"Montserrado")]
montserrado_headers <- subset(headers,locations=="Montserrado")
montserrado_headers$dates <- as.Date(montserrado_headers$dates)
chron_montserrado <-montserrado_headers[order(montserrado_headers$dates),]

montserrado_all_dates <- data.frame(calendar,rep(0,span+1))
names(montserrado_all_dates) <- c("dates","occurences")
for (i in 1:span+1) {
  montserrado_all_dates$occurences[i] <- sum(montserrado_all_dates$dates[i] == chron_montserrado$dates)
}

#To infer origin, only sample the first 200 sequences, removing those from "?" or " "
headers$dates = as.Date(headers$dates)
headers_known_loc <- headers[headers$locations != '?' & headers$locations !="",]
incr_headers <- headers_known_loc[order(headers_known_loc$dates),]
headers200 <- incr_headers[1:200,]

#But now, we have to take the associated DNA sequences, not as easy as only from one location!
#Idea: use the (unique, see check_unique_ID) ID's in 3rd column to fish the sequences from the main fasta file (data)

check_unique_ID <- length(unique(headers200[,3])) == 200

#task left: subsample data according to the ID's in headers200

boolean_sequences200 <- str_detect(names(data),toString(headers200$ID2[1]))
for (i in 2:lgth) {
  boolean_sequences200 <- boolean_sequences200|str_detect(names(data),toString(headers200$ID2[i]))
}
sequences200 <- data[boolean_sequences200]

#merge the first headers to be able to use the locations
extended_names200 <- strsplit(names(sequences200), split='|',fixed=TRUE)
short_names200 <- rep("",200)
for (j in 1:200) {
  short_names200[j] <- str_glue(extended_names200[[j]][4],extended_names200[[j]][5],extended_names200[[j]][6],.sep="|")
}
names(sequences200) <- short_names200
#write.fasta(sequences200,names(sequences200),"sequences200.fasta")
