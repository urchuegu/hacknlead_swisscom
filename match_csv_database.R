#####Load list of winning companies ######
library(dplyr)
library(tidyr)
library(ggplot2)
setwd('Documents/hackandlead/swissteamchallenge/')

trim_lower_name <- function(x){
  #trims from some vector the names, etc
  #return a character vector for each field of x
  x <- gsub(' AG*','', x)
  x <- gsub(' SA', '', x)
  x <- gsub(' S\303\240rl', '',  x)
  x <- gsub("\\s*\\([^\\)]+\\)","", x)
  x <- gsub(' SARL', '', x)
  x <- gsub(' GmbH', '', x)
  x <- gsub(' Inc', '', x)
  x <- gsub(' SL', '', x)
  return(x)
}



###What are the 100 winners of the last years

#Organizations in crunch database
organizations <- read.csv('csv_export/organizations.csv')

###this year candidates
comps_thisyear <- read.csv('startup.ch 2013 - 2018.csv')

####ranked datasets
ranked <- list.files('ranked/', pattern = 'csv', full.names = T)


ranked <- lapply(ranked, function(r){
  df <- read.csv(r)
  df <- data.frame(df, year = gsub('.csv', '', basename(r)))
  return(df)
  
})

ranked <- do.call(rbind, ranked)

comps_thisyear$Company <- as.character(comps_thisyear$Company)
ranked$Name <- as.character(ranked$Name)

comps_thisyear$comps <- tolower(trim_lower_name(comps_thisyear$Company))
ranked$comps <- tolower(trim_lower_name(ranked$Name))
organizations$comps <- tolower(trim_lower_name(organizations$company_name))

comps_thisyear$comps <- trimws(comps_thisyear$comps, which = 'both')
ranked$comps <- trimws(ranked$comps, which = 'both')
organizations$comps <- trimws(organizations$comps, which = 'both')


candidates_this_year <- right_join(organizations, comps_thisyear, by = 'comps')
candidates_this_year_indatabase <- filter(candidates_this_year, !is.na(company_name))
candidates_this_year_nodatabase <- filter(candidates_this_year, is.na(company_name))

write.csv(candidates_this_year_indatabase, 'final_datasets/candidates_startups_in_database.csv')
write.csv(candidates_this_year_indatabase, 'final_datasets/candidates_startups_not_database.csv')


winners_last <- right_join(organizations, ranked, by = 'comps')
winners_last_indb <- filter(winners_last, !is.na(company_name))
winners_last_nodb <- filter(winners_last, is.na(company_name))

write.csv(winners_last_nodb, 'final_datasets/winner_startups_no_database.csv')
write.csv(winners_last_indb, 'final_datasets/winner_startups_in_database.csv')



