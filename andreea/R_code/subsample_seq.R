# packages needed
library(seqinr)
library(stringr)
library(ggplot2)
library(tidyverse)

# works for RStudio Version 1.1.463
working_directory <- dirname(rstudioapi::getSourceEditorContext()$path)

# otherwise, set the working directory manually and update write.fasta() functions accordingly
#setwd("/home/deea/Documents/ETH/master/courses/year2_2018-2019/semester4/Bayesian_Phylodynamics/Ebola_virus_project/R_code")

# read file
data <- read.fasta("../../data/ebov_WestAfrica_2014-2015.fasta")

# Store fasta headers
annotation <- getAnnot(data)

ids1 = sapply(strsplit(as.character(annotation), "\\|"), "[[", 2)
ids2 = sapply(strsplit(as.character(annotation), "\\|"), "[[", 3)
countries = sapply(strsplit(as.character(annotation), "\\|"), "[[", 4)
regions = sapply(strsplit(as.character(annotation), "\\|"), "[[", 5)
dates = sapply(strsplit(as.character(annotation), "\\|"), "[[", 6)

sequences_df <- data.frame(
  id1 = ids1, 
  id2 = ids2, 
  country = countries,
  region = regions, 
  date = dates
)

# Sort data frame chronologically according to the date of the sequences
sequences_df = sequences_df[order(as.Date(sequences_df$date, format="%Y-%m-%d")),]
print(head(sequences_df, 10))

#dates_cal = as.Date(dates, format="%Y-%m-%d")
#dates_cal = dates_cal[order(dates_cal)] # order the dates increasingly 

# Some plots to get an idea of the data distrubution

ggplot(sequences_df[c(1:100), ], aes(x=sequences_df$date[c(1:100)])) + geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=8),
        axis.title.x = element_text(size=15), 
        axis.title.y = element_text(size=15)) + 
  xlab("sampling dates") + 
  ylab("number of samples") + 
  ggsave("sample_dates_reduced.pdf", path = ".")


ggplot(sequences_df, aes(x=sequences_df$date)) + geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=2),
        axis.title.x = element_text(size=15), 
        axis.title.y = element_text(size=15)) + 
  xlab("sampling dates") + 
  ylab("number of samples") + 
  ggsave("sample_dates.pdf", path = getwd())

ggplot(sequences_df, aes(x=sequences_df$country)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=10),
        axis.title.x = element_text(size=14), 
        axis.title.y = element_text(size=14)) + 
  xlab("countries") + 
  ylab("number of samples") + 
  ggsave("sample_countries.pdf", path = getwd())

ggplot(sequences_df, aes(x=sequences_df$region)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=10), 
        axis.title.x = element_text(size=14), 
        axis.title.y = element_text(size=14)) + 
  xlab("regions") + 
  ylab("number of samples") + 
  ggsave("sample_regions.pdf", path = getwd())


region_counts_df = data.frame(region = names(table(unlist(sequences_df$region))), counts = as.numeric(as.matrix(table(unlist(sequences_df$region)))))
ggplot(region_counts_df, aes(x = reorder(region, -counts), y = counts)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=10), 
        axis.title.x = element_text(size=14), 
        axis.title.y = element_text(size=14)) + 
  xlab("regions") +
  ylab("number of samples") + 
  ggsave("sample_regions_ordered.pdf", path = getwd())

# Sample only the sequences coming from Western Rural, Western Urban and Western Area
western_rural_seq <- data[which(str_detect(names(data), "WesternRural"))]
l1 = length(western_rural_seq)
sprintf("Total number of sequences from the Wester Rural: %d", l1)

western_urban_seq <- data[which(str_detect(names(data), "WesternUrban"))]
l2 = length(western_urban_seq)
sprintf("Total number of sequences from the Western Urban: %d", l2)

western_area_seq <- data[which(str_detect(names(data), "WesternArea"))]
l3 = length(western_area_seq)
sprintf("Total number of sequences from the Western Area: %d", l3)

ltot <- l1 + l2 + l3
sprintf("Total number of sequences from the Western Area + Rural + Urban: %d", ltot)

western_region <- c(western_rural_seq, western_urban_seq, western_area_seq)
western_dates = sapply(strsplit(as.character(getAnnot(western_region)), "\\|"), "[[", 6)
western_dates = as.Date(western_dates, format="%Y-%m-%d")
western_dates = western_dates[order(as.Date(western_dates, format="%Y-%m-%d"))] # order the dates increasingly 

#ggplot(data.frame(dates = as.character(western_dates)), aes(x=dates)) + 
ggplot(data.frame(dates = western_dates), aes(x=dates)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size=12),
        axis.title.x = element_text(size=12), 
        axis.title.y = element_text(size=12)) + 
  #scale_x_discrete(breaks=seq(0,40,5)) + 
  scale_x_date(date_labels = "%Y-%m-%d", breaks= scales::pretty_breaks(n=25)) + 
  xlab("sampling dates") + 
  ylab("number of samples") + 
  ggsave("western_sample_dates.pdf", path = getwd())

# write data to file
write.fasta(western_rural_seq, names(western_rural_seq), paste(working_directory, "/../../data/western_rural_EBOV.fasta", sep=""))
write.fasta(western_urban_seq, names(western_urban_seq), paste(working_directory,"/../../data/western_urban_EBOV.fasta", sep=""))
write.fasta(western_area_seq, names(western_area_seq), paste(working_directory,"/../../data/western_area_EBOV.fasta", sep=""))
write.fasta(western_region, names(western_region), paste(working_directory,"/../../data/western_regions_EBOV.fasta", sep=""))

# remove sequences with unkown regions
sequences_df <- sequences_df %>% filter(region != "?")

# order sequences by the sample date
sequences_df <- sequences_df[order(as.Date(sequences_df$date, format="%Y-%m-%d")),]

# select the first 200 sequences in a chronological order

# the line below might be equivalent to the for loop, but does not instert the sequences in order in the list
# (which probably doesn't matter, you should check that later)
#first_seq = data[which(str_detect(names(data), paste(head(sequences_df$id1, 200),collapse = '|')))]

no_seq = 200
first_200_seq_id1 = head(sequences_df$id1, no_seq)
first_seq = list()
for (i in 1:no_seq) {
  first_seq <- c(first_seq, data[which(str_detect(names(data), toString(first_200_seq_id1[i])))])
}

# remove duplicates
first_seq <- first_seq[!duplicated(first_seq)]

# remove the first two attributes to be able to select the locations in BEAUTI
for (i in 1:length(first_seq)) {
  names(first_seq)[i] <- gsub("^\\w*\\|\\w*\\.*\\-*\\w*\\|","", names(first_seq)[i])
  attr(first_seq[[i]], "Annot") <- paste(">", gsub("^>\\w*\\|\\w*\\.*\\-*\\w*\\|","", names(first_seq)[i]), sep="")
  attr(first_seq[[i]], "name") <- sub("^\\w*\\|\\w*\\.*\\-*\\w*\\|","", names(first_seq)[i])
}
write.fasta(first_seq, names(first_seq), paste(working_directory,"/../../data/first_seq_EBOV.fasta", sep=""))
