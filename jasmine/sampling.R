library(seqinr)
library(stringr)
library(ggplot2)

#setwd("/home/deea/Documents/ETH/master/courses/year2_2018-2019/semester4/Bayesian_Phylodynamics/Ebola_virus_project/data") #current directory
setwd("/Users/Jasmine/Documents/ETH/S2 Bayesian Phylodynamics/Project/ebola-project/jasmine")

#ebola <- read.fasta("ebov_WestAfrica_2014-2015.fasta")

#random sampling without replacement
#ebola_random <- ebola[sample.int(1610, 100)]
#write.fasta(ebola_random, names(ebola_random), "ebola_random_100.fasta")



### Create Data Frame with location and date

# df_ebola <- data.frame(name = names(ebola), location = c("empty"), date = c("empty"), row.names = 1:1610, stringsAsFactors = FALSE)
# for (i in 1:1610) {
#   compt <- 0
#   j <- 1
#   while (compt < 4) {
#     if (substr(df_ebola[i,"name"],j,j) == "|") {
#       compt <- compt + 1
#     }
#     j <- j + 1
#   }
#   k <- j
#   while (compt < 5) {
#     if (substr(df_ebola[i,"name"],j,j) == "|") {
#       compt <- compt + 1
#     }
#     j <- j + 1
#   }
#   df_ebola[i, "location"] <- substr(df_ebola[i, "name"], k, j-2)
#   df_ebola[i, "date"] <- substr(df_ebola[i, "name"], j, j+9)
# }
# save(df_ebola, file = "df_ebola.Rda")

load("df_ebola.Rda")

#table(df_ebola$location)




### Create fasta with Conakry samples

# conakry_names <- df_ebola[df_ebola$location == "Conakry",]$name
# conakry <- ebola[conakry_names]
# write.fasta(conakry, names(conakry), "conakry.fasta")

# coyah_names <- df_ebola[df_ebola$location == "Coyah",]$name
# dubreka_names <- df_ebola[df_ebola$location == "Dubreka",]$name
# conakry_extended <- ebola[c(conakry_names, coyah_names, dubreka_names)]
# write.fasta(conakry_extended, names(conakry_extended), "conakry_extended.fasta")



### Check sample dates

# data <- as.Date(df_ebola[df_ebola$location == "Conakry",]$date)
# hist(data, "months")
# data_extended <- as.Date(df_ebola[df_ebola$location %in% c("Conakry","Coyah","Dubreka"),]$date)
# hist(data_extended, "months")














