library(dplyr)
#Checks for data directory and creates one if it isn't there.
if(!dir.exists("data"))
  dir.create("data")

#imports the data.
power <- read.table("data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)

#Filters the dates.
power <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")

#Formats the dates.
power <- power %>% mutate(Date = as.Date(Date, format="%d/%m/%Y"), Time = format(Time, format = "%H:%M:%S"))

#Creates a new DateTime column with strptime using the existing Date and Time columns.
power$DateTime <- strptime(paste(power$Date, power$Time), format = "%Y-%m-%d %H:%M:%S")

#Creates the plot and saves it to a png.
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(power, {
  plot(DateTime, Global_active_power, type = "lines", xlab = "", ylab = "Global Active Power")
  plot(DateTime, Voltage, type = "lines")
  plot(power$DateTime, power$Sub_metering_1, type = "lines", xlab = "", ylab = "Energy sub metering")
  lines(power$DateTime, power$Sub_metering_2, col = "red")
  lines(power$DateTime, power$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty= 1, bty = "n")
  plot(DateTime, Global_reactive_power, type = "lines")
})
dev.off()
