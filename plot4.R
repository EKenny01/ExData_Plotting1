## Plot 3

# Read the data into an R object
powerData <- read.csv("household_power_consumption.txt", 
                      header = TRUE, sep = ";", stringsAsFactors = FALSE)


# Convert the date and time to a single datetime - I could only subset on 
# the dates when they were in POSIXct
try1 <- paste(powerData$Date, powerData$Time)
powerData$DateTime <- strptime(try1, format = "%d/%m/%Y %H:%M:%S")
powerData$DateTime <- as.POSIXct(powerData$DateTime)

# Convert date strings to dates - ensure dates are in POSIXct format
powerData$Date <- dmy(as.character(powerData$Date))
powerData$Date <- as.Date(dateTry, format = "%d/%m/%Y")
powerData$Date <- as.POSIXct(powerData$Date, format = "%Y-%m-%d")

# Convert other strings to numeric values so values can be plotted
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)
powerData$Voltage <- as.numeric(powerData$Voltage)
powerData$Global_intensity <- as.numeric(powerData$Global_intensity)
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)

# Subset the data based on the two days in question
subset1 <- filter(powerData, Date == "2007-02-01")
subset2 <- filter(powerData, Date == "2007-02-02")
powerSubset <- rbind(subset1, subset2)
str(powerSubset)

# The following code creates the png plot with the correct dimensions
png(file = "plot4.png", width = 480, height = 480)

par(mfrow =c(2,2))

#Upper left plot - Plot 2
plot(powerSubset$DateTime, powerSubset$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = " ")

#Upper right plot
plot(powerSubset$DateTime, powerSubset$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

#Lower Left plot - Plot 3
plot(powerSubset$DateTime, powerSubset$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = " ", ylim = c(0,30))

par(new=TRUE)

plot(powerSubset$DateTime, powerSubset$Sub_metering_2, col = "red",
     type = "l", xlab = "", ylab = "", axes = FALSE, ylim = c(0,30))

par(new=TRUE)

plot(powerSubset$DateTime, powerSubset$Sub_metering_3, col = "blue",
     type = "l", xlab = "", ylab = "", axes = FALSE, ylim = c(0,30))

legend("topright",lty = c(1, 1, 1),col=c("black","red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n")

#Lower right plot
plot(powerSubset$DateTime, powerSubset$Global_reactive_power,
     type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#The following code turns off the device to plot to png file
dev.off()