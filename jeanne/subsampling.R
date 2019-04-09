library(seqinr)
library(stringr)
library(graphics)

#It takes some seconds to read the file, as it is quite large.
setwd("/home/deea/Documents/ETH/master/courses/year2_2018-2019/semester4/Bayesian_Phylodynamics/Ebola_virus_project/data") #current directory
data <- read.fasta("ebov_WestAfrica_2014-2015.fasta", forceDNAtolower = F) #by default in FASTA files, > is the separator
nmes <- names(data)
lgth <- length(data)

#Sample randomly
subset <-data[sample.int(1610,2)]
subset2 <-data[sample(5)]

#Write a FASTA file
write.fasta(subset2,names(subset2),"subset2.fasta")

#Sample from a given location (use package stringr)
kenema_sequences<-data[str_detect(names(data),"Kenema")]
#length(kenema_sequences)
#names(kenema_sequences)
write.fasta(kenema_sequences,names(kenema_sequences),"kenema_sequences.fasta")

# Number of different locations in subset2
# extended_names <- strsplit(names(subset2), split='|', fixed=TRUE)
# matrix_names <- t(matrix(unlist(extended_names), ncol=length(extended_names)))
# length(unique(matrix_names[,5]))
# unique(matrix_names[,5])

#Number of different locations
extended_names <- strsplit(nmes, split='|',fixed=TRUE)
matrix_names <- t(matrix(unlist(extended_names), ncol=length(extended_names)))
nb_locations <- length(unique(matrix_names[,5]))
locations <- unique(matrix_names[,5])

#Occurences of each location - Not vectorized
occurence_locations <- data.frame(locations,rep(Inf,nb_locations)) #has to be a data frame because in a matrix, all elements have to be of the same mode
names(occurence_locations) <- c("locations","occurences")
for (i in 1:nb_locations) {
  occurence_locations[i,2]<-  sum(matrix_names[,5] == locations[i])
}

#Alphabetical order of locations
alph_locations <- occurence_locations[order(occurence_locations[,1]),]
#Decreasing order of locations
decr_locations <-occurence_locations[order(occurence_locations[,2],decreasing = T),]

barplot(decr_locations[1:20,2],names.arg = decr_locations[1:20,1], cex.names = 0.5)
#not all names fit if we display the 49 locations, but with the 20 first and small cex.names, it's OK
#solution to display all the names: write them with a different angle
midpts <- barplot(decr_locations[,2], 1, names.arg="")
text(x=midpts, y=-1, decr_locations[,1], cex=1, srt=45, xpd=TRUE, pos=2) 

# #Macenta sequences (40)
# macenta_sequences<-data[str_detect(names(data),"Macenta")]
# #length(macenta_sequences)
# #names(macenta_sequences)
# write.fasta(macenta_sequences,names(macenta_sequences),"macenta_sequences.fasta")
# 
# #Bomi sequences (5)
# bomi_sequences<-data[str_detect(names(data),"Bomi")]
# #length(bomi_sequences)
# #names(bomi_sequences)
# write.fasta(bomi_sequences,names(bomi_sequences),"bomi_sequences.fasta")

#Other idea: Sort sequences through time
nb_dates <- length(unique(matrix_names[,6]))
dates <- unique(matrix_names[,6])
occurence_dates <- data.frame(dates,rep(Inf,nb_dates)) #has to be a data frame because in a matrix, all elements have to be of the same mode
names(occurence_dates) <- c("dates","occurences")
for (i in 1:nb_dates) { #!!! Not vectorised.
  occurence_dates[i,2]<-  sum(matrix_names[,6] == dates[i])
}
occurence_dates[,1] = as.Date(occurence_dates[,1])
time_range <- range(occurence_dates$dates)#vector, hence:
min_date <- time_range[1]
max_date <- time_range[2]
difftime(max_date,min_date,units="weeks") #or days, but not years. If you want in years, just divide difftime(dates) by 365

incr_dates <-occurence_dates[order(occurence_dates[,1]),]

#Ideally, sort sequences through time AND location
