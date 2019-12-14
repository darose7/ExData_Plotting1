#load relevant packages
library(lubridate)
library(plyr)
library(dplyr)
#Read in the data
power_data <- read.delim("household_power_consumption.txt",
                          header =TRUE,sep =";",stringsAsFactors = FALSE)
#Change the "date" variable to date class
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")
#Filter the relevant dates
myData <- power_data[power_data$Date == "2007-02-02" | 
                            power_data$Date == "2007-02-01",]
#Create 'DateTime' variable and change class to POSIXct
myData <- transform(myData,DateTime = paste(Date,Time))
myData$DateTime <- as.POSIXct(myData$DateTime)
#Change character vectors to numeric vectors
indx <- sapply(myData, is.character)
myData[indx] <- lapply(myData[indx],
                             function(x) as.numeric(x))
#Plot graph in png file
png(file = "plot1.png")
hist(myData$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0,1200),xlim = c(0,6), lab = c(3,5,7))
dev.off()