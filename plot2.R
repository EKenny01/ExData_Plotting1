### plot2

# Read the data into an R object
powerData <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)


# Convert the date and time to a single datetime - I could only subset on the dates
# if the date format is POSIXct
try1 <- paste(powerData$Date, powerData$Time)
powerData$DateTime <- strptime(try1, format = "%d/%m/%Y %H:%M:%S")
powerData$DateTime <- as.POSIXct(powerData$DateTime)

# Convert date strings to dates - ensure dates are in POSIXct format
#dateTry <- as.character(powerData$Date)
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
# 
subset1 <- filter(powerData, Date == "2007-02-01")
subset2 <- filter(powerData, Date == "2007-02-02")
powerSubset <- rbind(subset1, subset2)
str(powerSubset)

# The following code creates the png plot with the correct dimensions
png(file = "plot2.png", width = 480, height = 480)                        

# Plot 

plot(powerSubset$DateTime, powerSubset$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = " ")

#The following code turns off the device to plot to png file
dev.off()