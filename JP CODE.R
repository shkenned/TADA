library(pdftools)
library(stringr)
library(tm)
library(textreadr)
library(tidyverse)
library(pdfsearch)
library(xlsx)
library(rvest)

#downsize sponsored bills
sponsored_bills <- read_delim("Downloads/sponsored_bills.csv",";", escape_double = FALSE, trim_ws = TRUE)
new1 <- subset.data.frame(sponsored_bills, sponsored_bills$report_year == "2015")
new_sponsored_bills <- na.omit(new1, Var = c("congress_id_handles.Tweetcongress"))
write.csv(new_sponsored_bills,"Downloads/new_sponsored_bills", row.names = FALSE)

#downsize lobbying contributions file
dataset_report_level <- read_csv("Downloads/dataset___report_level.csv")
money1 <- subset.data.frame(dataset_report_level, dataset_report_level$report_year == "2015") 
money2 <- subset.data.frame(money1, money1$amount != "$0.00")
write.csv(money2,"Downloads/new_dataset_report_level", row.names = FALSE)

#merge amount with congressmen dataset 
TADA_data <- merge(x = money2, y = new_sponsored_bills, by = "client_uuid", all = FALSE)
write.csv(TADA_data,"Downloads/TADA_data", row.names = FALSE)

#merge with issue codes, this will be the FINAL dataset on the lobby side we will need. 
TADA_data2 <- merge(x = TADA_data, y = dataset_issue_level_1_, by = "report_uuid", all.x = TRUE)
write.csv(TADA_data,"Downloads/TADA_data", row.names = FALSE)


#add up total lobby for each congressmen
#TADA_data$amount <- as.numeric(as.character(TADA_data$amount)) #makes them all NA's
#congressmen_totals <- TADA_data %>% group_by(client_uuid) %>% sum(TADA_data$amount)
  

  
