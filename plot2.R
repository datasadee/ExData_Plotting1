plot2 <- function(){
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
  plot(EPCDT$datetime, EPCDT$Global_active_power, type = "l", xaxt="n", xlab = " ", ylab="Global Active Power (kilowatts)") ##Sub_metering_1
  axis(1, at = c(EPCDT[1,datetime], EPCDT[1440, datetime], EPCDT[2880, datetime]), labels = c("Thu", "Fri", "Sat")) ## add x-axis
  dev.copy(png, "plot2.png") ##copy figure on screen to png file 
  dev.off() ##close png device
}