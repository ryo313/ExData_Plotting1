# download data
library(dplyr)
library(openxlsx)
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=fileUrl1, destfile="elec.zip", method="curl")
unzip("elec.zip")

# read data (start from here if you have already downloaded)
DT <- fread("household_power_consumption.txt",header = TRUE, 
            skip = 66636, nrows = 2880, na.strings = "?", col.names 
            = c("Date", "Time", "Global_active_power","Global_reactive_power", 
                "Voltage", "Global_intensity", "Sub_metering_1", 
                "Sub_metering_2", "Sub_metering_3")) 
DT$Date <- paste(DT$Date, DT$Time) %>% dmy_hms() 

# plot 1
hist(DT$Global_active_power, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", col = "red", main = "Global Active Power")
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()