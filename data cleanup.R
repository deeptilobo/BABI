setwd("D:/imp_doc/BABI/Tableau/Project")
getwd()

library(readxl)
car_ins = read_excel("Car claims for insurance (1).xlsx")

View(car_ins)

car_ins$INCOME = as.numeric(gsub('[$]','',car_ins$INCOME))
car_ins$HOME_VAL = gsub('[$]','',car_ins$HOME_VAL)
car_ins$BLUEBOOK = gsub('[$]','',car_ins$BLUEBOOK)
car_ins$OLDCLAIM = gsub('[$]','',car_ins$OLDCLAIM)
car_ins$CLM_AMT =  as.numeric(gsub('[$]','',car_ins$CLM_AMT))

car_ins$CLM_AMT =  as.numeric(gsub("[^0-9.,]", "", car_ins$CLM_AMT))

library(xlsx)
install.packages("xlsx")
write.xlsx(car_ins,"D:/imp_doc/BABI/Tableau/Project/car_insurance.xlsx")
str(car_ins)

#Is there any values missing?
anyNA(car_ins)

colSums(is.na(car_ins))

nrow(mydata[is.na(car_ins), ])

##income
income = car_ins$INCOME

income <- gsub('[$]','',income)
income <- as.numeric(gsub(',','',income))
car_ins$INCOME = income

##home_val
HOME_VAL = car_ins$HOME_VAL

HOME_VAL <- gsub('[$]','',HOME_VAL)
HOME_VAL <- as.numeric(gsub(',','',HOME_VAL))
car_ins$HOME_VAL = HOME_VAL

##bluebook
BLUEBOOK = car_ins$BLUEBOOK

BLUEBOOK <- gsub('[$]','',BLUEBOOK)
BLUEBOOK <- as.numeric(gsub(',','',BLUEBOOK))
car_ins$BLUEBOOK = BLUEBOOK

##oldclaim
OLDCLAIM = car_ins$OLDCLAIM

OLDCLAIM <- gsub('[$]','',OLDCLAIM)
OLDCLAIM <- as.numeric(gsub(',','',OLDCLAIM))
car_ins$OLDCLAIM = OLDCLAIM

##CLM_AMT
CLM_AMT = car_ins$CLM_AMT

CLM_AMT <- gsub('[$]','',CLM_AMT)
CLM_AMT <- as.numeric(gsub(',','',CLM_AMT))
car_ins$CLM_AMT = CLM_AMT

#mstatus
MSTATUS = car_ins$MSTATUS
MSTATUS <- gsub('[z_]','',MSTATUS)
car_ins$MSTATUS = MSTATUS

#GENDER
GENDER = car_ins$GENDER
GENDER <- gsub('[z_]','',GENDER)
car_ins$GENDER = GENDER

#OCCUPATION
OCCUPATION = car_ins$OCCUPATION
OCCUPATION <- gsub('[z_]','',OCCUPATION)
car_ins$OCCUPATION = OCCUPATION

#CAR_TYPE
CAR_TYPE = car_ins$CAR_TYPE
CAR_TYPE <- gsub('[z_]','',CAR_TYPE)
car_ins$CAR_TYPE = CAR_TYPE

#URBANICITY
URBANICITY = car_ins$URBANICITY
URBANICITY <- gsub('[z_]','',URBANICITY)
car_ins$URBANICITY = URBANICITY

#EDUCATION
EDUCATION = car_ins$EDUCATION
EDUCATION <- gsub('[z_]','',EDUCATION)
car_ins$EDUCATION = EDUCATION

#EDUCATION
EDUCATION = car_ins$EDUCATION
EDUCATION <- gsub('[<]','Less Than ',EDUCATION)
car_ins$EDUCATION = EDUCATION

#CAR_AGE
CAR_AGE = car_ins$CAR_AGE
CAR_AGE <- gsub('[-]','',CAR_AGE)
CAR_AGE <- as.numeric(gsub(',','',CAR_AGE))
car_ins$CAR_AGE = CAR_AGE
        