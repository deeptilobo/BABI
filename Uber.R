getwd()

#clear the cache
rm(list=ls())

#import library
library(dplyr)

install.packages("lubridate")
library(lubridate)

#read dataset
uber = read.csv("uber.csv")

#understand and explore the data : EDA :Exploratory Data Analysis
dim(uber)
head(uber)
tail(uber)

str(uber)

#work with pickup_dt

summary(uber)

#borough = NA's         :3043

anyNA(uber)

#to get number of NA's
sapply(uber, function(x) sum(is.na(x)))

###Data preparation

#Pickup date
uber$pickup_dt = strptime(uber$pickup_dt,"%Y-%m-%d %H:%M")
class(uber$pickup_dt)
head(uber$pickup_dt)

#slp (the data had "," so replacing it with "")
uber$slp = as.numeric(gsub(",","",as.character(uber$slp)))
class(uber$slp)
head(uber$slp)

#work with date
uber$start_month = month(uber$pickup_dt)
uber$start_day = day(uber$pickup_dt)
uber$start_hour = hour(uber$pickup_dt)
uber$wday = weekdays(uber$pickup_dt)

head(uber$start_day)
head(uber$wday)

str(uber)

##Borough: classify all NA into another bucket called as "unkown"
uber$borough = as.factor(replace(as.character(uber$borough),is.na(uber$borough),"Unknown"))
summary(uber$borough)

###pickups
summary(uber$pickups)

boxplot(uber$pickups, horizontal = TRUE)
text(x = fivenum(uber$pickups), labels = fivenum(uber$pickups), y = 1.25 )
mean_val = round(mean(uber$pickups),2)

text(x=mean_val, labels = mean_val, y = 1.35)

hist(uber$pickups, breaks = 50)

##SPD
summary(uber$spd)

boxplot(uber$spd, horizontal = TRUE)
text(x = fivenum(uber$spd), labels = fivenum(uber$spd), y = 1.25 )
mean_val = round(mean(uber$spd),2)

text(x=mean_val, labels = mean_val, y = 1.35)

hist(uber$spd)

##categorical
#borough

summary(uber$borough)

plot(uber$borough)

summary(uber$hday)
plot(uber$hday)

##categorical vs numeric
#borough & pickup
library(ggplot2)
View(table(uber$borough, uber$pickups))

ggplot(uber, aes(uber$pickups)) +
  geom_histogram() +
  facet_wrap(~uber$borough)

#numeric vs numeric
plot(uber$spd, uber$pickup_dt)

plot(uber$slp, uber$pickup_dt)

plot(uber$vsb, uber$pickups)
