# Computes the time origin of epidemics using the results from tracer
# treeHeight posterior (assuming values are percentage of a year)
# for the Structured Birth-Death model (first 50 sequences)

library(ggplot2)

### Useful functions ###
percentage_to_dates <- function(percentage_of_year, year_days=365) {
  days <- floor(percentage_of_year * year_days)
  return(days)
}

### Main ###
earliest_date <- as.Date("2014-05-28", format="%Y-%m-%d")
mean_tree_height_per <- 0.3212
HPD_low_per <- 0.2463
HPD_high_per <- 0.4031

# transforming from percentages to years
mean_tree_height <- percentage_to_dates(mean_tree_height_per)
HPD_low <- percentage_to_dates(HPD_low_per)
HPD_high <- percentage_to_dates(HPD_high_per)

mean_origin_date <- earliest_date - mean_tree_height
HPD_low_origin_date <- earliest_date - HPD_low
HPD_high_origin_date <- earliest_date - HPD_high


sprintf("Mean origin date: %s", mean_origin_date)
sprintf("HPD low origin date: %s", HPD_low_origin_date)
sprintf("HPD high origin date: %s", HPD_high_origin_date)

times_df <- data.frame(row.names = c("Str_BD", "Disc_Phylogeo"))
times_df$mean = c(mean_origin_date, as.Date("2014-01-26"))
times_df$HPD_low = c(HPD_low_origin_date, as.Date("2013-12-21"))
times_df$HPD_high = c(HPD_high_origin_date, as.Date("2014-02-25"))

ggplot(times_df, aes(x=rownames(times_df), y=df$mean)) + 
  geom_errorbar(aes(ymin=HPD_low, ymax=HPD_high), width=0.1) +
  geom_line() +
  geom_point(size=3, color=c("black", "black")) + 
  xlab("Model") +
  ylab("Predicted outbreak date") + 
  #ylim(as.Date("2013-06-01", format="%Y-%m-%d"), as.Date("2014-05-01", format="%Y-%m-%d")) + 
  scale_y_date(date_minor_breaks = "4 week", date_breaks = "2 week")
  scale_x_discrete(name ="Model", labels=c("1" = "Str. BD")) +
  theme(axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        axis.title.x = element_text(size=15), 
        axis.title.y = element_text(size=15))

