getwd()

#clear the cache/memory variables
rm(list=ls())

library(readxl)

#Import the xlsx
food_nutrition = read_excel("Food Nutrition.xlsx", sheet = "Sheet1")

#Find number of rows and columns by one command
dim(food_nutrition)

#only rows
row_count = nrow(food_nutrition)

#only columns
col_count = ncol(food_nutrition)

#class of dataset
class(food_nutrition)

#names of columns
colnames(food_nutrition)

#name of the rows
row.names(food_nutrition)

#structure of dataset
str(food_nutrition)
  # observations:
    # 2 - character variables
    # all others are numeric variables
    # Based on the naming conventions , we infer that some of the variables are in g, mg, ug, kcal

#find the class of a single variable
class(food_nutrition$Energ_Kcal)

#Lets find the summary of the dataset : 5 point summary of numeric/integer variable(box plot)
summary(food_nutrition)

# first 10 records of datasets
head(food_nutrition,10)
View(head(food_nutrition,10))

# create new variable/object say test_1 and store 10 records of Protein(g) column
test_1 = food_nutrition$`Protein_(g)`[1:10]

View(test_1)

#List of first 5 rows and initial 5 columns of dataset
food_nutrition[1:5,1:5]

names(food_nutrition)
#List Zinc, calcium, selenium
#create a new character variable to store the selected column names
#store it in a new dataset

selectedcolumn = c("Zinc_(mg)", "Calcium_(mg)","Selenium_(µg)")
test_2 = food_nutrition[,selectedcolumn]
View(test_2)
dim(test_2)

#remove first 5 rows from test_2 and store resultant into new dataset
test_3 = test_2[-(1:5),]

dim(test_3)

#remove 1st two columns from test_2 and store resultant into new dataset
test_4 = test_2[,-(1:2)]
dim(test_4)

#############################3
allcols = colnames(food_nutrition)
allcols

####

#create new variable(EPW) in dataset which will be ratio of water in energy
food_nutrition$EPW = food_nutrition$Energ_Kcal/food_nutrition$`Water_(g)`
dim(food_nutrition)
colnames(food_nutrition)

temp = cbind(food_nutrition[,ncol(food_nutrition)],food_nutrition[,-ncol(food_nutrition)])
colnames(temp)

#####

#create a new dataset to filter less than energy values less than 500
test_5 = food_nutrition[food_nutrition$Energ_Kcal < 500,]
View(test_5)
dim(test_5)

##
plot(food_nutrition$Energ_Kcal,food_nutrition$`Water_(g)`,
     xlab = "Energy",
     ylab = "Water",
     main = "Plot between Energy and Water")

###
library(dplyr)

dplyr::select()

Y = food_nutrition %>% arrange(desc(food_nutrition$`Protein_(g)`)) %>% head(10)

##OR

Y = head(arrange(food_nutrition,desc(food_nutrition$`Protein_(g)`)),10)

Z = food_nutrition %>% arrange(food_nutrition$`Water_(g)`) %>% head(10)
Z

####
l = food_nutrition
l$water_category = cut(food_nutrition$`Water_(g)`, breaks=6, labels = c("A","B","C","D","E","F") )
View(l)

#filter/subset the dataset where food items contain CHEESE
install.packages("data.table")
library(data.table)

temp_cheese = food_nutrition %>% filter(food_nutrition$Shrt_Desc %like% "CHEESE")
View(temp_cheese)

#sapply
##MAx of all the numeric columns
temp_sap = food_nutrition[,-c(1:2, ncol(food_nutrition))]
str(temp_sap)

sapply(temp_sap, FUN = max)

#average
sapply(temp_sap, FUN = mean)

#SD
sapply(temp_sap, FUN = sd)

#rpivotTable
library(rpivotTable)
