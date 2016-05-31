# Function to load the data
load.data <- function(url) {
    # Read just the first 70000 rows, that is garanteed to have
    # the data to be analyzed, for performance reasons
    rawData <- read.csv2(url, dec = ".", colClasses = c("character", 
                                                        "character", "numeric", "numeric", "numeric", 
                                                        "numeric", "numeric", "numeric", "numeric"),
                         na.strings = "?", nrows = 70000)
    
}

# Function to plot the graph
plot4 <- function(data) {
    png(file = "plot4.png", width = 480, height = 480, units = "px")
    # Set four charts in one plot
    par(mfrow = c(2, 2))
    
    # Plot the charts
    plot4.1(data)
    plot4.2(data)
    plot4.3(data)
    plot4.4(data)
    dev.off()
    
}

plot4.1 <- function(data) {
    plot(data$Date, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
}

plot4.2 <- function(data) {
    plot(data$Date, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
}

plot4.3 <- function(data) {
    plot(data$Date, data$Sub_metering_1, type = "l", xlab = "", 
         ylab = "Energy sub metering", col = "black")
    lines(data$Date, data$Sub_metering_2, type = "l", col = "red")
    lines(data$Date, data$Sub_metering_3, type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
}

plot4.4 <- function(data) {
    plot(data$Date, data$Global_reactive_power, xlab = "datetime", 
         ylab = "Global_reactive_power", type = "l")
}

# Configure the system to English Language
Sys.setlocale(category = "LC_ALL", locale = "english")

# Set the url of the data
url <- "household_power_consumption.txt"

# load data from Electric Power Consuption
rawData <- load.data(url)


# Merge Date and Time columns into a single Date format variable
tmp <- paste(rawData$Date, rawData$Time)
data <- cbind(Date = tmp, rawData[3:9])
data$Date <- strptime(data$Date, format = "%d/%m/%Y %H:%M:%S")


# subset the dataset to the given days
initialDate <- as.POSIXlt("2007-02-01")
finalDate <- as.POSIXlt("2007-02-03")
subset <- data$Date >= initialDate & data$Date <= finalDate & !is.na(data$Date)
data <- data[subset, ]

# Generate Plot4 according the given assignment chart
plot4(data)




