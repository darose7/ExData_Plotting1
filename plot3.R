#Load relevant packages
library(lubridate)
library(plyr)
library(dplyr)

#Read the data
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
#Plot the graph into a pdf
pdf(file = "plot3.pdf")
x <- c(myData$DateTime,myData$DateTime,myData$DateTime)
y <- c(myData$Sub_metering_1,
       myData$Sub_metering_2,
       myData$Sub_metering_3)
plot(x,y,type = "n",ylab = "Energy sub metering"
     ,xlab = "")
lines(myData$DateTime,myData$Sub_metering_1
      , type ="s", col = "black")
lines(myData$DateTime,myData$Sub_metering_2
      , type ="s", col = "red")
lines(myData$DateTime,myData$Sub_metering_3
      , type ="s", col = "blue")
legend(x = "topright", 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1,cex = .75)
dev.off()