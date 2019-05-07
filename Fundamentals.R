##Assignments

x = 1

y<-2

z = "Hello"

w = 'Hello'

##Functions

print("Hello World")

## Computation
17 + 5

x + 5

y = 15 + 5

y = sqrt(16)

## vectors
my_vector = c(14, 26, 38,30)
my_vector1 = c('Hi', 'Hello', 'Cia','Mia')
my_vector2 = c(14, 26, 38,'Hello')

my_vector[3]

##Matrix

my_matrix = matrix(my_vector, nrow = 2, ncol = 2)
my_matrix1 = matrix(1:9, nrow = 3, ncol = 3)

my_matrix1

my_matrix1[2,3]
my_matrix1[2,]
my_matrix1[,2]

my_matrix1[1:2,1:2]

my_matrix1[-3,-3]

##Data Frames

my_dataframe = data.frame(my_vector, my_vector2)

my_dataframe$my_vector
my_dataframe[,1]

my_dataframe[1:3,]

## Lists

my_list = list(my_vector, my_matrix, my_dataframe, my_vector2)

my_list

my_list[[3]]
my_list[[3]][1,]

###Import .Txt with space seperated values

titanic = read.table("Titanic_space_separated-1.txt", header = TRUE) 
class(titanic)

#To see data
View(titanic)
head(titanic,10)
tail(titanic,5)

#See overview
str(titanic)

titanic$Sex = as.character(titanic$Sex)

summary(titanic)

titanic$Sex = as.factor(titanic$Sex)

###Import .Txt with coma seperated values

Orange = read.table("Orange_comma_separated.txt", header = TRUE, sep = ",")

class(Orange)

summary(Orange)

Orange$Tree = as.factor(Orange$Tree)

###Import .cvs file
library(readr)

Countries = read.csv("Countries+Population.csv")

summary(Countries)

Countries$Country.Name = as.factor(Countries$Country.Name)
Countries$Country.Code = as.factor(Countries$Country.Code)

colnames(Countries) = make.names(colnames(Countries))

###Import excel file

install.packages("readxl")
library(readxl)

Countries_Region = read_excel("Countries Region Mapping.xlsx")

class(Countries_Region)
Countries_Region = as.data.frame(Countries_Region)
summary(Countries_Region)
str(Countries_Region)
summary(Countries_Region$IncomeGroup)
class(Countries_Region$IncomeGroup)

Countries_Region$IncomeGroup = as.factor(Countries_Region$IncomeGroup)
Countries_Region$Region = as.factor(Countries_Region$Region)
Countries_Region$Country.Code = as.factor(Countries_Region$Country.Code)

##Data Manipulation

##Get info about functions
?colnames
?make.names

##Give data frame's columns proper names
colnames(Countries) = make.names(colnames(Countries))

colnames(Countries)

#Set columns in right format
Countries$Country.Name = as.factor(Countries$Country.Name)
Countries$Country.Code = as.factor(Countries$Country.Code)

#summary
summary(Countries)

##Filtering/Subsetting

# Focus on first rows
First.Countries.Pop = head(Countries$Total.Population.2017)
First.Countries.Pop

# Create logical vector
Big.First.Countries.Flag = First.Countries.Pop > 10000000 ##Condition: More than 10 million
Big.First.Countries.Flag

# Use logical statement to filter data
Countries[Countries$Total.Population.2017 > 10000000,]
Big.Countries = Countries[Countries$Total.Population.2017 > 10000000,] ##Condition: More than 10 million

Small.Countries = Countries[Countries$Total.Population.2017 <= 2000000,] ##Condition: Less or equal to 2 million

## 2 logical conditions

# AND
Big.and.Small.Countries = Countries[Countries$Total.Population.2017 <= 10000000 & 
                                      Countries$Total.Population.2017 > 2000000,]

# OR
Big.and.Small.Countries = Countries[Countries$Total.Population.2017 > 10000000 | 
                                      Countries$Total.Population.2017 <= 2000000,]

### Binding

##Appending Datasets
Big.and.Small.Countries2 = rbind(Big.Countries, Small.Countries)

##Binding Columns
Big.Country.Flag = Big.and.Small.Countries2$Total.Population.2017 > 10000000

Big.and.Small.Countries2 = cbind(Big.and.Small.Countries2, Big.Country.Flag)

View(Big.and.Small.Countries2)

Summary(Big.and.Small.Countries2)

###Transforming

#Have total population expressed in millions
Countries$Population.2017.Millions = Countries$Total.Population.2017 /1000000

#Logarithm
Countries$Random.Pop.Trnasform = log(Countries$Total.Population.2017)
head(Countries$Random.Pop.Trnasform)

#Revert back with exponential
Countries$Random.Pop.Trnasform = exp(Countries$Random.Pop.Trnasform)
head(Countries$Random.Pop.Trnasform)

#### Sorting

# Sort Countries in ascending order of population
Countries = Countries[order(Countries$Total.Population.2017),]
View(Countries)

# Sort Countries in descending order of population
Countries = Countries[order(-Countries$Total.Population.2017),]
View(Countries)

##Set to ordered factor, and give order.
Countries_Region$IncomeGroup = ordered(Countries_Region$IncomeGroup, levels = c("Low income","Lower middle income",
                                                                                "Upper middle income", "High income"))

Countries_Info = read.csv("Countries+Indicators.csv")
summary(Countries_Info)
Countries_Info$Country.Code = as.factor(Countries_Info$Country.Code)

class(Countries_Region$Country.Code)

###Merging data sets together

#Left Join
temp = merge(Countries,Countries_Region, by = "Country.Code", all.x = TRUE)

