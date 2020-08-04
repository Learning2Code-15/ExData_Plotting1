#Plot 3

if(!dir.exists("data")) { dir.create("data") }

# Download and unzip data file
file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
    download.file(file.url, file.path)
    unzip(file.path, exdir = "data")
}

#read file. Remove na values and set the data type for each colomn 
plotdata=read.table("data/household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#convert date colomn to type Date
plotdata$Date=as.Date(plotdata$Date,"%d/%m/%Y")

#Select data for date between Feb 1 2007 to Feb 2 2007
plotdata=plotdata[(plotdata$Date=="2007-02-01") | (plotdata$Date=="2007-02-02"),]

#Add field with date and time in date time field
plotdata$datetime=as.POSIXct(paste(plotdata$Date,plotdata$Time))

# Plot line graph with y axis, different colors and lines for sub metering 1,2,3 values and legend
plot(Sub_metering_1~datetime,plotdata,type="l",xlab=NA, ylab = "Energy sub metering")
lines(plotdata$Sub_metering_2~plotdata$datetime,col="red")
lines(plotdata$Sub_metering_3~plotdata$datetime,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=1,xjust = 1)

# Save as png file
dev.copy(png,"plot3.png",width = 480,height = 480)
dev.off()