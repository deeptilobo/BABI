## Import data
mydata = read.csv("CardioGoodFitness.csv",header = TRUE)
mydata

#To store mydata as a variable, we need to attach. This avoids use of mydata$age
attach(mydata)

summary(mydata)

#To filter summary product and gender wise
by(mydata,INDICES = Product,FUN = summary)
by(mydata,INDICES = Gender,FUN = summary)

#pattern recongnization
hist(Age, col = "Red")
boxplot(Age,horizontal = TRUE, col = "Red", main = "Boxplot of Age")

#Age is a function of gender
boxplot(Age~Gender, horizontal = TRUE, col = c("Red","Blue"), main = "Comparative Boxplot of Age Based on Gender")
boxplot(Age~Product, horizontal = TRUE, col = c("Red","green","blue"))

table(Product,Gender)
table(Product,MaritalStatus)

install.packages("rpivotTable")
library(rpivotTable)
rpivotTable(mydata)

sd(Age)
mean(Age)

install.packages("lattice")
library(lattice)

histogram(~Miles|factor(Gender),data = mydata)
histogram(~Miles|factor(Product),data = mydata)

#corelation
cor(Miles,Usage)

#predictive linear model
Model=lm(Miles~Usage,data = mydata)
summary(Model)

cor(Miles,Fitness)
Model=lm(Miles~Usage+Fitness, data = mydata)
summary(Model)

x<-c(3,6,4,11)
sd(x)
install.packages("rgl")
library(rgl)
install.packages("readr")
library(readr)
