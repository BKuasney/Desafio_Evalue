setwd("C:/Users/bkuasney/Desktop/ML/EVALUE")

salesOrder = read.csv2("SalesOrder.csv", sep=',')
str(salesOrder)
names(salesOrder)

territory = read.csv2("Territory.csv", sep=',')
str(territory)
names(territory)

require(sqldf)
salesOrder = sqldf('select * from salesOrder left join territory using(TerritoryID)', drv = 'SQLite')
names(salesOrder)


# TRAT 1
salesOrder_trat = salesOrder[,c(2,3,9,10,11,12)]
head(salesOrder_trat)
distinct(salesOrder_trat, Name)
names(salesOrder_trat)
salesOrder_trat = salesOrder_trat[,1:4]
names(salesOrder_trat)


# TRAT 2
salesOrder_trat2 = sqldf('select OrderDate, CustomerID, sum(TotalDue) as total, Name from salesOrder_trat group by OrderDate, CustomerID, Name', drv='SQLite')
str(salesOrder_trat2)
library(lubridate)
salesOrder_trat2$OrderDate = mdy(salesOrder_trat2$OrderDate, locale="en_US.UTF-8")
str(salesOrder_trat2$OrderDate)


date = "2006-02-02"
territory = "Germany"
distinct(salesOrder_trat2, OrderDate, Name)

customer_spend = function(date,territory) {
  subset(salesOrder_trat2[order(salesOrder_trat2$total),], OrderDate == date & Name == territory)
}



customer_spend("2006-02-02","Germany")



ex2 = salesOrder_trat2

ex2$month = paste()
mdy(ex2$OrderDate, locale="en_US.UTF-8")











