dataset <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

dataset <- subset(dataset, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dataset  <- dataset[complete.cases(dataset), ]

dateTime <- paste(dataset$Date, dataset$Time)
dateTime <- setNames(dateTime, "DateTime")
dataset <- dataset[ ,!names(dataset) %in% c("Date", "Time")]
dataset <- cbind(dateTime, dataset)
dataset$dateTime <- strptime(dataset$dateTime, format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1))

plot(dataset$dateTime, dataset$Sub_metering_1, type="l", ylab = "Global Active Power(kilowatts)", xlab = "")    
lines(dataset$dateTime, dataset$Sub_metering_2, col = "red", type = "l")
lines(dataset$dateTime, dataset$Sub_metering_3, col = "blue", type = "l")
legend("topright", col=c("black", "red", "blue"), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()
