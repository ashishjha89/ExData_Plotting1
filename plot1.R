library(lubridate)
# Read the full table
power.consumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
# Change the type to date
power.consumption[, "Date"] <- dmy(power.consumption[, "Date"])
# Extract only the required data
power.consumption.data <- power.consumption[power.consumption[, "Date"]==ydm('2007-01-02') | power.consumption[, "Date"]==ydm('2007-02-02'), ]
# Clear the original data
rm(power.consumption)

# Initially detected as factor class - so first change to charecter and then to numeric (Direct change to numeric gives frequency count in factor)
power.consumption.data[, "Global_active_power"] <- as.character(power.consumption.data[, "Global_active_power"])
power.consumption.data[, "Global_active_power"] <- as.numeric(power.consumption.data[, "Global_active_power"])

# Draw plot
dev.new()
hist(power.consumption.data[, "Global_active_power"], col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Copy it to png
dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")

# Make device off
dev.off()