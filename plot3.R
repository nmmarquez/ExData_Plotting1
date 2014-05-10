#get dat file dawg
temp <- tempfile()
download.file (paste0 ('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fh', 
                       'ousehold_power_consumption.zip'),
               dest = temp, method = 'curl')
f <- unzip (temp, list = T) ["Name"]
epc <- read.table (unz (temp, f), na.strings = "?", sep = ";", header = TRUE)
unlink (temp)

head (epc)
names (epc)

epc$DT <- paste (epc$Date, epc$Time)
epc$DT <- strptime (epc$DT, format = "%d/%m/%Y %H:%M:%S")
epc$Date <- as.Date (epc$Date, format = "%d/%m/%Y")

epc.feb <- subset (epc, Date == as.Date ("2007-02-01") | 
                       Date == as.Date ("2007-02-02"))
head (epc.feb)

plot (epc.feb$DT, epc.feb$Sub_metering_1, type = "n",
      xlab = "", ylab = "Energy sub metering")
lines (epc.feb$DT, epc.feb$Sub_metering_1, col = "black")
lines (epc.feb$DT, epc.feb$Sub_metering_2, col = "red")
lines (epc.feb$DT, epc.feb$Sub_metering_3, col = "blue")
legend ("topright", legend = names (epc.feb) [7:9],
        col = c("black", "red", "blue"), lty = 1)

d = '~/Dropbox/Data_Sci/Exploratory Data Analysis/week 1/ExData_Plotting1/'

png (paste0 (d,"plot3.png"))
plot (epc.feb$DT, epc.feb$Sub_metering_1, type = "n",
      xlab = "", ylab = "Energy sub metering")
lines (epc.feb$DT, epc.feb$Sub_metering_1, col = "black")
lines (epc.feb$DT, epc.feb$Sub_metering_2, col = "red")
lines (epc.feb$DT, epc.feb$Sub_metering_3, col = "blue")
legend ("topright", legend = names (epc.feb) [7:9],
        col = c("black", "red", "blue"), lty = 1)
dev.off()
