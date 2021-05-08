
getwd()

stormy <-read.csv("storm88.csv", header = TRUE, sep = ",")

#downloaded tidyverse to my system so that challenges can be solved.
library(tidyverse)

#I used the following two codes to extract rows I was interested in  
head(storms, 4)

storms %>%
  select(1:4) %>% 
  slice(1:4) 
package = "dbplyr"

# select variables 
df= subset(stormy, select = c (BEGIN_DAY, END_DAY, BEGIN_TIME, END_TIME, EPISODE_ID, EVENT_ID, 
              STATE, STATE_FIPS, CZ_TYPE, CZ_NAME, CZ_FIPS, EVENT_TYPE,
              SOURCE, BEGIN_LAT, BEGIN_LON, END_LAT, END_LON))

head(df)

#was not able to run the mutate function

#Converting State and county names 

library(stringr)
df$STATE <-str_to_title(df$STATE)
df$CZ_NAME <-str_to_title(df$CZ_NAME)

#filter variables and remove CZ_TYPE varaible

library(dplyr)

df %>% filter(grepl('C', CZ_TYPE))

df %>% select(- CZ_TYPE)

#State and county FIPS begin with 0

 str_pad(df$STATE_FIPS, width=3, side = "left", pad = "0")
 str_pad(df$CZ_FIPS, width=4, side = "left", pad = "0")

 
 #unite state and county FIPS
 
 unite_(df, "FIPS", c("STATE_FIPS","CZ_FIPS"))
 
 #make all column names lower case
 
 rename_all(df, tolower)
 
 #used to create  create a dataframe with the state name, area, and region
 data("state")
 
 us_state_info<- data.frame(state=state.name, region=state.region, area=state.area)
  
#number of events per state in the year 1988
table(df$STATE)
newset <- data.frame(table(df$STATE))

head(newset)

#Merge state info into newset that was created, first rename state varibale

newset1<-rename(newset, c("state"="Var1"))

merged <- merge(x=newset1, y=us_state_info, by.x="state", by.y="state")

head(merged)

#PLOT

library(ggplot2)

storm_plot <- ggplot(merged, aes(x = area, y = Freq)) + 
  geom_point(aes(color = region)) +
  labs(x = "Land area (square miles)")
      (y = "# of storm events in 1988")

print(storm_plot)













 