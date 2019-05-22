# Computes the time origin of epidemics using the results from tracer
# treeHeight posterior
# for the Structured Birth-Death model (first 50 sequences)

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



