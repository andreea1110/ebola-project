# Pie Chart with Percentages
library(ggplot2)

# Structured Birth-Death
kissidougou =  0.0133
gueckedou =  0.9767
macenta =  0.01
kailahun = 0
slices <- c(kissidougou, gueckedou, macenta, kailahun) 
lbls <- c("Kissidougou", "Gueckedou", "Macenta", "Kailahun")
cols <- c("red", "green", "light blue", "purple")

# pct <- round(slices/sum(slices)*100)
# lbls <- paste(lbls, pct) # add percents to labels 
# lbls <- paste(lbls,"%",sep="") # ad % to labels 
# pie(slices,labels = lbls, col=cols, main="Structured Birth-Death", radius = 1, cex = 0.3)


df <- data.frame(
  group = c("Kissidougou 1.33%", "Gueckedou 97.67%", "Macenta 1%", "Kailahun 0%"),
  value = c(kissidougou, gueckedou, macenta, kailahun)
)
# Barplot
bp <- ggplot(df, aes(x="", y=value, fill=group)) +
      geom_bar(width = 1, stat = "identity") + 
      #guides(fill=guide_legend(title=NULL)) + 
      theme(legend.title=element_blank(),
            plot.title = element_text(hjust = 0.5),
            axis.title.x=element_blank(),
            axis.ticks.x=element_blank(), 
            axis.title.y=element_blank(),
            axis.ticks.y=element_blank()) +
      ggtitle("Structured Birth-Death")
pie <- bp + coord_polar("y", start=0) + scale_fill_manual(values=cols) 
pie

# Discrete Phylogeography
kissidougou =  0.37
gueckedou =  0.54
macenta =  0.09
kailahun = 0

slices <- c(kissidougou, gueckedou, macenta, kailahun) 
lbls <- c("Kissidougou", "Gueckedou", "Macenta", "Kailahun")
cols <- c("red", "green", "light blue", "purple")

df <- data.frame(
  group = c("Kissidougou 37%", "Gueckedou 54%", "Macenta 9%", "Kailahun 0%"),
  value = c(kissidougou, gueckedou, macenta, kailahun)
)
# Barplot
bp <- ggplot(df, aes(x="", y=value, fill=group)) +
  geom_bar(width = 1, stat = "identity") + 
  #guides(fill=guide_legend(title=NULL)) + 
  theme(legend.title=element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.title.x=element_blank(),
        axis.ticks.x=element_blank(), 
        axis.title.y=element_blank(),
        axis.ticks.y=element_blank()) +
  ggtitle("Discrete Phylogeography")
pie <- bp + coord_polar("y", start=0) + scale_fill_manual(values=cols) 
pie

# Discrete Phylogeography constant
kissidougou =  0.2079
gueckedou =  0.5743
macenta =  0.2079
kailahun = 0.0099

slices <- c(kissidougou, gueckedou, macenta, kailahun) 
lbls <- c("Kissidougou", "Gueckedou", "Macenta", "Kailahun")
cols <- c("red", "green", "light blue", "purple")

df <- data.frame(
  group = c("Kissidougou 20.79%", "Gueckedou 57.43%", "Macenta 20.79%", "Kailahun 0.99%"),
  value = c(kissidougou, gueckedou, macenta, kailahun)
)
# Barplot
bp <- ggplot(df, aes(x="", y=value, fill=group)) +
  geom_bar(width = 1, stat = "identity") + 
  #guides(fill=guide_legend(title=NULL)) + 
  theme(legend.title=element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.title.x=element_blank(),
        axis.ticks.x=element_blank(), 
        axis.title.y=element_blank(),
        axis.ticks.y=element_blank()) +
  ggtitle("Discrete Phylogeography (constant population size)")
pie <- bp + coord_polar("y", start=0) + scale_fill_manual(values=cols) 
pie

# Scotti
kissidougou =  0
gueckedou =  0.96
macenta =  0.03
kailahun = 0
unsampled = 0.01

slices <- c(kissidougou, gueckedou, macenta, kailahun, unsampled) 
lbls <- c("Kissidougou", "Gueckedou", "Macenta", "Kailahun", "Unsampled")
cols <- c("red", "green", "light blue", "purple", "yellow")

df <- data.frame(
  group = c("Kissidougou 0%", "Gueckedou 96%", "Macenta 3%", "Kailahun 0%", "Unsampled 1%"),
  value = c(kissidougou, gueckedou, macenta, kailahun, unsampled)
)
# Barplot
bp <- ggplot(df, aes(x="", y=value, fill=group)) +
  geom_bar(width = 1, stat = "identity") + 
  #guides(fill=guide_legend(title=NULL)) + 
  theme(legend.title=element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.title.x=element_blank(),
        axis.ticks.x=element_blank(), 
        axis.title.y=element_blank(),
        axis.ticks.y=element_blank()) +
  ggtitle("SCOTTI")
pie <- bp + coord_polar("y", start=0) + scale_fill_manual(values=cols) 

pie