#Correct inner join
Countries_All = merge(Countries, Countries_Region, by = "Country.Code")

#Full outer join
temp2 = merge(Countries_All, Countries_Info, by = "Country.Code", all = TRUE)

#correct left join
Countries_All = merge(Countries_All, Countries_Info, by = "Country.Code", all.x = TRUE)

##Remove unwanted objects from global environment
rm(temp,temp2)

###Summary Tables

##table()
Region_vs_Income_Cat = table(Countries_All$Region,Countries_All$IncomeGroup)
Region_vs_Income_Cat

prop.table(Region_vs_Income_Cat,1) #Row total is 1

prop.table(Region_vs_Income_Cat,2) #Column total is 1

## %>% group_by()

install.packages("dplyr")
library(dplyr)

#Extract different regions
Region_sum = Countries_All %>% group_by(Region) %>% summarise()
View(Region_sum)

#Extract different combinations of Region and Income Group
Region_Income_sum = Countries_All %>% group_by(Region, IncomeGroup) %>% summarise()
View(Region_Income_sum)

# same with amount of countries in each categories
Region_Income_sum = Countries_All %>% group_by(Region, IncomeGroup) %>% summarise(Number.of.Countries = n())
View(Region_Income_sum)

#Amount of different income groups per region
Region_sum = Countries_All %>% group_by(Region) %>% summarise(Different.Income.Groups = n_distinct(IncomeGroup))
View(Region_sum)

##Big summary about each region
Region_sum = Countries_All %>% group_by(Region) %>% summarise(Number.of.Countries = n(),
                                                              Total.Population.In.Million = sum(Total.Population.2017)/1000000,
                                                              Countries.With.Low.Income = sum(IncomeGroup == "Low Income"),
                                                              Average.GDP.per.Capita = mean(GDP.per.capita.2017, na.rm = TRUE),
                                                              Median.GDP.per.Capita = median(GDP.per.capita.2017, na.rm = TRUE),
                                                              Std.Deviation.GDP.per.Capita = sd(GDP.per.capita.2017, na.rm = TRUE),
                                                              Min.Under.5.Mortality.Rate = min(Under.5.Mortality.Rate.2017, na.rm = TRUE),
                                                              Max.Under.5.Mortality.Rate = max(Under.5.Mortality.Rate.2017, na.rm = TRUE))    

View(Region_sum)

###Exporting Data

#AS CSV file
write.csv(Countries_All, "As_Country_Summary_2019.csv", row.names = FALSE)

#As RDS object
saveRDS(Countries_All,"As_Country_Summary_2019.RDS")

#Re import RDS
Countries_All2 = readRDS("As_Country_Summary_2019.RDS")


##Plots

#Import ggplot2 package for plots
install.packages("ggplot2")
library(ggplot2)

##Numberic Distribution
qplot(GDP.per.capita.2017, data = Countries_All)

#Add title and labels
qplot(GDP.per.capita.2017, data = Countries_All,
      main = "GDP per capita Distribution in 2017",
      xlab = "GDP per Capita",
      ylab = "Frequency")

#Save plot as global environment
p = qplot(GDP.per.capita.2017, data = Countries_All,
          main = "GDP per capita Distribution in 2017",
          xlab = "GDP per Capita",
          ylab = "Frequency")

#Call object
p

#Density
qplot(GDP.per.capita.2017, data = Countries_All, geom = "density",
      main = "GDP per capita Distribution in 2017",
      xlab = "GDP per Capita",
      ylab = "Density")

##Categorical distribution

#Default: Bar plot
qplot(Region, data = Countries_All,
      main = "Region Distribution",
      xlab = "Region",
      ylab = "Frequency")

##Numerical against Categorical

#Default: Dot Plot
qplot(Region, Under.5.Mortality.Rate.2017, data = Countries_All,
      main = "Mortality Rate Distribution per Region",
      xlab = "Region",
      ylab = "Under 5 Mortality Rate")

#Box Plot
qplot(Region, Under.5.Mortality.Rate.2017, data = Countries_All, geom = "boxplot",
      main = "Mortality Rate Distribution per Region",
      xlab = "Region",
      ylab = "Under 5 Mortality Rate")

#Coloured density plot
qplot(Region, Under.5.Mortality.Rate.2017, fill = Region, data = Countries_All, geom = "density", alpha = I(.8),
      main = "Mortality Rate Distribution per Region",
      xlab = "Under 5 Mortality Rate",
      ylab = "Density")

##Categorical against categorical

#Colored Bar Plot
qplot(Region, fill = IncomeGroup, data = Countries_All, geom = "bar",
      main = "Income Group Distribution per Region",
      xlab = "Region",
      ylab = "Frequency")

#Numerical against numerical

#Default: Dot Plot
qplot(GDP.per.capita.2017, Under.5.Mortality.Rate.2017, data = Countries_All,
      main = "Mortality Rate Distribution against Countries' GDP per Capita in 2017",
      xlab = "GDP per Capita",
      ylab = "Under 5 Mortality Rate")

##Three variables

#Colored Dot Plot
qplot(GDP.per.capita.2017, Under.5.Mortality.Rate.2017, color = Region, data = Countries_All,
      main = "Mortality Rate Distribution against Countries' GDP per Capita in 2017",
      xlab = "GDP per Capita",
      ylab = "Under 5 Mortality Rate")

##Export Plots

#Save last plot into an image
ggsave("GDP_per_capita_Distribution.jpeg", width = 9, height = 6)


#Save any plot from the global environment as an image.
ggsave("GDP_per_capita_Distribution1.jpeg", p, width = 9, height = 6)
