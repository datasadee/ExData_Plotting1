plot4 <- function(){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##Get data source Url
  temp <- tempfile() ##Create a temp file to store the downloaded zip file
  download.file(fileUrl,temp) ##Download 
  unzip(temp, exdir = "EPC.dat") ##unzip file to EPC.dat
  unlink(temp) ##remove temp
  dir <- "./EPC.dat/household_power_consumption.txt" ##Store the location of the data file
  EPC <- read.table(dir, sep = ";", na.strings = "?", header = TRUE) ##read the whole data file
  EPCData <- subset(EPC, Date == "1/2/2007" | Date == "2/2/2007") ##subset file with date 02/01/2007 and 02/02/2007
  EPCDT = data.table(EPCData) ##Convert data.frame to data.table
  EPCDT[, datetime := as.POSIXct(paste(EPCDT$Date, EPCDT$Time), format = "%d/%m/%Y %H:%M:%S")] ##Create a new column that merge Date and Time information
  
  par(mfrow = c(2, 2))
  
  with(EPCDT, plot(datetime, Global_active_power, type = "l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)"))
  axis(1, at = c(EPCDT[1,datetime], EPCDT[1440, datetime], EPCDT[2880, datetime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  
  with(EPCDT, plot(datetime, Voltage, type = "l", xaxt="n", xlab = "datetime", ylab="Global Active Power (kilowatts)"))
  axis(1, at = c(EPCDT[1,datetime], EPCDT[1440, datetime], EPCDT[2880, datetime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  
  with(EPCDT, {
    plot(datetime, Sub_metering_1, type = "l", col = "black", xaxt="n", xlab="", ylab="Energy sub metering") ##Draw 2D graph with no x-axis
    points(datetime, Sub_metering_2, type = "l", col = "red", xaxt="n")
    points(datetime, Sub_metering_3, type = "l", col = "blue", xaxt="n")
  })
  legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering-2", "Sub_metering_3"), lwd=0.5, cex=0.7)##Add label on topright cornor
  axis(1, at = c(EPCDT[1,datetime], EPCDT[1440, datetime], EPCDT[2880, datetime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  
  
  with(EPCDT, plot(datetime, Global_reactive_power, type = "l", xaxt="n", xlab = "datetime", ylab="Global Active Power (kilowatts)"))
  axis(1, at = c(EPCDT[1,datetime], EPCDT[1440, datetime], EPCDT[2880, datetime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  
  dev.copy(png, "plot4.png") ##copy figure on screen to png file 
  dev.off() ##close png device
}