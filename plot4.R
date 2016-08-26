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

# Create an extra column 'date.time' to store date-time for each observation
power.consumption.data$data.time <- strptime(paste(power.consumption.data[, "Date"], power.consumption.data[, "Time"]), format="%Y-%m-%d %H:%M:%S")

# Convert Sub_metering to numeric type
power.consumption.data[, "Sub_metering_1"] <- as.numeric(as.character(power.consumption.data[, "Sub_metering_1"]))
power.consumption.data[, "Sub_metering_2"] <- as.numeric(as.character(power.consumption.data[, "Sub_metering_2"]))
power.consumption.data[, "Sub_metering_3"] <- as.numeric(as.character(power.consumption.data[, "Sub_metering_3"]))

# Draw plot
dev.new()

# Configure number of plots and direction of drawing plots (2*2 column wise)
par(mfcol = c(2,2))

# 1
plot(power.consumption.data[,"data.time"], power.consumption.data[, "Global_active_power"], ylab = "Global Active Power", xlab = "", type="l")

# 2
plot(power.consumption.data[,"data.time"], power.consumption.data[, "Sub_metering_1"], ylab = "Energy sub metering", xlab = "", type="l")
lines(power.consumption.data[,"data.time"], power.consumption.data[, "Sub_metering_2"], col = "red")
lines(power.consumption.data[,"data.time"], power.consumption.data[, "Sub_metering_3"], col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1)

# 3
power.consumption.data[,"Voltage"] <- as.numeric(as.character(power.consumption.data[,"Voltage"]))
plot(power.consumption.data[,"data.time"], power.consumption.data[, "Voltage"], xlab = "datetime", ylab = "Voltage", type="l")

# 4
power.consumption.data[,"Global_reactive_power"] <- as.numeric(as.character(power.consumption.data[,"Global_reactive_power"]))
plot(power.consumption.data[,"data.time"], power.consumption.data[, "Global_reactive_power"], xlab = "datetime", ylab = "Global_reactive_power", type="l")

# Copy it to png
dev.copy(png, file="plot4.png", width = 480, height = 480, units = "px")

# Make device off
dev.off()