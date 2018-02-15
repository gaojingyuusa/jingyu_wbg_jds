library(RJSONIO)
library(WDI)
library(ggplot2)
library(jsonlite)


#apple <- as.data.frame(fromJSON('http://api.worldbank.org/v2/countries/all/indicators/SH.STA.ACSN?format=json&date=1960&per_page=1000'))
#test <- apple[ , !names(apple) %in% drop_col]

# Find data information: total pages, number of data per page
page_total <- as.data.frame(fromJSON('http://api.worldbank.org/v2/countries/all/indicators/SH.STA.ACSN?format=json'))[[2]][1]

# Create list of colnames that are irrelevant 
drop_col <- c("page","pages","per_page","lastupdated","total","decimal", "unit","obs_status")

# Write a loop to construct complete dataset for sanitation
san_dat <- data.frame()
for (i in 1:9) {
  # Generate url for each page
  url <- paste0('http://api.worldbank.org/v2/countries/all/indicators/SH.STA.ACSN?format=json&page=',i)
  # Get json data from each page and transform it into dataframe
  dat <- as.data.frame(fromJSON(url))
  rownames(dat) <- NULL
#  dat_cl <- dat[, !names(dat) %in% drop_col]
  san_dat <- rbind(san_dat, dat)
}