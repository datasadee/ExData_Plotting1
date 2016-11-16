plot3 <- function(){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##Get data source Url
  temp <- tempfile() ##Create a temp file to store the downloaded zip file
  download.file(fileUrl,temp) ##Download 
  unzip(temp, exdir = "EPC.dat") ##unzip file to EPC.dat
  unlink(temp) ##remove temp
  dir <- "./EPC.dat/household_power_consumption.txt" ##Store the location of the data file
  EPC <- read.table(dir, sep = ";", na.strings = "?", header = TRUE) ##read the whole data file
  EPCData <- subset(EPC, Date == "1/2/2007" | Date == "2/2/2007") ##subset file with date 02/01/2007 and 02/02/2007
  EPCDT = data.table(EPCData) ##Convert data.frame to data.table
  EPCDT[, DataTime := as.POSIXct(paste(EPCDT$Date, EPCDT$Time), format = "%d/%m/%Y %H:%M:%S")] ##Create a new column that merge Date and Time information
  with(EPCDT, plot(DataTime, Sub_metering_1, type = "l", col = "black", xaxt="n", ylab="Energy sub metering")) ##Draw 2D graph with no x-axis
  with(EPCDT, points(DataTime, Sub_metering_2, type = "l", col = "red", xaxt="n"))
  with(EPCDT, points(DataTime, Sub_metering_3, type = "l", col = "blue", xaxt="n"))
  legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering-2", "Sub_metering_3"), lwd=2)##Add label on topright cornor
  axis(1, at = c(EPCDT[1,DataTime], EPCDT[1440, DataTime], EPCDT[2880, DataTime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  dev.copy(png, "plot2.png") ##copy figure on screen to png file 
  dev.off() ##close png device
}