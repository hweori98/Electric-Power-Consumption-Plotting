
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

#producing png file
png("plot2.png", width = 480, height = 480)

plot(electric2day$DateTime, electric2day$Global_active_power,
     type = "l", ylab = "Global Active Power (kilowatts)", main = "", xlab = "")

dev.off()
