#Plot 4

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

par(mfrow=c(2,2),mar=c(4,4,1,1))
#Plot1

plot(Global_active_power~datetime,plotdata,type="l",xlab="", ylab = "Global Active Power")

#Plot2

plot(Voltage~datetime,plotdata,type="l",xlab="datetime", ylab = "Voltage")

#Plot3

plot(Sub_metering_1~datetime,plotdata,type="l",xlab=NA, ylab = "Energy sub metering")
lines(plotdata$Sub_metering_2~plotdata$datetime,col="red")
lines(plotdata$Sub_metering_3~plotdata$datetime,col="blue")
legend("topright",c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "),col = c("black","red","blue"),lty=1,text.width = 80000,y.intersp = 0.5,x.intersp = 0.5,seg.len = 0.75,bty="n")

#Plot4

plot(Global_reactive_power~datetime,plotdata,type="l",xlab="datetime", ylab = "Global_reactive_power")


# Save as png file
dev.copy(png,"plot4.png",width = 480,height = 480)
dev.off()