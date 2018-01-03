
library(base)
library(utils)
library(grDevices)

#downloading data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")

#unzipping and loading it into R
unzip("./household_power_consumption.zip")
filename <- "./household_power_consumption.txt"
electric <- read.table(filename, header = TRUE, fill = FALSE, sep = ";")
electric2day <- electric

#cleaning the data to pertinent part and in format ready to plot
electric2day$Date <- as.Date(electric2day$Date, "%d/%m/%Y")
electric2day <- subset(electric2day, 
                      Date == as.Date("2007-02-02") | Date == as.Date("2007-02-01"))
electric2day$Global_active_power <- as.numeric(as.character(electric2day$Global_active_power))

#creating additional variable combining date and time in the right class
electric2day$DateTime <- as.POSIXct(paste(electric2day$Date, electric2day$Time),
                                    "%Y-%m-%d %H:%M:%S",tz = "")

#producing png file with the plot
png("plot4.png", width = 480, height = 480)

##setting layout of plots
par(mfrow=c(2,2))

##1st plot in the set
plot(electric2day$DateTime, electric2day$Global_active_power
     , type = "l"
     , ylab = "Global Active Power"
     , main = ""
     , xlab = "")

##2nd plot in the set
electric2day$Voltage <- as.numeric(as.character(electric2day$Voltage))
with(electric2day
     , plot(DateTime, Voltage
            , type = "l"
            , ylab = "Voltage"
            , xlab = "datetime"
            , yaxt = "n"))
axis(side = 2
     , at = c(234, 236, 238, 240, 242, 244, 246)
     , labels = c("234", "", "238", "", "242", "", "246"))

##3rd plot in the set
electric2day$Sub_metering_2 <- as.numeric(
                                          as.character(
                                                    electric2day$Sub_metering_2))
with(electric2day
     , plot(DateTime, Sub_metering_1
            , type = "l"
            , ylab = "Energy sub metering"
            , xlab = ""
            , yaxt = "n"))
axis(side = "2", at = c(0,10,20,30))
lines(electric2day$DateTime, electric2day$Sub_metering_2, col = "red")
lines(electric2day$DateTime, electric2day$Sub_metering_3, col = "blue")
legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col=c("black", "red", "blue")
       , lty = 1, bty = "n")


##4th plot in the set
electric2day$Global_reactive_power <- as.numeric(as.character(electric2day$Global_reactive_power))
with(electric2day
     , plot(DateTime, Global_reactive_power
            , xlab = "datetime"
            , type = "l"))


dev.off()