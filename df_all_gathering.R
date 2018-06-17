#### gathering winners+ candidates together in one big file

library(dplyr)
library(tidyr)
library(ggplot2)

setwd('Documents/hackandlead/swissteamchallenge/')


winners_wide <- read.csv('final_datasets/winners_in_database_reformatted_wideformat.csv')
candidates <- read.csv('final_datasets/candidates_in_database_reformatted.csv')
winners <- read.csv('final_datasets/winners_in_database_reformatted.csv')

winners_per_year <- mutate(winners_wide, 
                           rank2012 = in2012,
                           rank2013 = in2013,
                           rank2014 = in2014,
                           rank2015 = in2015,
                           rank2016 = in2016,
                           rank2017 = in2017,
                           in2012 = ifelse(rank2012!=0, 1, 0),
                           in2013 = ifelse(rank2013!=0, 1, 0),
                           in2014 = ifelse(rank2014!=0, 1, 0),
                           in2015 = ifelse(rank2015!=0, 1, 0),
                           in2016 = ifelse(rank2016!=0, 1, 0),
                           intop2012 = ifelse(rank2012<11, 1, 0),
                           intop2013 = ifelse(rank2013<11, 1, 0),
                           intop2014 = ifelse(rank2014<11, 1, 0),
                           intop2015 = ifelse(rank2015<11, 1, 0),
                           intop2016 = ifelse(rank2016<11, 1, 0),
                           intop2017 = ifelse(rank2017<11, 1, 0))


winners_per_year <- mutate(winners_per_year, type = 'winners')


feats_to_remove <- c('investor_uuids', 
'country_code_investor', 
'role_investor', 
'region_investor', 
'investor_uuid',
'raised_amount',
'raised_amount_currency_code',
'post_money_valuation',
'post_money_currency_code',
'state_code_company',
'primary_role', 
'state_code_inverstment', 
'X1Liner', 
'Description')


df <- lapply(split(winners, winners$year), function(g){
  
  test <- candidates %>% mutate(year_to_redo =
                                  ifelse(comps%in%as.character(winners$comps), 1, 0))
    
  names(test)[names(test) == 'year_to_redo'] <- paste0('in', unique(g$year))
   
   return(test)
  })

test <- left_join(df[[1]], df[[2]])
test <- left_join(test, df[[3]])
test <- left_join(test, df[[4]])
test <- left_join(test, df[[5]])
candidates_per_year_in_winning_team <- left_join(test, df[[6]])
candidates_per_year_in_winning_team <- mutate(candidates_per_year_in_winning_team, 
                                              type = 'candidate')

all_df <- bind_rows(winners_per_year, candidates_per_year_in_winning_team)

all_df <- select(all_df, -feats_to_remove)


all_df <- all_df %>%    mutate(intop2012 = ifelse(rank2012<11 & rank2012>0, 1, 0),
                               intop2013 = ifelse(rank2013<11 & rank2012>0, 1, 0),
                               intop2014 = ifelse(rank2014<11 & rank2012>0, 1, 0),
                               intop2015 = ifelse(rank2015<11 & rank2012>0, 1, 0),
                               intop2016 = ifelse(rank2016<11 & rank2012>0, 1, 0),
                               intop2017 = ifelse(rank2017<11 & rank2012>0, 1, 0)) 


write.csv(all_df, 'final_datasets/winners_candidates_gathered_withduplicates.csv')




n_comps <- all_df %>%  group_by(comps, type) %>% summarise(n= n() )
n_tot <- all_df %>% group_by(type) %>% summarise(n())
test <- all_df %>%  group_by(company_name) %>% distinct(comps, type, .keep_all = T)



names(all_df)


