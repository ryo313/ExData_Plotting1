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

# plot 4
par(mfrow = c(2,2))
with(DT, {
        plot(Date, Global_active_power,  type = "l", 
             xlab = "", ylab = "Global Active Power (kilowatts)")
        plot(Date, Voltage, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Date,  type = "l", 
             xlab = "", ylab = "Energy sub metering" )
        lines(Sub_metering_2~Date, col = "Red")
        lines(Sub_metering_3~Date, col = "Blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"),
               bty = "n", cex = 0.6, y.intersp = 0.7, 
               legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
        plot(Date, Global_reactive_power, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

