plot1 <- function(){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ##Get data source Url
  temp <- tempfile() ##Create a temp file to store the downloaded zip file
  download.file(fileUrl,temp) ##Download 
  unzip(temp, exdir = "EPC.dat") ##unzip file to EPC.dat
  unlink(temp) ##remove temp
  dir <- "./EPC.dat/household_power_consumption.txt" ##Store the location of the data file
  EPC <- read.table(dir, sep = ";", na.strings = "?", header = TRUE) ##read the whole data file
  EPCData <- subset(EPC, Date == "1/2/2007" | Date == "2/2/2007") ##subset file with date 02/01/2007 and 02/02/2007
  hist(EPCData$Global_active_power, col = "red", main = "Global_active_Power", xlab = "Global Active Power(kilowatts)") #draw 1D histgraph
  dev.copy(png, "plot1.png") ##copy figure on screen to png file "plot1.png"
  dev.off() ##close png device
}
