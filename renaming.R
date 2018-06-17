#####
library(dplyr)
library(tidyr)
library(ggplot2)

setwd('Documents/hackandlead/swissteamchallenge/')


winners <- read.csv('final_datasets/winner_startups_in_database_MOREINFO.csv')
candidates <- read.csv('final_datasets/candidates_startups_in_database_MOREINFO.csv')

winners_sbs <- select(winners, comps, company_name, investor_name,
                      investor_uuids,
                      country_code, roles.x, founded_on.x,
                      closed_on.x,
                      region, city, investor_type, 
                      funding_rounds,
                      investment_count, 
                      announced_on,
                      investors_name,
                      investor_uuid,
                      raised_amount, raised_amount_usd, 
                      raised_amount_currency_code, 
                      post_money_valuation_usd,
                      post_money_valuation,
                      post_money_currency_code,
                      total_funding_usd, founded_on.x, 
                      state_code.x,
                      founded_on.y,
                      roles.y, country_code.x, closed_on.y,
                      region.x, city.x, last_funding_on, Aquired., year,
                      Rank,  type, Description, 
                      employee_count,
                      primary_role,  
                      country_code.y, state_code.y, region.y, city.y)


winners_sbs <- rename(winners_sbs, 
                      country_code_investor = country_code,
                      region_investor = region, 
                      city_investor = city,
                      role_investor = roles.x, 
                      founded_on_investor = founded_on.x, 
                      closed_on_investor = closed_on.x,
                      roles_company = roles.y,
                      country_code_company = country_code.x,
                      state_code_company= state_code.x, 
                      city_company= city.x,
                      region_company = region.x,
                      founded_on_company = founded_on.y,
                      closed_on_company = closed_on.y,
                      country_code_investment = country_code.y,
                      state_code_inverstment = state_code.y,
                      region_investment = region.y,
                      city_investment = city.y)
                      
                      
write.csv(winners_sbs, 'final_datasets/winners_in_database_reformatted.csv')
                      
                      
candidates <- select(candidates, comps, Company, company_name, investor_name,
                      investor_uuids,
                      country_code, roles.x, founded_on.x,
                      closed_on.x,
                      region, city, investor_type, 
                      investment_count, 
                      funding_rounds,
                      announced_on,
                      investors_name,
                      investor_uuid,
                      raised_amount, raised_amount_usd, 
                      raised_amount_currency_code, 
                      post_money_valuation_usd,
                      post_money_valuation,
                      post_money_currency_code,
                      total_funding_usd, founded_on.x, 
                      state_code.x,
                      founded_on.y, City, Technology, Uni.spin.off, Incorporation.Date,
                      Number.of.Employees, X1Liner, Description, 
                      roles.y, country_code.x, closed_on.y,
                      region.x, city.x, last_funding_on, 
                      type, Description, 
                      employee_count,
                      primary_role,  
                      country_code.y, state_code.y, region.y, city.y)


candidates_sbs <- rename(candidates, 
                      country_code_investor = country_code,
                      region_investor = region, 
                      city_investor = city,
                      role_investor = roles.x, 
                      founded_on_investor = founded_on.x, 
                      closed_on_investor = closed_on.x,
                      roles_company = roles.y,
                      country_code_company = country_code.x,
                      state_code_company= state_code.x, 
                      city_company= city.x,
                      region_company = region.x,
                      founded_on_company = founded_on.y,
                      closed_on_company = closed_on.y,
                      country_code_investment = country_code.y,
                      state_code_inverstment = state_code.y,
                      region_investment = region.y,
                      city_investment = city.y)


write.csv(candidates_sbs, 'final_datasets/candidates_in_database_reformatted.csv')

                      
                      

winners_sbs_wide <- winners_sbs %>% group_by(company_name) %>% distinct(.keep_all = T) %>% 
  spread(year, Rank)


winners_sbs_wide <- winners_sbs_wide %>% rename(in2012 = '2012', in2013 = '2013', in2014 = '2014', in2015 = '2015', 
                        in2016 = '2016', in2017 = '2017')

winners_sbs_wide <- winners_sbs_wide %>% mutate(in2012 = ifelse(is.na(in2012), 0, in2012),
                        in2013 = ifelse(is.na(in2013), 0, in2013),
                        in2014 = ifelse(is.na(in2014), 0, in2014),
                        in2015 = ifelse(is.na(in2015), 0, in2015),
                        in2016 = ifelse(is.na(in2016), 0, in2016),
                        in2017 = ifelse(is.na(in2017), 0, in2017))

write.csv(winners_sbs_wide, 'final_datasets/winners_in_database_reformatted_wideformat.csv')

