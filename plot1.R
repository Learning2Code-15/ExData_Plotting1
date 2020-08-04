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

# Plot histogram with x axis titles color as red and title values
hist(plotdata$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

# Save as png file
dev.copy(png,"plot1.png",width = 480,height = 480)
dev.off()