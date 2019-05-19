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
png(filename = "Plot2.png", width = 480, height = 480)
plot(power$DateTime, power$Global_active_power, type = "lines", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()