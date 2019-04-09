library(seqinr)
library(stringr)
library(ggplot2)

setwd("/home/deea/Documents/ETH/master/courses/year2_2018-2019/semester4/Bayesian_Phylodynamics/Ebola_virus_project/data") #current directory

ebola <- read.fasta("ebov_WestAfrica_2014-2015.fasta")

#random sampling without replacement
#ebola_random <- ebola[sample.int(1610, 100)]
#write.fasta(ebola_random, names(ebola_random), "ebola_random_100.fasta")


#store location and date in a dataframe
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

counts <- table(df_ebola$location)
table(df_ebola$location)
# par(mai=c(1,2,1,1))
# plot_location <- barplot(counts, horiz = TRUE, las=1)
# plot_location














