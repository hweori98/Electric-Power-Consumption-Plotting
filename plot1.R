library(base)
library(utils)
library(grDevices)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("./household_power_consumption.zip")
filename <- "./household_power_consumption.txt"
electric <- read.table(filename, header = TRUE, fill = FALSE, sep = ";")
electric2day <- electric 
electric2day$Date <- as.Date(electric$Date, "%d/%m/%Y")
electric2day <- subset(electric2day, Date == as.Date("2007-02-02") | Date == as.Date("2007-02-01"))
png("plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(electric2day$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
dev.off()
