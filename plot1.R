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
plot1 <- function(data) {
    png(file = "plot1.png", width = 480, height = 480, units = "px")
    hist(data$Global_act, main = "Global Active Power", col = "red", xlab = "Global Active Power (Kilowatts)")
    dev.off()
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

# Generate Plot1 according the given assignment chart
plot1(data)




