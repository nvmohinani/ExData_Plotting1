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
hist(dataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
