library(seqinr)
library(stringr)
library(graphics)

setwd("C:/Users/Jeanne/Documents/ETH/Bayesian_Phylo/Ebola/Origin")
data <- read.fasta("sequences50.fasta",forceDNAtolower = F)
nmes <- names(data)

###For the fasta file: only ID2 and genetic sequences, knowing "EBOV" and ID1 have already been removed

extended_names <- strsplit(nmes, split='|',fixed=TRUE)
matrix_names <- t(matrix(unlist(extended_names), ncol=length(extended_names)))
headers <- data.frame(matrix_names[,1],matrix_names[,2],matrix_names[,3],matrix_names[,4])
names(headers) <- c("ID2","countries","locations","dates")
headers$dates <- as.Date(headers$dates)

sequences50_SCOTTI <- data

names(sequences50_SCOTTI)<- headers$ID2

setwd("C:/Users/Jeanne/Documents/ETH/Bayesian_Phylo/Ebola/Origin/SCOTTI/Run3")

#write.fasta(sequences50_SCOTTI,names(sequences50_SCOTTI),"sequences50_SCOTTI.fasta")

#Important to introduce ----------------- at the beginning of each sequences and - at the end too?
# > from lines 118 to 148 of the Pyhton file, doesn't seem to be the case. Let's forget about it for the moment.
#There is also the fact that in the FMDV fasta file, each sequence takes a line, whereas on mine it takes several of them.

#PB with the fact that there are N's and not only ----?

###Dates file: csv (comma-separated-values) files, dates provided in numbers, forward in time OK

#looks like the key command in what follows will be write.csv

dates <- data.frame(headers$ID2,headers$dates)
chron_dates <- dates[order(dates$headers.dates),]
first_date <- as.numeric(chron_dates$headers.dates[1])
last_date <- as.numeric(chron_dates$headers.dates[50])
numeric_dates <- data.frame(headers$ID2,as.numeric(headers$dates))
numeric_dates$as.numeric.headers.dates. <- numeric_dates$as.numeric.headers.dates.-first_date
chron_numeric <- numeric_dates[order(numeric_dates$as.numeric.headers.dates.),]


#write.csv(numeric_dates,"sequences50_dates.csv",quote = F,row.names = F, col.names = F)

#Column names directly removed from the Excel file
#Important to have a comma between the ID and the date?
#>from line 176 in Python file, doesn't seem to be the case

### Hosts file: mapping from each sequence to the host it was sampled from
#for us, ID2 and location

hosts <- data.frame(headers$ID2,headers$locations)

#write.csv(hosts,"sequences50_hosts.csv",quote=F,row.names = F,col.names = F)

#Column names directly removed from the Excel file

### HostTimes file: earliest and latest dates when hosts (and not individuals!!!) are infectious
#these dates correspond to the introduction and removal of hosts to the outbreak

nb_locations <- length(unique(headers$locations))
locations <- unique(headers$locations)

#Sequences come from sick individuals. According to WHO, someone sick is infectious during 10 days.
#Since we cannot know at which stage of the disease the patient's ADN was sequenced, we assume they were infectious 10 days before
#and 10 days after the sampling date
#For each of the 4 locations, we need the dates of the first and last sample.
#Then we decide the host could have already been infected 1200 days (December 2013 to March 2014) before the first sample,
#and staid infectious for 1000 days after the last sample.

nb_dates <- length(unique(headers$dates))

vect_min_date <- rep(-first_date,nb_locations)
vect_max_date <- rep(last_date-first_date+514,nb_locations)

host_times <- data.frame(locations,vect_min_date,vect_max_date)
names(host_times) <-c("locations","min","max")

for (i in 1:nb_locations){
  host_times$min[i] <- min(as.numeric(subset(headers,headers$locations==host_times$locations[i])$dates)-120-first_date)
}

#write.csv(host_times,"sequences50_hostTimes.csv",quote=F,row.names = F)

#Column names directly removed from the Excel file

origin <- chron_dates$headers.dates[50]
mean50 <- as.Date(-124,origin)
min_HPD50 <- as.Date(-163,origin)
max_HPD50 <- as.Date(-91,origin)
time50 <-c(mean50,min_HPD50,max_HPD50)
time_range50 <- max_HPD50-min_HPD50