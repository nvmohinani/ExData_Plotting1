dataset <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

dataset <- subset(dataset, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dataset  <- dataset[complete.cases(dataset), ]

dateTime <- paste(dataset$Date, dataset$Time)
dateTime <- setNames(dateTime, "DateTime")
dataset <- dataset[ ,!names(dataset) %in% c("Date", "Time")]
dataset <- cbind(dateTime, dataset)
dataset$dateTime <- strptime(dataset$dateTime, format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot(dataset$dateTime, dataset$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(dataset$dateTime, dataset$Voltage, type="l", ylab = "Voltage (volt)", xlab = "")

plot(dataset$dateTime, dataset$Sub_metering_1, type="l", ylab = "Global Active Power(kilowatts)", xlab = "")    
lines(dataset$dateTime, dataset$Sub_metering_2, col = "red", type = "l")
lines(dataset$dateTime, dataset$Sub_metering_3, col = "blue", type = "l")
legend("topright", col=c("black", "red", "blue"), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = c(0.5, 0.5, 0.5))

plot(dataset$dateTime, dataset$Global_reactive_power, type="l", ylab = "Global Reactive Power (kilowatts)", xlab = "")

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
